# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'DSL Sample Documents' do
  describe '#simple document' do
    let(:document) do
      KDsl::Model::Document.new(:simple) do
        settings do
          field1 'Some Text'
          field2 999
          field3 true
        end
        table do
          fields [:name, f(:age, 30, 'Integer'), f(:manager, false, 'Boolean')]

          row 'David', 48, true
          row 'Alison'
          row 'Bob', manager: true
        end
      end
    end

    # it { puts JSON.pretty_generate document.data }
  end

  describe '#multiple setting groups' do
    let(:document) do
      KDsl::Model::Document.new(:simple) do
        settings do
          field1 'Some Text'
          field2 999
          field3 true
        end
        settings :more_settings do
          field1 'Some Other Text'
        end
      end
    end

    # it { puts JSON.pretty_generate document.data }
  end

  describe '#simple document' do
    let(:document) do
      KDsl::Model::Document.new(:simple) do
        table do
          fields [:name, f(:age, 30, 'Integer'), f(:manager, false, 'Boolean')]

          row 'David', 48, true
          row 'Alison'
          row 'Bob', manager: true
        end
      end
    end

    it { puts JSON.pretty_generate document.data }
  end
end
