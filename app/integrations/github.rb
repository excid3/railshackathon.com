class Github
  def access_token
    Octokit::Client.new(bearer_token: jwt).create_app_installation_access_token(Rails.application.credentials.dig(:github, :installation_id))[:token]
  end

  def jwt
    payload = {
      iat: Time.now.to_i - 60, # issued at time
      exp: Time.now.to_i + (10 * 60),
      iss: Rails.application.credentials.dig(:github, :app_id)
    }
    JWT.encode(payload, private_key, "RS256")
  end

  def private_key
    @private_key ||= OpenSSL::PKey::RSA.new(private_pem)
  end

  def private_pem
    @private_pem ||= Rails.application.credentials.dig(:github, :private_pem)
  end
end
