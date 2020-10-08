# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::ProjectConfig do
  let(:config) { described_class.new }

  describe '.base_path' do
    subject { config.base_path }

    context 'with default value' do
      it { is_expected.to eq(Dir.getwd) }
    end

    context 'when set' do
      before { config.base_path = '/some_folder' }

      it { is_expected.to eq('/some_folder') }
    end
    context 'when set via &block' do
      let(:config) do
        described_class.new do
          self.base_path = '/some_folder'
        end
      end

      it { is_expected.to eq('/some_folder') }
    end
    context 'when set via &block with variable' do
      let(:config) do
        described_class.new do |c|
          c.base_path = '/some_folder'
        end
      end

      it { is_expected.to eq('/some_folder') }
    end
  end

  describe '.base_resource_path' do
    subject { config.base_resource_path }

    context 'with default value' do
      it { is_expected.to eq(Dir.getwd) }
    end

    context 'when set' do
      before { config.base_resource_path = '/some_folder' }

      it { is_expected.to eq('/some_folder') }
    end
  end

  describe '.base_cache_path' do
    subject { config.base_cache_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.cache')) }

      context 'when base_path is altered' do
        before { config.base_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.cache') }
      end
    end

    context 'when set' do
      before { config.base_cache_path = '/Users/mydata' }

      it { is_expected.to eq('/Users/mydata') }
    end
  end

  describe '.base_definition_path' do
    subject { config.base_definition_path }

    context 'with default value' do
      it { is_expected.to eq(File.join(Dir.getwd, '.definition')) }

      context 'when base_path is altered' do
        before { config.base_path = '/some_folder' }

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

      context 'when base_path is altered' do
        before { config.base_path = '/some_folder' }

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

      context 'when base_path is altered' do
        before { config.base_path = '/some_folder' }

        it { is_expected.to eq('/some_folder/.app_template') }
      end
    end

    context 'when set' do
      before { config.base_app_template_path = '/Users/my_app_templates' }

      it { is_expected.to eq('/Users/my_app_templates') }
    end
  end
end
