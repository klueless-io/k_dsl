class Campaign < ActiveRecord::Base
  # Virtual read only (policy or grant)
  def can_approve(target_tenant, target_user); end
  def can_cancel(target_tenant, target_user); end
  def awaiting_approval(target_tenant); end
  def needs_approval(target_tenant); end
  def modifiable(target_tenant, user); end
  def sendable(target_tenant, user, is_test_send = false)
    result = false
    result = true if user.is_admin? && 
                     (global || target_tenant.id == tenant_id) &&
                    !enterprise_campaign

    result = true if user.is_enterprise_user? &&
                     user.enterprise_id == enterprise_id

    result = false if self.schedule_auto_send && !is_test_send

    return result
  end
  def can_override_throttle(user); end
end
