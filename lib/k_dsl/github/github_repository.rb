module Github

  class GithubRepository
    include Virtus.model

    def initialize(attributes = nil)
      # Virtus will take your attributes and match them to the attribute definitions listed below
      super(attributes)
    end

    attribute :id, String
    attribute :node_id, String
    attribute :name, String
    attribute :full_name, String
    attribute :private, String
    attribute :description, String
    attribute :url, String
    attribute :created_at, String
    attribute :updated_at, String
    attribute :pushed_at, String
    attribute :git_url, String
  end

end