class LocalCampaignNameValidator < ActiveModel::Validator
  def validate(campaign)
    return unless parent_id.nil?

    lookup = campaign.tenant.campaigns.local_campaigns # using scope
                     .where(name: self.name, parent_id: nil)
    
    lookup.where.not(id: campaign.id) unless campaign.new_record?

    campaign.errors
      .add(:name, "This name has already been taken by a local campaign!") if find.exist?
  end
end
