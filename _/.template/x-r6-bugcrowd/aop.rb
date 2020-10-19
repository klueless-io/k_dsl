# Aspect Oriented Programming Example

module ConnectedApplications
  class Oauth2ClientError < StandardError; end
  class Oauth2Client
    include ActiveModel::Model
    attr_accessor :redirect_uri, :client_id, :client_secret, :authorization

    def exchange_auth_code(_auth_code)
      api_guard! do
        # Do some code
      end
    end

    def authorize_url(_callback_url:, _state:)
      api_guard! do
        # Do some code
      end
    end

    def api_guard!
      yield
    rescue SocketError,
          OpenSSL::SSL::SSLError,
          Net::OpenTimeout,
          OAuth2::Error => error
      raise Oauth2ClientError, error.try(:description)
    end
  end
end
