module Github

  class GithubPrinter

    # ---------------------------------------------
    # Print Repositories
    # ---------------------------------------------

    def self.p_repositories(rows = nil, format = 'default')

      L.block 'Repositories'

      if (rows.nil?)
        Repository.all.each do |r|
          p_repository_with_format(r, format)
        end
      else
        rows.each do |r|
          p_repository_with_format(r, format)
        end
      end
    end

    def self.p_repositories_as_table(rows = nil, format = 'default')

      L.block 'Repositories'

      if (rows.nil?)
        rows = Repository.all
      end

      case format
      when 'detailed'
        # tp rows
        tp rows, :id, :node_id, :name, :full_name, :private, :description, :url, :created_at, :updated_at, :pushed_at, :git_url
      else
        tp rows, :id, :name, :git_url, :full_name, :private, :description, :url
      end
    end

    def self.p_repository_with_format(r, format)
      case format
      when 'detailed'
        p_repository_detailed(r)
      else
        p_repository(r)
      end
    end

    def self.p_repository(r)
      L.kv 'id', r.id
      L.kv 'node_id', r.node_id
      L.kv 'name', r.name
      L.kv 'full_name', r.full_name
      L.kv 'private', r.private
      L.kv 'description', r.description
      L.kv 'url', r.url
      L.kv 'created_at', r.created_at
      L.kv 'updated_at', r.updated_at
      L.kv 'pushed_at', r.pushed_at
      L.kv 'git_url', r.git_url
      L.line
    end

    def self.p_repository_detailed(r)
      L.kv 'id', r.id
      L.kv 'node_id', r.node_id
      L.kv 'name', r.name
      L.kv 'full_name', r.full_name
      L.kv 'private', r.private
      L.kv 'description', r.description
      L.kv 'url', r.url
      L.kv 'created_at', r.created_at
      L.kv 'updated_at', r.updated_at
      L.kv 'pushed_at', r.pushed_at
      L.kv 'git_url', r.git_url

      # Print Relations

      L.line
    end

    # ---------------------------------------------
    # Print Hooks
    # ---------------------------------------------

    def self.p_hooks(rows = nil, format = 'default')

      L.block 'Hooks'

      if (rows.nil?)
        Hook.all.each do |r|
          p_hook_with_format(r, format)
        end
      else
        rows.each do |r|
          p_hook_with_format(r, format)
        end
      end
    end

    def self.p_hooks_as_table(rows = nil, format = 'default')

      L.block 'Hooks'

      if (rows.nil?)
        rows = Hook.all
      end

      case format
      when 'detailed'
        tp rows, :type, :id, :name, :active, :events, :config, :updated_at, :created_at, :url, :test_url, :ping_url, :last_response
      else
        tp rows, :type, :id, :name, :active, :url, :config
      end
    end

    def self.p_hook_with_format(r, format)
      case format
      when 'detailed'
        p_hook_detailed(r)
      else
        p_hook(r)
      end
    end

    def self.p_hook(r)
      L.kv 'type', r.type
      L.kv 'id', r.id
      L.kv 'name', r.name
      L.kv 'active', r.active
      L.kv 'events', r.events
      L.kv 'config', r.config
      L.kv 'updated_at', r.updated_at
      L.kv 'created_at', r.created_at
      L.kv 'url', r.url
      L.kv 'test_url', r.test_url
      L.kv 'ping_url', r.ping_url
      L.kv 'last_response', r.last_response
      L.line
    end

    def self.p_hook_detailed(r)
      L.kv 'type', r.type
      L.kv 'id', r.id
      L.kv 'name', r.name
      L.kv 'active', r.active
      L.kv 'events', r.events
      L.kv 'config', r.config
      L.kv 'updated_at', r.updated_at
      L.kv 'created_at', r.created_at
      L.kv 'url', r.url
      L.kv 'test_url', r.test_url
      L.kv 'ping_url', r.ping_url
      L.kv 'last_response', r.last_response

      # Print Relations

      L.line
    end
    
  end
end