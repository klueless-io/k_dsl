# frozen_string_literal: true

# require 'rails_helper'
require 'spec_helper'

RSpec.describe KDsl::SettingsDsl do
  let(:data) { {} }

  describe 'configure settings via block' do
    context 'setting groups' do
      it 'name is nil' do
        KDsl::SettingsDsl.new(data)

        expect(data).to eq({ 'settings' => {} })
      end

      it 'name :settings' do
        KDsl::SettingsDsl.new(data, :settings)

        expect(data).to eq({ 'settings' => {} })
      end

      it 'name "settings"' do
        KDsl::SettingsDsl.new(data, 'settings')

        expect(data).to eq({ 'settings' => {} })
      end

      it 'name :key_values' do
        KDsl::SettingsDsl.new(data, :key_values) do; end

        expect(data).to eq({ 'key_values' => {} })
      end
    end

    context 'settings options' do
      it 'name is nil' do
        settings = KDsl::SettingsDsl.new(data)

        expect(settings.k_parent).to be_nil
      end

      # it 'attach parent' do
      #   settings = KDsl::SettingsDsl.new(data, k_parent: KDsl::DocumentDsl.new(:x)) do; end

      #   expect(settings.k_parent).to_not be_nil
      #   expect(settings.k_parent.k_key).to eq(:x)
      #   expect(settings.k_parent.type).to eq(:entity)
      # end
    end

    context 'setting key/values' do
      it 'no &block' do
        KDsl::SettingsDsl.new(data)

        expect(data).to eq({ 'settings' => {} })
      end

      it 'default limited and get value' do
        dsl = KDsl::SettingsDsl.new(data, :settings) do
          rails_port        3000
          model             'User'
          active            true
        end

        expect(data).to eq({ 'settings' => { 'rails_port' => 3000, 'model' => 'User', 'active' => true } })

        expect(dsl.get_value(:rails_port)).to eq(3000)
        expect(dsl.get_value(:model)).to eq('User')
        expect(dsl.get_value(:active)).to eq(true)
      end

      it 'default full' do
        KDsl::SettingsDsl.new(data, :key_values) do
          rails_port           3000
          model_type           'AdminUser'
          model                'AdminUser'
          models               'AdminUsers'
          main_key             'email'
          note                 'password is an alias to encrypted_password'

          # Can this be in a test data use case object
          td_key1              'super'
          td_key2              'management'
          td_key3              'engineering'
          td_query             %w[01 02 03 04 10 11 12 13]
        end

        expect(data).to eq({
                             'key_values' => {
                               'rails_port' => 3000,
                               'model_type' => 'AdminUser',
                               'model' => 'AdminUser',
                               'models' => 'AdminUsers',
                               'main_key' => 'email',
                               'note' => 'password is an alias to encrypted_password',
                               'td_key1' => 'super',
                               'td_key2' => 'management',
                               'td_key3' => 'engineering',
                               'td_query' => %w[01 02 03 04 10 11 12 13]
                             }
                           })
      end
    end

    context 'setting get values by key' do
      subject do
        KDsl::SettingsDsl.new(data, :settings) do
          rails_port        3000
          model             'User'
          active            true
        end
      end

      it 'get value by symbol' do
        expect(subject.get_value(:rails_port)).to eq(3000)
        expect(subject.get_value(:model)).to eq('User')
        expect(subject.get_value(:active)).to eq(true)
      end

      it 'get value by string' do
        expect(subject.get_value('rails_port')).to eq(3000)
        expect(subject.get_value('model')).to eq('User')
        expect(subject.get_value('active')).to eq(true)
      end

      it 'get value by attr_reader' do
        expect(subject.rails_port).to eq(3000)
        expect(subject.model).to eq('User')
        expect(subject.active).to eq(true)
      end
    end
  end
end
