# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Extensions::CreateDsl do

  context 'fake document' do
    class FakeDocument; attr_accessor :resource; end

    context 'extension not loaded' do
      subject { document }

      let(:document) { FakeDocument.new }

      it { is_expected.not_to respond_to(:create_dsl) }

      context 'after extension loaded' do
        before { FakeDocument.include(KDsl::Extensions::CreateDsl) }

        it { is_expected.to respond_to(:create_dsl) }

        describe '#create_dsl' do
          subject { document.create_dsl nil, nil }
    
          context 'when document not linked to a project' do
            it 'will print a warning log message' do
              expect(document).to receive(:warn).with('CreateDSL Skipped: Document not linked to a project')
              subject
            end
          end
        end
      end
    end
  end
end
