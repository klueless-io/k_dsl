class GlobalCampaignNameValidator < ActiveModel::Validator
  def validate(campaign)
    return unless parent_id.nil?

    lookup = campaign.tenant.enterprise.global_campaigns # using scope
                     .where(name: self.name, parent_id: nil)

    lookup.where.not(id: campaign.id) unless campaign.new_record?

    campaign.errors
      .add(:name, "This name has already been taken by a global campaign!") if find.exist?
  end
end