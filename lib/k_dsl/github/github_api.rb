# The Github API provices some service methods for working against GitHub
module Github

  require 'octokit'

  class GithubApi
    include Virtus.model

    # attribute :client_id, String, :writer => :private
    # attribute :secret, String, :writer => :private

    # attribute :sites, Array[Netlify::Site], :writer => :private
    attribute :client, Octokit::Client, :writer => :private

    def self.instance(access_token)
      return GithubApi.new(token: access_token)
    end

    # Create API for communicating with GitHub
    #
    # Provide token OR login/password
    #
    # Create a token here
    # https://github.com/settings/tokens/new
    #
    # @param [String] token
    # @param [String] login
    # @param [String] password
    def initialize(token: nil, login: nil, password: nil)

      if token.present? || login.present? || password.present?
        auth(token: token, login: login, password: password)
      end

    end

    # Authenticate against GitHub with username and password or token
    #
    # Provide token OR login/password
    #
    # Create a token here
    # https://github.com/settings/tokens/new
    # @param [String] token
    # @param [String] login
    # @param [String] password
    def auth(token: nil, login: nil, password: nil)

      raise 'Provide credentials. Token or username/password' if token.nil? && (login.nil? || password.nil?)

      if token.nil?
        self.client = Octokit::Client.new(login: login, password: password)
      else
        self.client = Octokit::Client.new(access_token: token)
      end

      # Fetch the current user
      # L.kv 'GitHub User', client.user.name

    end

    # --------------------------------------------------------------------------------
    # Service Actions
    # --------------------------------------------------------------------------------

    # list of repositories for this user
    #
    def repositories
      items = @client.repositories({}, query: {per_page: 100})

      return items.map { |item| Github::GithubRepository.new(item) }
    end

    # create repository
    #
    # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
    def create_repository(repository_name)
      @client.create_repository(repository_name)
    end

    # delete repository
    #
    # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
    def delete_repository(repository_name)
      @client.delete_repository(repository_name)
    end

    # list of hooks for repository
    #
    # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
    def hooks(repository_name)
      items = @client.hooks(repository_name)

      items .map { |item| Github::GithubHook.new(item) }
    end

    # remove hook from repository by id
    #
    # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
    # @param [Integer] id hook ID
    def remove_hook(repository_name, id)
      @client.remove_hook(repository_name, id)
    end

    # remove all hooks in a repository
    #
    # @param [String] repository_name e.g. klueless-io/z-test-aerial.com
    def remove_hooks(repository_name)
      hooks = hooks(repository_name)

      hooks.each do |hook|
        @client.remove_hook(repository_name, hook.id)
      end
    end

  end

end

