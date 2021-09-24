# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    # initialize_with { Group.find_or_create_by(name: name) }

    # Belongs to
    # association :enterprise

    # Default column values
    # TODO: this needs to take into consideration the required flag
    #       default columns should be nil, unless they are required and in that scenario
    #       the value can be uncommented
    # TODO: This needs work from the data dictionary and use the faker gem
    # TODO: This needs to put created_at, updated_at and deleted_at in own traits
    name                                     { nil } # { "Name" }
    group_type                               { nil } # { "Group Type" }
    default                                  { nil } # { true }

    trait :trait1 do
      name                                   { "A-Name" }
      group_type                             { "A-Group Type" }
      default                                { true }
    end

    trait :trait2 do
      name                                   { "B-Name" }
      group_type                             { "B-Group Type" }
      default                                { true }
    end

    trait :trait3 do
      name                                   { "C-Name" }
      group_type                             { "C-Group Type" }
      default                                { true }
    end

    trait :no_default do
      default                                { false }
    end

  end
end
