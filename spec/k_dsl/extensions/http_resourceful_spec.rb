# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::HttpResourceful do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:http_resource_to_file) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::HttpResourceful) }

        it { is_expected.to respond_to(:http_resource_to_file) }

        describe '#http_resource_to_file' do
          subject { document.http_resource_to_file }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('HTTP resource to file skipped: Document not linked to a project')
              subject
            end
          end
        end
      end
    end
  end

  context 'real document' do
    let(:config) do
      KDsl::Manage::ProjectConfig.new do
        base_resource_path = File.join(Dir.getwd, 'spec', 'factories', 'dsls')
      end
    end
    let(:project) { KDsl::Manage::Project.new('app_name', config) }
    let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'fakeresource.txt') }
    let(:microapp1) do
      KDsl.microapp('app1') do
        settings do
          app_path "#{Dir.getwd}/spec/.output"
        end
      end
    end
    let(:document) { KDsl::Model::Document.new :http_resourceful }

    describe '#http_resource_to_file' do
      subject { document.http_resource_to_file(url: url, target_folder: target_folder, target_file: target_file) }

      let(:url) { nil }
      let(:target_folder) { nil }
      let(:target_file) { nil }

      before do
        # Load Data
        microapp1.execute_block
        resource.add_documents(microapp1, document)
      end

      context 'when url is nil' do
        it { expect { subject }.not_to raise_error }
      end

      context 'with url' do
        let(:url) { 'https://raw.githubusercontent.com/klueless-html-samples/L04TranspilerBabel/master/src/test.js' }
        let(:expected_output_file) { "#{Dir.getwd}/spec/.output/abc.js" }

        it { expect { subject }.not_to raise_error }

        context 'with target_file' do
          let(:target_file) { 'abc.js' }

          after { File.delete(expected_output_file) }
    
          it 'download resource and write to file' do
            subject

            expect(File.exist?(expected_output_file)).to be_truthy
          end

          context 'and target_folder' do
            let(:target_folder) { 'xxx' }
            let(:expected_output_file) { "#{Dir.getwd}/spec/.output/xxx/abc.js" }
  
            it 'download resource and write to file in subfolder' do
              subject
  
              expect(File.exist?(expected_output_file)).to be_truthy
            end
          end
        end
      end
    end
  end
end
