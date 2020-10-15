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

  context 'initialize project' do
    before do
      manager.add_project(project)
      manager.register_all_resource_documents
      manager.load_all_documents

      document.execute_block
      resource.add_documents(document)
    end

    describe 'create microapps' do
      
      describe 'ruby_commandlet' do
        let(:document) do
          KDsl.document('new_dsl') do
            actions do
              new_microapp 'k_swimtracker', definition_name: :ruby_cmdlet, output_subfolder: 'swimtracker'
            end
          end
        end

        # new_microapp s.name, definition_name: :ruby_cmdlet  , output_folder: s.output_folder, f: true, base_path: s.base_path
        context 'has valid document' do
          subject { project.get_resource_document(key).document }

          let(:key) { :new_dsl }

          # it do
          #   manager.debug(format: :detail, project_formats: [:resource_document])
          # end

          it { is_expected.not_to be_nil }
          # it { is_expected.to be_a(KDsl::Model::Document) }
          # it { debug }
          # it { debug_document(key) }
          # fit { run(key) }
        end
      end
    end
  end
end