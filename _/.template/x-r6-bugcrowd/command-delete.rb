# frozen_string_literal: true

module ConnectedApplicationCommands
  class Delete
    include Interactor
    include Ensure

    delegate :connected_application, to: :context
    delegate :provider, :access_token, to: :connected_application

    def call
      ensure_context_includes :connected_application
      revoke_token!

      unless connected_application.destroy
        context.fail!(message: "Unable to delete connected application #{provider}")
      end
    end

    private

    def revoke_token!
      if provider == 'github'
        ConnectedApplications
          .build_api_client(provider, access_token: access_token)
          .revoke_token(access_token)
      end
    end
  end
end
