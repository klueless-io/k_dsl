# frozen_string_literal: true

module KDsl
  module Extensions
    module GithubLinkable
      # New Github Repo will create a new repository for the configured Github user
      def github_new_repo(repo_name, autoopen: true)
        return warn('New Github Repo skipped: Document not linked to a project') if !defined?(project) || project.nil?

        user_name = project.config.github_user
        token = project.config.github_personal_access_token

        repo_name = repo_name.to_s

        api = Github::GithubApi.new(token: token)
      
        begin
          repo = api.repositories.find { |r| r.name == repo_name }
          # Github::GithubPrinter::p_repositories_as_table [repo]
          git_link = "https://github.com/#{user_name}/#{repo_name}"

          if repo.nil?
            L.heading 'Repository create'
            repo = api.create_repository(repo_name)
            system("open -a 'Google Chrome' #{git_link}") if autoopen
          else
            L.heading 'Repository already exists'
          end

          L.kv 'SSH', "git@github.com:#{user_name}/#{repo_name}.git"
          L.kv 'HTTPS', "git@github.com:#{user_name}/#{repo_name}.git"
          L.kv 'GITHUB', KDsl::Util.data.console_hyperlink(git_link, git_link)
          
          # L.json repo.to_h
          repo
        rescue StandardError => error
          L.exception(error)
        end
      end

      def github_delete_repo(repo_name)
        return warn('Delete Github Repo skipped: Document not linked to a project') if !defined?(project) || project.nil?

        user_name = project.config.github_user
        token = project.config.github_personal_access_token_delete

        repo_name = repo_name.to_s
        repo_name_full_key = "#{user_name}/#{repo_name}"

        api = Github::GithubApi.new(token: token)
      
        begin
          L.heading 'Repository delete'
          api.delete_repository(repo_name_full_key)
          true
        rescue StandardError => error
          L.exception(error)
        end
      end

      # REFACT: This is a script for running a git hotfix
      #         location is all wrong, so it is just a quick fix for now
      def hotfix(message)
        run_command "./bin/khotfix '#{message}'"
      end
      alias hf hotfix
    end
  end
end
