class Campaign < ActiveRecord::Base
  # One off lookup
  # Used once from app/controllers/campaigns_controller.rb
  # Doesn't really belong in a in the model
end

class CampaignsController < ApplicationController
  def most_recent_send(target_tenant)
    Campaign.uncached do 
      Campaign
        .where(parent_id: self.id, tenant_id: target_tenant.id)
        .order(created_at: :desc)
        .first
    end
  end
end
