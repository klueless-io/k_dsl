require 'spec_helper'

# ----------------------------------------------------------------------
# GitHub API integration tests
#
# NOTE: Turn on integration tests using the following command in spec_helper
#   config.filter_run_excluding :integration_tests => false
# ----------------------------------------------------------------------
RSpec.describe Github::GithubApi, :integration_tests do

  let(:api) { Github::GithubApi.new(token: KDsl::Manage::ProjectConfig.new.github_personal_access_token) }
  let(:api_delete) { Github::GithubApi.new(token: KDsl::Manage::ProjectConfig.new.github_personal_access_token_delete) }

  let(:sample_repo) { 'klueless-io/z-test-aerial.com' }
  let(:test_repo_full_key) { 'klueless-io/z-test-kdsl' }
  let(:test_repo) { 'z-test-kdsl' }

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do

    # it 'should print test data' do
    #
    #   print_data_set
    #
    #   expect(1).to eq(1)
    # end                             if AppService::SHOULD_PRINT_TEST_DATA

    it 'should instantiate' do
      git_api = Github::GithubApi.new

      expect(git_api).to_not be_nil
    end

  end

  # --------------------------------------------------------------------------------
  # GIT HUB Tests
  # --------------------------------------------------------------------------------

  context "authenticate" do

    # xit 'can authenticate with username/password' do
    #
    #   git_api = Github::GithubApi.new
    #
    #   git_api.auth(login: 'david@ideasmen.com.au', password: 'ADD VALID PASSWORD')
    #
    #   expect(git_api.client).to_not be_nil
    #   expect(git_api.client.user).to_not be_nil
    #   expect(git_api.client.user.name).to eq('David Cruwys')
    #
    # end

    it 'can authenticate with personal access token' do

      git_api = Github::GithubApi.new

      # https://github.com/settings/tokens/new
      client_id = KDsl::Manage::ProjectConfig.new.github_personal_access_token

      git_api.auth(token: client_id)

      expect(git_api.client).to_not be_nil
      expect(git_api.client.user).to_not be_nil
      expect(git_api.client.user.name).to eq('David Cruwys')

    end
    #
    # it 'should instantiate and auth with username/password' do
    #   git_api = Github::GithubApi.new(login: 'david@ideasmen.com.au', password: 'ADD VALID PASSWORD')
    #
    #   expect(git_api.client).to_not be_nil
    #   expect(git_api.client.user).to_not be_nil
    #   expect(git_api.client.user.name).to eq('David Cruwys')
    # end

    it 'should instantiate and auth with personal access token' do
      git_api = Github::GithubApi.new(token: KDsl::Manage::ProjectConfig.new.github_personal_access_token)

      expect(git_api.client).to_not be_nil
      expect(git_api.client.user).to_not be_nil
      expect(git_api.client.user.name).to eq('David Cruwys')
    end

  end

  describe 'repositories' do

    it 'get list of repositories' do

      repos = api.repositories

      expect(repos.count).to be > 0

      # Github::GithubPrinter::p_repositories_as_table repos
    end

    it 'create a repositories' do
      # Github::GithubPrinter::p_repositories_as_table api.repositories

      api_delete.delete_repository(test_repo_full_key)
      repo = api.create_repository(test_repo)

      expect(repo).to_not be_nil

      # puts repo.inspect

      # Github::GithubPrinter::p_repositories_as_table api.repositories
    end

    # it "creates a repository for an organization" do
    #   repository = @client.create_repository("an-org-repo", :organization => test_github_org)
    #   expect(repository.name).to eq("an-org-repo")
    #   assert_requested :post, github_url("/orgs/#{test_github_org}/repos")
    #
    #   # cleanup
    #   begin
    #     @client.delete_repository("#{test_github_org}/an-org-repo")
    #   rescue Octokit::NotFound
    #   end
    # end

    it 'delete a repositories' do

      # Github::GithubPrinter::p_repositories_as_table api.repositories

      repo = api_delete.delete_repository(test_repo_full_key)

      # Github::GithubPrinter::p_repositories_as_table api.repositories
    end

  end

  # xdescribe 'repository hooks' do

  #   it 'get list of hooks on repository' do

  #     hooks = api.hooks(sample_repo)

  #     if hooks.count == 0
  #       L.info 'No webhooks found for repository'
  #     else
  #       Github::GithubPrinter::p_hooks_as_table hooks
  #     end

  #     # L.json hooks.first.config
  #   end

  #   it 'remove repository hooks' do
  #     hooks = api.remove_hooks(sample_repo)
  #   end

  #   it 'remove repository hooks one by one' do

  #     hooks = api.hooks(sample_repo)

  #     # L.heading 'before'
  #     # Github::GithubPrinter::p_hooks_as_table hooks

  #     hooks.each do |hook|
  #       api.remove_hook(repo, hook.id)
  #     end

  #     # L.heading 'after'
  #     # hooks = api.hooks(repo)
  #     # Github::GithubPrinter::p_hooks_as_table hooks

  #   end

  # end

end
