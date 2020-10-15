# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::TemplateRendering::TemplateHelper do
  
  let(:data) { { name: 'David' } }
  let(:subject) { described_class.process_template(template, data) }
  
  describe 'basic template' do
    context 'process template' do
      let(:template) { '{{name}} was here' }

      it { expect(subject).to include('David was here') }
    end
  end
end
  