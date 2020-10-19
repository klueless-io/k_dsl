# frozen_string_literal: true

module ConnectedApplicationCommands
  class Create
    include Interactor
    include Ensure

    delegate :access_token,
             :refresh_token,
             :identity,
             :connected_application,
             :provider, to: :context

    def call
      ensure_context_includes :identity, :access_token, :provider

      context.connected_application = ConnectedApplication.new(
        identity: identity,
        provider: provider,
        name: name,
        access_token: access_token,
        refresh_token: refresh_token
      )

      context.fail!(message: 'Could not connect application') unless connected_application.save
    end

    private

    def name
      if provider == 'github'
        user = ConnectedApplications.build_api_client(:github, access_token: access_token).user
        user[:login]
      end
    end
  end
end
