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

    describe 'blueprint' do
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

    describe 'document with run command' do
      context 'when two microapps' do
        let(:project) do
          KDsl::Manage::Project.new('document_run_commands', config) do
            watch_path('dsl_microapp_basic.rb')
            watch_path('dsl_microapp.rb')
            watch_path('dsl_document_with_run_command.rb')
          end
        end

        context 'has valid run_command1 document' do
          subject { project.get_resource_document(key).document }

          let(:key) { :run_command1 }

          it { is_expected.not_to be_nil }
          it 'folder under .output called basic_app and then write hello.txt into that folder' do
            # expect(project.get_resource_document(key).document).to receive(:error).with('Run command currently supports single MicroApp projects only')
            # subject
            run(key)
          end
        end
      end
      context 'when one microapp' do
        let(:project) do
          KDsl::Manage::Project.new('document_run_commands', config) do
            watch_path('dsl_microapp_basic.rb')
            watch_path('dsl_document_with_run_command.rb')
          end
        end

        let(:output_file) { 'spec/.output/basic_app/hello.txt' }
        let(:output_path) { File.dirname(output_file) }

        context 'has valid run_command1 document' do
          subject { project.get_resource_document(key).document }

          let(:key) { :run_command1 }

          it { is_expected.not_to be_nil }
          it 'folder under .output called basic_app and then write hello.txt into that folder' do
            # L.kv 'output_path', output_path
            # L.kv 'output_file', output_file
            FileUtils.rm_rf(output_path)
            run(key)
            expect(File.exist?(output_file)).to be_truthy
            expect(File.read(output_file)).to start_with('hello world1')
            FileUtils.rm_rf(output_path)
          end
        end

        context 'has valid run_command2 document' do
          subject { project.get_resource_document(key).document }

          let(:key) { :run_command2 }

          it { is_expected.not_to be_nil }
          it 'This command will write hello.txt into a folder that is precreated: .output/basic_app' do
            # L.kv 'output_path', output_path
            # L.kv 'output_file', output_file
            # FileUtils.rm_rf(output_path)
            run(key)
            expect(File.exist?(output_file)).to be_truthy
            expect(File.read(output_file)).to start_with('hello world2')
            FileUtils.rm_rf(output_path)
          end
        end
      end
    end
  end
end