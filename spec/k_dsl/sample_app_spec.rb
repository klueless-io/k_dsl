# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Run Sample Applications' do
  before { KDsl.setup }
  after { KDsl.teardown }

  let(:manager) { KDsl.project_manager }

  # HELPERS
  def get(key, type = nil)
    project.get_resource_document(key, type).document
  end
  def run(key, type = nil)
    get(key, type).execute_block(run_actions: true)
  end
  def debug
    2.times { puts '' }
    manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])
  end
  def debug_document(key, type = nil)
    get(key, type).debug(include_header: true)
  end

  describe 'setup project manager' do
    before do
      manager.add_project(project)
      manager.register_all_resource_documents
      manager.load_all_documents
    end

    # xdescribe 'cmds' do
    #   context 'create new projects' do
    #     let(:key) { :ruby_cmdlet }
    #     let(:config) do
    #       KDsl::Manage::ProjectConfig.new do
    #         self.base_path = File.join(Dir.getwd, '_')
    #         self.base_resource_path = File.join(Dir.getwd, '_projects')
    #       end
    #     end
    #     let(:project) do
    #       KDsl::Manage::Project.new('new_project', config) do
    #         watch_path('cmd/**/*.rb')
    #       end
    #     end
    
    #     context 'has valid document' do
    #       subject { project.get_resource_document(key).document }
    
    #       it { run(key) }
    #     end
    #   end
    # end

    # May need a new sample project
    # describe 'ruby commandlet application' do
    #   context 'k_ymen project' do
    #     let(:config) do
    #       KDsl::Manage::ProjectConfig.new do
    #         self.base_path = File.join(Dir.getwd, '_')
    #         self.base_resource_path = File.join(Dir.getwd, '_projects', 'kcmd', 'k_ymen')
    #       end
    #     end
    #     let(:project) do
    #       KDsl::Manage::Project.new('k_ymen', config) do
    #         watch_path('**/*.rb')
    #       end
    #     end
    
    #     context 'has valid document' do
    #       subject { project.get_resource_document(key, type).document }

    #       let(:doc) { OpenStruct.new(key: :k_ymen, type: :microapp) }
    #       # let(:doc) { OpenStruct.new(key: :bootstrap, type: :blueprint) }
    
    #       # it { debug }
    #       it { run(doc.key, doc.type) }
    #     end
    #   end
    # end
  end
end