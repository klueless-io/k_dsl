# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::ProjectConfig do
  let(:config) { described_class.new }

  describe '.base_dsl_path' do
    subject { config.base_dsl_path }

    context 'with default value' do
      it { is_expected.to eq(Dir.getwd) }
    end

    context 'when set' do
      before { config.base_dsl_path = '/some_folder' }

      it { is_expected.to eq('/some_folder') }
    end
  end

  describe '.base_data_path' do
    subject { config.base_data_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.data')) }

      context 'when base_dsl_path is altered' do
        before { config.base_dsl_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.data') }
      end
    end

    context 'when set' do
      before { config.base_data_path = '/Users/mydata' }

      it { is_expected.to eq('/Users/mydata') }
    end
  end

  describe '.base_definition_path' do
    subject { config.base_definition_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.definition')) }

      context 'when base_dsl_path is altered' do
        before { config.base_dsl_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.definition') }
      end
    end

    context 'when set' do
      before { config.base_definition_path = '/Users/my_definitions' }

      it { is_expected.to eq('/Users/my_definitions') }
    end
  end

  describe '.base_template_path' do
    subject { config.base_template_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.template')) }

      context 'when base_dsl_path is altered' do
        before { config.base_dsl_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.template') }
      end
    end

    context 'when set' do
      before { config.base_template_path = '/Users/my_templates' }

      it { is_expected.to eq('/Users/my_templates') }
    end
  end

  describe '.base_app_template_path' do
    subject { config.base_app_template_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.app_template')) }

      context 'when base_dsl_path is altered' do
        before { config.base_dsl_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.app_template') }
      end
    end

    context 'when set' do
      before { config.base_app_template_path = '/Users/my_app_templates' }

      it { is_expected.to eq('/Users/my_app_templates') }
    end
  end
end
