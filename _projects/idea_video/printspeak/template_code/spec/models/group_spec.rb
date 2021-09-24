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
# following methods from your tests to get a formatted the data
#   - print_me        - test data related to the group model
#   - print_data_set  - test data related to the group model and it's parent dependencies
# if you want to see test data before and after each test you can put this line inside any context or describe block
#   around(:each) { |example| print_me; example.run; print_me }
RSpec.describe Group, type: :model do
  before(:each) do
    FactoryBot.reload
  end

  # focus models
  let(:group_trait1) { FactoryBot.create(:group, :trait1, enterprise: enterprise_trait1) }
  let(:group_trait2) { FactoryBot.create(:group, :trait2, enterprise: enterprise_trait2) }
  let(:group_trait3) { FactoryBot.create(:group, :trait3, enterprise: enterprise_trait3) }

  let(:described_model) { group_trait1 }

  # has one dependencies
  let(:enterprise_trait1) { FactoryBot.build(:enterprise, :trait1) } #, :assign_default_group, default_group: group_trait1) }
  let(:enterprise_trait2) { FactoryBot.build(:enterprise, :trait2) }
  let(:enterprise_trait3) { FactoryBot.build(:enterprise, :trait3) }

  describe '#find' do
    context 'when row ID exists' do
      before(:each) { described_model }

      let(:found) { described_class.find(described_model.id) }

      it 'should find by id' do
        expect(found.id).to eq(described_model.id)
      end

    end
  end

  describe '#create' do
    let(:optional_data_values) do
      {
        name: "name",
        group_type: "group_type",
        default: true
      }
    end
    let(:belongs_to_values) do
      {
        enterprise: enterprise_trait1
      }
    end
    let(:all_data_values) { {}.merge(optional_data_values) }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    let(:create) { described_class.new(attributes) }

    describe 'happy path :)' do
      context 'when creating a row' do
        context 'with valid data values' do
          context 'and valid relationships' do
            let(:attributes) { all_data_values.merge(belongs_to_values) }

            it 'should create a new row' do
              expect { create.save }
                .to change { described_class.count }.by(1)
            end

            describe '#belongs_to' do
              before(:each) do
                # attach any paired belongs_to
                create.enterprise.default_group = create
                create.save
              end
              it 'should have one enterprise' do
                expect(create.enterprise).to eq(enterprise_trait1)
              end
            end
          end
        end
      end
    end

    describe 'unhappy path :(' do
      context 'when misconfigured' do
        context 'because relationships are invalid' do
          context 'when belongs_to relationship is missing' do
            subject { create.errors.full_messages }
            before(:each) { create.save }

            let(:attributes) { all_data_values }

            it { is_expected.to include('Enterprise must exist') }

            it "before and after example for belongs_to relationship in Rails 4 and 5" do
              rails4_existing = <<-RUBY
                belongs_to :enterprise
              RUBY
  
              rails4_to_rails5_compatible = <<-RUBY
                # From Rails 5 onward, required: true will be the default value
                # this is achieved via a new attribute called optional: false
                belongs_to :enterprise, optional: false
                # to simulate that in Rails 4, we add validates presence
                validates :enterprise, presence: { message: "must exist" }
                # we add the previous unit test to check existence.
              RUBY
  
              # We can go back to the old code after migrating to rails 5
              rails5 = <<-RUBY
                belongs_to :enterprise
              RUBY
  
              expect(1).to eq(1)
            end
          end
        end

        context 'because data columns are missing' do
          let(:attributes) { {}.merge(belongs_to_values) }

          xit 'should not create a new row' do
            expect { create.save }
              .to change { described_class.count }.by(0)
          end
        end
        
        context 'because data columns are nil' do
          let(:attributes) { nil_data_values.merge(belongs_to_values) }

          xit 'should fail to create new row' do
            expect { create.save }
              .to change { described_class.count }.by(0)
            # .to raise_error(ActiveRecord::NotNullViolation)
          end
        end
      end
    end
  end

  describe '#update' do
    let(:optional_data_values) do
      {
        name: "name+updated",
        group_type: "group_type+updated",
        default: false
      }
    end
    let(:all_data_values) { {}.merge(optional_data_values) }
    let(:nil_data_values) { all_data_values.keys.map { |key| [key, nil] }.to_h }

    let(:update) { described_model }

    describe 'happy path :)' do
      context 'when data fields are valid' do
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
    end

    describe 'unhappy path :(' do
      context 'data fields with nil' do
        before(:each) { update.assign_attributes(attributes) }

        let(:attributes) { nil_data_values }

        describe ".valid?" do
          # this test does not work for Group
          xit { expect(update.valid?).to be_falsey }
        end

        describe ".save" do
          before(:each) { update.assign_attributes(attributes) }
          subject { update.save }

          # this test does works for Enterprise, but not for Group
          xit 'should fail to save' do
            expect { update.save }.to raise_error(ActiveRecord::NotNullViolation)
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
        expect { described_class.where(id: [group_trait1.id, group_trait2.id]).destroy_all }
          .to change { described_class.count }.by(-2)
      end
    end
  end

  # data set for general unit tests
  def full_data_set
    group_trait1
    group_trait2
    # group_trait3
  end

  def print_me
    print_groups_as_table
    # print_groups(nil, 'detailed')
  end

  def print_data_set
    # return unless AppService.debug?

    # print related tables
    print_enterprises_as_table

    print_me
  end
end
