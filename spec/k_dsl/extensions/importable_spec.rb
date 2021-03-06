# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::Importable do
  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:import) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::Importable) }

        it { is_expected.to respond_to(:import) }

        describe '#import' do
          subject { document.import('key', 'type', 'namespace') }

          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('Import Skipped: Document not linked to a project')
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
    let(:resource) { KDsl::Resources::Resource.instance(project: project, file: 'somedata.txt') }

    describe '#import' do
      let(:document1) { KDsl::Model::Document.new :xmen }
      let(:document2) { KDsl::Model::Document.new :ymen, default_data: { somedata: 'found' } }
      let(:document) { document1 }

      context 'when importing a document does not exist' do
        subject { document.import(document2.key, document2.type, document2.namespace) }

        before { resource.add_document(document1)}

        it { expect { subject }.to raise_error('Could not import DSL: ymen_entity') }

        context 'when importing a document does not exist' do
          subject { document.import(document2.key, document2.type, document2.namespace) }
    
          before { resource.add_document(document2)}

          it { is_expected.to have_attributes( somedata: 'found' ) }
        end
      end
    end
  end
end
