class Campaign < ActiveRecord::Base
  validates :name, length: { minimum: 4 }

  validates_with LocalCampaignNameValidator
  validates_with GlobalCampaignNameValidator
end
