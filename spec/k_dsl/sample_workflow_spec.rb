# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'DSL Sample Workflow' do
  before { KDsl.setup }
  after { KDsl.teardown }

  let(:manager) { KDsl.project_manager }
  let(:config) do
    KDsl::Manage::ProjectConfig.new do
      self.base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls', 'sample_workflows')
    end
  end

  def get(key, type)
    project.get_resource_document(key, type).document
  end
  def run(key, type)
    get(key, type).execute_block(run_actions: true)
  end
 
  def debug
    2.times { puts '' }
    manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])
  end
  def debug_document(key, type)
    get(key, type).debug(include_header: true)
  end

  context 'initialize project' do
    before do
      manager.add_project(project)
      manager.register_all_resource_documents
      # NOTE: import does not load the data correctly, to test turn of load_all_documents
      manager.load_all_documents
    end
    
    describe 'microapp' do
      let(:project) do
        KDsl::Manage::Project.new('sample_microapp', config) do
          watch_path('dsl_microapp.rb')
        end
      end

      context 'has valid document' do
        subject { project.get_resource_document(key, type).document }

        let(:key) { :spidy_expireddomains }
        let(:type) { :microapp }

        it { is_expected.not_to be_nil }
        it { is_expected.to be_a(KDsl::Model::Document) }
        # it { debug }
        # it { run(key, type) }
     end
    end

    fdescribe 'blueprint' do
      let(:project) do
        KDsl::Manage::Project.new('sample_blueprint', config) do
          watch_path('dsl_microapp.rb')
          watch_path('dsl_blueprint.rb')
        end
      end

      context 'has valid document' do
        subject { project.get_resource_document(key, type).document }

        let(:key) { :spidy_expireddomains }
        let(:type) { :blueprint }

        it { is_expected.not_to be_nil }
        it { is_expected.to be_a(KDsl::Model::BlueprintDocument) }
        it { debug }
        # it { run(key, type) }
        # it { debug_document(key, type) }
     end
    end
  end
end