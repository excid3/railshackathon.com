Convertkit.configure do |config|
  config.api_key = Rails.application.credentials.dig(:convertkit, :api_key)
  config.api_secret = Rails.application.credentials.dig(:convertkit, :api_secret)
end
