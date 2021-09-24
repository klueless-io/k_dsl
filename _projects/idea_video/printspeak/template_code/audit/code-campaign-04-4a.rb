class Campaign < ActiveRecord::Base
  # Virtual read only (policy or grant)
  def can_approve(target_tenant, target_user); end
  def can_cancel(target_tenant, target_user); end
  def awaiting_approval(target_tenant); end
  def needs_approval(target_tenant); end
  def modifiable(target_tenant, user); end
  def sendable(target_tenant, user, is_test_send = false); end
  def can_override_throttle(user); end
end
