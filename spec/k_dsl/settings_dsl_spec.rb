# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::SettingsDsl do
  let(:data) { {} }

  context 'with setting groups' do
    it 'and key is nil' do
      KDsl::SettingsDsl.new(data)

      expect(data).to eq({ 'settings' => {} })
    end

    it 'and key is :settings' do
      KDsl::SettingsDsl.new(data, :settings)

      expect(data).to eq({ 'settings' => {} })
    end

    it 'and key is "settings"' do
      KDsl::SettingsDsl.new(data, 'settings')

      expect(data).to eq({ 'settings' => {} })
    end

    it 'and key is :key_values' do
      KDsl::SettingsDsl.new(data, :key_values)

      expect(data).to eq({ 'key_values' => {} })
    end
  end
  # descrive 'with internally constructed attributes' do

  context 'simple setting' do
    subject do
      KDsl::SettingsDsl.new(data) do
        the 'quick'
      end
    end
    describe 'respond_to?' do
      context 'when attribute is used' do
        it 'will respond to getter' do
          expect(subject).to respond_to(:the)
        end
        it 'will respond to setter' do
          expect(subject).to respond_to(:the=)
        end
      end

      context 'when attribute is unknown' do
        it 'will not respond to getter' do
          expect(subject).not_to respond_to(:unknown_attribute)
        end
        it 'will not respond to setter' do
          expect(subject).not_to respond_to(:unknown_attribute=)
        end
      end
    end

    describe 'get attribute value' do
      context 'when attribute already set' do
        it 'will have valid value' do
          expect(subject.the).to eq('quick')
        end
      end

      context 'when attribute is unknown' do
        it 'will return nil' do
          expect(subject.unknown_attribute).to be_nil
        end
      end
    end

    describe 'set attribute value' do
      describe 'via setter' do
        context 'when attribute already set' do
          it 'will update the attribute' do
            subject.the = 'slow'
            expect(subject.the).to eq('slow')
          end
        end

        context 'when attribute is unknown' do
          it 'will set the new attribute' do
            subject.unknown_attribute = 'no so unknown now'
            expect(subject.unknown_attribute).to eq('no so unknown now')
          end
        end
      end
      describe 'via method' do
        context 'when attribute already set' do
          it 'will update the attribute' do
            subject.the('slow')
            expect(subject.the).to eq('slow')
          end
        end

        context 'when attribute is unknown' do
          it 'will set the new attribute' do
            subject.unknown_attribute('no so unknown now')
            expect(subject.unknown_attribute).to eq('no so unknown now')
          end
        end
      end
    end
  end

  # it 'attach parent' do
  #   settings = KDsl::SettingsDsl.new(data, k_parent: KDsl::DocumentDsl.new(:x)) do; end

  #   expect(settings.k_parent).to_not be_nil
  #   expect(settings.k_parent.k_key).to eq(:x)
  #   expect(settings.k_parent.type).to eq(:entity)
  # end

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
