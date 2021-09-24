class Campaign < ActiveRecord::Base
  # One off lookup
  # Used once from app/controllers/campaigns_controller.rb
  # Doesn't really belong in a in the model
end

class CampaignsController < ApplicationController
  def in_lockout_period?(target_tenant)
    result = false
    recent_send = Campaign
                    .where(parent_id: self.id, tenant_id: target_tenant.id, test: false)
                    .where("created_at > ?", 1.day.ago)
                    .first
    result = true if recent_send
    result
  end
end
