class Campaign < ActiveRecord::Base
  # Refactor
  def old_in_lockout_period?(target_tenant)
    result = false
    recent_send = Campaign
                    .where(parent_id: self.id, tenant_id: target_tenant.id, test: false)
                    .where("created_at > ?", 1.day.ago)
                    .first
    result = true if recent_send
    result
  end

  # New
  def in_lockout_period?(target_tenant)
    Campaign.where(parent_id: self.id, tenant_id: target_tenant.id, test: false)
            .where("created_at > ?", 1.day.ago)
            .exist?
  end
end
