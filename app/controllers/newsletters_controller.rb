class NewslettersController < ApplicationController
  def create
    Convertkit::Client.new.add_subscriber_to_form(
      Rails.application.credentials.dig(:convertkit, :form_id),
      params[:email]
    )

    redirect_to root_path, notice: "Check your email to confirm your newsletter subscription"
  end
end
