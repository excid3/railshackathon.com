class Service < ApplicationRecord
  belongs_to :user

  Devise.omniauth_configs.keys.each do |provider|
    scope provider, ->{ where(provider: provider) }
  end

  def username
    auth.dig("info", "nickname")
  end

  def expired?
    expires_at? && expires_at <= Time.zone.now
  end

  def token
    renew_token! if expired?
    access_token
  end

  def renew_token!
    new_token = current_token.refresh!
    update(
      access_token: new_token.token,
      refresh_token: new_token.refresh_token,
      expires_at: Time.at(new_token.expires_at)
    )
  end

  def refresh_auth_hash
    renew_token! if expired?

    omniauth = strategy
    omniauth.access_token = current_token

    update(self.class.attributes_from_omniauth(omniauth.auth_hash))
  end

  def current_token
    OAuth2::AccessToken.new(
      strategy.client,
      access_token,
      refresh_token: refresh_token
    )
  end

  # return an OmniAuth::Strategies instance for the provider
  def strategy
    OmniAuth::Strategies.const_get(OmniAuth::Utils.camelize(provider)).new(
      nil,
      Rails.application.credentials.dig(:github, :oauth_client_id),
      Rails.application.credentials.dig(:github, :oauth_client_secret),
    )
  end

  def self.attributes_from_omniauth(auth)
    expires_at = auth.credentials.expires_at.present? ? Time.at(auth.credentials.expires_at) : nil
    {
      provider: auth.provider,
      uid: auth.uid,
      expires_at: expires_at,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      auth: auth.to_hash
    }
  end
end
