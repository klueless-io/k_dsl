module Github

  class GithubHook
    include Virtus.model

    def initialize(attributes = nil)
      # Virtus will take your attributes and match them to the attribute definitions listed below
      super(attributes)
    end

    attribute :type, String
    attribute :id, String
    attribute :name, String
    attribute :active, String
    attribute :events, String
    attribute :config, Hash
    attribute :updated_at, String
    attribute :created_at, String
    attribute :url, String
    attribute :test_url, String
    attribute :ping_url, String
    attribute :last_response, String
  end

end