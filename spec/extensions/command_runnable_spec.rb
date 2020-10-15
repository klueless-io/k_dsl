# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::CommandRunable do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:run_command) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::CommandRunable) }

        it { is_expected.to respond_to(:run_command) }

        describe '#run_command' do
          subject { document.run_command nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('Run command skipped: Document not linked to a project')
              subject
            end
          end
        end
      end
    end
  end

  context 'real document' do
    let(:project) { KDsl::Manage::Project.new('app_name', config) }
    let(:config) do
      KDsl::Manage::ProjectConfig.new do
        base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls')
      end
    end
    let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'fakeresource.txt') }
    let(:microapp1) do
      KDsl.microapp('app1') do
        settings do
          app_path "#{Dir.getwd}/spec/.output/abc"
        end
      end
    end

    context 'run a command' do
      before do
        # Load Data
        microapp1.execute_block
        # Load Data
        document.execute_block
        # Add documents into project via resource
        resource.add_documents(microapp1, document)
      end

      context 'when command expects the folder to exist' do
        let(:document) do
          KDsl.document('run') do
            actions do
              run_command 'echo "david" > test1.txt'
            end
          end
        end

        it 'create the microapp output folder and then run command that creates a file' do
          # resource.debug(:resource, :document)
          path = microapp1.data_struct.settings.app_path

          output_file = File.join(path, 'test1.txt')
          FileUtils.rm_rf(path) if File.directory?(path)

          document.execute_block(run_actions: true)
          expect(File.exist?(output_file)).to be_truthy
          expect(File.read(output_file)).to start_with('david')
          FileUtils.rm_rf(path) if File.directory?(path)
        end
      end

      context 'when command manages its own folder creation' do
        let(:document) do
          KDsl.document('run') do
            actions do
              run_command 'mkdir abc && cd abc && echo "david" > test2.txt', command_creates_top_folder: true
            end
          end
        end

        it 'create the microapp output folder and then run command that creates a file' do
          # resource.debug(:resource, :document)
          path = microapp1.data_struct.settings.app_path

          output_file = File.join(path, 'test2.txt')
          FileUtils.rm_rf(path) if File.directory?(path)

          document.execute_block(run_actions: true)
          expect(File.exist?(output_file)).to be_truthy
          expect(File.read(output_file)).to start_with('david')
          FileUtils.rm_rf(path) if File.directory?(path)
        end
      end
    end
  end
end
