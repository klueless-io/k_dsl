# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'DSL Sample Workflow' do
  before { KDsl.setup(log_level: KDsl::LOG_INFO) }
  after { KDsl.teardown }

  let(:project_name) { 'app_name' }
  let(:config) do
    KDsl::Manage::ProjectConfig.new do
      base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls', 'sample_workflows')
    end
  end

  describe 'microapp' do
    it do
      puts config.debug
    end
  end

end