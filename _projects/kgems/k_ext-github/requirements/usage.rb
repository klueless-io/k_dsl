# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true

    row :sample         , :sample_classes         , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'List all repositories', <<~TEXT, ruby: <<~RUBY
      Get a list of all repositories linked to this personal access token
    TEXT
      pat = KExt::Github.configuration.personal_access_token
      api = KExt::Github::Api.new(token: pat)

      repos = api.repositories

      KExt::Github::Printer.repositories_as_table(repos)
    RUBY

    row :basic_example, 'List all', <<~TEXT
      ![List Repos](docs/images/list-repositories.png)
    TEXT

    row :basic_example, 'List repositories for specific organization', <<~TEXT, ruby: <<~RUBY
      Get a list of repositories for the organization **klueless-csharp-samples** linked to this personal access token
    TEXT
      pat = KExt::Github.configuration.personal_access_token
      api = KExt::Github::Api.new(token: pat)

      repos = api.organization_repositories('klueless-csharp-samples')

      KExt::Github::Printer.repositories_as_table(repos)
    RUBY

    row :basic_example, 'List repos by organization', <<~TEXT
      ![List Repos](docs/images/list-repositories-for-organization.png)
    TEXT

    row :sample, 'Simple example', <<~TEXT, ruby: <<~RUBY
        Description for a simple example that shows up in the USAGE.MD
      TEXT
        class SomeRuby
          def initialize
          end
        end
      RUBY

  end
end
