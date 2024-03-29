class Discord
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::PolymorphicRoutes
  include ActionView::Helpers::NumberHelper

  attr_reader :entry

  def initialize(entry)
    @entry = entry
  end

  def post
    return if url.blank?
    HTTP.post(url, json: {embeds: [embeds]})
  end

  def embeds
    embed = {
      title: "New Entry: #{entry.title} by #{entry.team.name}",
      description: entry.description.to_plain_text.tr("\n", " ").truncate(300),
      built_with: entry.built_with.to_plain_text.tr("\n", " ").truncate(300),
      url: entry_url(entry),
      fields: [
          {
            name: "Website URL",
            value: entry.website_url,
            inline: true
          },
      ],
      color: 5814783
    }

    embed
  end

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  def url
    Rails.application.credentials.dig(:discord, :new_entry_url)
  end
end
