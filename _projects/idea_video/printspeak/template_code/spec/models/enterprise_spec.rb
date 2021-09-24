# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# These tests have let blocks with the following types of prefixes that will help test
# different aspects of saving, updating and query a model
#   - required        - data columns that have been marked with a simple required validation
#   - optional        - data columns that can be set to nil or a value
#   - virtual         - virtual columns are not normally set by developer. examples: as created_at, deleted_at
#   - has_one         - has one relationships
#   - belongs_to      - has one relationships via foreign key
#   - has_many        - has many relationships via join table
#
# if you need to debug the test data that is in the data base at anytime, you can run the
# following methods from your tests to get a formatted of the data
#   - print_me        - test data related to the enterprise model
#   - print_data_set  - test data related to the enterprise model and it's parent dependencies
# if you want to see test data before and after each test you can put this line inside any context or describe block
#   around(:each) { |example| print_me; example.run; print_me }
RSpec.describe Enterprise, type: :model do
  before(:each) do
    FactoryBot.reload
  end

  # focus models
  # let(:enterprise_trait1) { FactoryBot.create(:enterprise, :trait1, :assign_default_group, default_group: group_trait1) }
  # let(:enterprise_trait2) { FactoryBot.create(:enterprise, :trait2, :assign_default_group, default_group: group_trait2) }
  # let(:enterprise_trait3) { FactoryBot.create(:enterprise, :trait3, :assign_default_group, default_group: group_trait3) }

  let(:enterprise_trait1) { FactoryBot.create(:enterprise, :trait1, default_group: group_trait1) }
  let(:enterprise_trait2) { FactoryBot.create(:enterprise, :trait2, default_group: group_trait2) }
  let(:enterprise_trait3) { FactoryBot.create(:enterprise, :trait3, default_group: group_trait3) }

  # let(:enterprise_trait1) { FactoryBot.create(:enterprise, :trait1, default_group: group_trait1) }
  # let(:enterprise_trait2) { FactoryBot.create(:enterprise, :trait2, default_group: group_trait2) }
  # let(:enterprise_trait3) { FactoryBot.create(:enterprise, :trait3, default_group: group_trait3) }

  let(:described_model) { enterprise_trait1 }

  # has one dependencies
  let(:group_trait1) { FactoryBot.build(:group, :trait1) }
  let(:group_trait2) { FactoryBot.build(:group, :trait2) }
  let(:group_trait3) { FactoryBot.build(:group, :trait3) }

  describe '#find' do
    context 'when row ID exists' do
      before(:each) { described_model }

      let(:found) { described_class.find(described_model.id) }

      it 'should find by id' do
        expect(found.id).to eq(described_model.id)
      end

      describe '#has_one' do
        it 'should have one default group' do
          expect(found.default_group).to eq(group_trait1)
        end
      end
    end
  end

  describe '#create' do
    let(:optional_data_values) do
      {
        name: "name",
        show_eula: true,
        eula_body: "eula_body",
        setup_user: "setup_user",
        setup_password: "setup_password",
        campaign_test_address: "campaign_test_address",
        unsubscribe_template: "unsubscribe_template",
        banner_id: 1,
        default_email_template_id: 1,
        campaign_approval_address: "campaign_approval_address",
        intercom_app_id: "intercom_app_id",
        freshchat_token: "freshchat_token",
        portal_estimate_comment_template_id: 1,
        portal_estimate_approved_template_id: 1,
        portal_estimate_canceled_template_id: 1,
        portal_estimate_copy: "portal_estimate_copy",
        default_company_emailt_id: 1,
        default_contact_emailt_id: 1,
        default_estimate_emailt_id: 1,
        default_order_emailt_id: 1,
        default_sale_emailt_id: 1,
        currency_locale: "currency_locale",
        statement_template_name: "statement_template_name",
        statement_template: "statement_template",
        pdf_gen_link: "pdf_gen_link",
        default_salestarget_amount: 1,
        default_salestarget_number: 1,
        api_token: "api_token",
        default_inquiry_emailt_id: 1,
        connection_type: "connection_type",
        locale: "locale",
        portal_proof_comment_template_id: 1,
        portal_proof_approved_template_id: 1,
        portal_proof_copy: "portal_proof_copy",
        brand_colors: { a: "brand_colors" },
        default_roboto_font: true,
        platform_type: "platform_type",
        agi_brand: true,
        show_language: true,
        default_shipment_emailt_id: 1
      }
    end
    let(:has_one_values) do
      {
        default_group: group_trait1
      }
    end
    let(:all_data_values) { {}.merge(optional_data_values) }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    let(:create) { described_class.new(attributes) }

    context 'when creating a row' do
      context 'with valid data values' do
        context 'and valid relationships' do
          let(:attributes) { all_data_values.merge(has_one_values) }

          it 'should create a new row' do
            expect { create.save }
              .to change { described_class.count }.by(1)
          end

          describe '#has_one' do
            before(:each) { create.save }
            it 'should have one default group' do
              expect(create.default_group).to eq(group_trait1)
            end
          end
        end
      end
    end

    context 'when creating a row with minimal data fields and all foreign key values' do
      # NOT APPLICABLE
    end

    context 'when creating a row with empty hash' do
      let(:attributes) { {} }
      it 'should fail to create new row' do
        # not applicable for this model
        # CONCERN: why is an empty hash for the enterprise model considered valid?
        expect { create.save }
          .to change { described_class.count }.by(1)
      end
    end

    context 'when creating a row with nil' do
      context 'for data values' do
        let(:attributes) { nil_data_values }

        it 'should fail to create new row' do
          expect { create.save }
            .to raise_error(ActiveRecord::StatementInvalid) # Rails 6 - ActiveRecord::NotNullViolation
            # change { described_class.count }.from(0).to(0)
        end
      end

      describe '#belongs_to' do
        # NOT APPLICABLE
      end
    end
  end

  describe '#update' do
    let(:optional_data_values) do
      {
        name: "name+updated",
        show_eula: false,
        eula_body: "eula_body+updated",
        setup_user: "setup_user+updated",
        setup_password: "setup_password+updated",
        campaign_test_address: "campaign_test_address+updated",
        unsubscribe_template: "unsubscribe_template+updated",
        banner_id: 9,
        default_email_template_id: 9,
        campaign_approval_address: "campaign_approval_address+updated",
        intercom_app_id: "intercom_app_id+updated",
        freshchat_token: "freshchat_token+updated",
        portal_estimate_comment_template_id: 9,
        portal_estimate_approved_template_id: 9,
        portal_estimate_canceled_template_id: 9,
        portal_estimate_copy: "portal_estimate_copy+updated",
        default_company_emailt_id: 9,
        default_contact_emailt_id: 9,
        default_estimate_emailt_id: 9,
        default_order_emailt_id: 9,
        default_sale_emailt_id: 9,
        currency_locale: "currency_locale+updated",
        statement_template_name: "statement_template_name+updated",
        statement_template: "statement_template+updated",
        pdf_gen_link: "pdf_gen_link+updated",
        default_salestarget_amount: 9,
        default_salestarget_number: 9,
        api_token: "api_token+updated",
        default_inquiry_emailt_id: 9,
        connection_type: "connection_type+updated",
        locale: "locale+updated",
        portal_proof_comment_template_id: 9,
        portal_proof_approved_template_id: 9,
        portal_proof_copy: "portal_proof_copy+updated",
        brand_colors: { a: "brand_colors" },
        default_roboto_font: false,
        platform_type: "platform_type+updated",
        agi_brand: false,
        show_language: false,
        default_shipment_emailt_id: 9
      }
    end
    let(:has_one_values) do
      {
        default_group: group_trait1
      }
    end
    let(:all_data_values) { {}.merge(optional_data_values) }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    let(:update) { described_model }

    context 'when updating' do
      context 'data fields with valid data' do
        let(:attributes) { all_data_values }

        describe ".valid?" do
          before(:each) { update.assign_attributes(attributes) }

          it { expect(update.valid?).to be_truthy }
        end

        describe ".save" do
          it 'values should change' do
            expect do
              update.assign_attributes(attributes)
              update.save
              update.reload
            end
            .to  change { update.updated_at }
            .and change { update.name }.to('name+updated') # you can check specific fields
          end
        end
      end

      context 'data fields with nil' do
        before(:each) { update.assign_attributes(attributes) }

        let(:attributes) { nil_data_values }

        describe ".valid?" do
          # this test does not work for Enterprise
          xit { expect(update.valid?).to be_falsey }
        end

        describe ".save" do
          before(:each) { update.assign_attributes(attributes) }

          it 'should fail to save' do
            expect { update.save }.to raise_error(ActiveRecord::StatementInvalid) # Rails 6 - ActiveRecord::NotNullViolation
          end
        end
      end

      context 'when updating foreign keys with nil' do
        # NOT APPLICABLE
      end
    end
  end

  describe '#destroy' do
    context 'when delete by id' do
      before(:each) { described_model }
  
      it 'when the row exists' do
        expect { described_class.destroy(described_model.id) }
          .to change { described_class.count }.by(-1)
      end
    end
    context 'when delete by multiple ids' do
      before(:each) { full_data_set }
  
      it 'should rows with valid ids exist' do
        expect { described_class.where(id: [enterprise_trait1.id, enterprise_trait2.id]).destroy_all }
          .to change { described_class.count }.by(-2)
      end
    end
  end

  describe "#public API methods" do
    describe "#banner" do
      subject { described_model.banner }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#users" do
      subject { described_model.users }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#primary_users" do
      subject { described_model.primary_users }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#visible_users" do
      subject { described_model.visible_users }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#default_tenant" do
      subject { described_model.default_tenant }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#is_AGI?" do
      subject { described_model.is_AGI? }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#first_prospect_status" do
      subject { described_model.first_prospect_status }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#first_lead_type" do
      subject { described_model.first_lead_type }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
    describe "#available_lead_statuses" do
      subject { described_model.available_lead_statuses }
      # let(:xxx) {} # (lead_type_id)
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to eq('xyz') }
    end
  end

  describe "#public class methods" do
    describe "#connection_types" do
      subject { described_class.connection_types }

      it { is_expected.not_to be_nil }
      it { is_expected.to eq(["printsmith", "mbehub"]) }
    end
  end

  # data set for general unit tests
  def full_data_set
    enterprise_trait1
    enterprise_trait2
    # enterprise_trait3
  end

  context "factories" do
    before(:each) do
      full_data_set
    end

    describe "check factory data" do
      it "validate test data" do
        # print_data_set

        expect(enterprise_trait1).to_not be_nil
        expect(enterprise_trait2).to_not be_nil
        expect(enterprise_trait3).to_not be_nil
      end
    end
  end

  def print_me
    print_enterprises_as_table
    # print_enterprises(nil, 'detailed')
  end

  def print_data_set
    # return unless AppService.debug?

    # print related tables
    print_default_groups_as_table

    print_me
  end
end
