# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Sample for creating a New DSL' do
  before { KDsl.setup }
  after { KDsl.teardown }

  let(:manager) { KDsl.project_manager }
  let(:config) do
    KDsl::Manage::ProjectConfig.new do
      self.base_path = File.join(Dir.getwd, '_')
      self.base_resource_path = File.join(Dir.getwd, 'spec', '.output')
    end
  end
  let(:project) do
    KDsl::Manage::Project.new('sample_microapp', config) do
    end
  end
  let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'fakeresource.txt') }

  # HELPERS
  def get(key, type = nil)
    project.get_resource_document(key, type).document
  end
  def run(key, type = nil)
    get(key, type).execute_block(run_actions: true)
  end
  def debug
    2.times { puts '' }
    # manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])
    manager.debug(format: :detail, project_formats: [:resource_document])
  end
  def debug_document(key, type = nil)
    get(key, type).debug(include_header: true)
  end

  # MAKE THIS DRY
  # context 'debug' do
  #   # it { is_expected.not_to be_nil }
  #   # it { is_expected.to be_a(KDsl::Model::Document) }
  #   # it { debug }
  #   # it { debug_document(key) }
  # end

  context 'initialize project' do
    before do
      manager.add_project(project)
      manager.register_all_resource_documents
      manager.load_all_documents

      document.execute_block
      resource.add_documents(document)
    end

    describe 'ruby_commandlet' do
      
      subject { project.get_resource_document(key).document }
      let(:key) { :new_dsl }

      describe 'new microapp' do
        let(:document) do
          KDsl.document(key) do
            actions do
              new_microapp 'k_swimtracker',
                           definition_subfolder: :ruby_cmdlet,
                           show_editor: true, 
                           f: true
            end
          end
        end

        context 'run' do
          it { run(key) }
        end
      end

      describe 'new blueprint: bootstrap' do
        let(:document) do
          KDsl.document(key) do
            actions do
              settings do
                name 'k_swimtracker'
              end
                  
              new_structure 'bootstrap',
                            definition_subfolder: :ruby_cmdlet,
                            output_subfolder: 'k_swimtracker',
                            show_editor: true, 
                            f: true
            end
          end
        end

        context 'run' do
          it { run(key) }
        end
      end
    end
  end
end