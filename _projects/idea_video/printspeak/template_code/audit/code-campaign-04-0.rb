class Campaign < ActiveRecord::Base
  # Virtual read only (count)
  def tenant_count(target_tenant); end
  def enterprise_count; end
  def views_for_date(date); end
  def total_clicks; end

  # Virtual read only (lookup)
  def last_enterprise_run; end
  def next_enterprise_schedule(current_tenant); end
  def next_schedule(target_tenant, latest_child = nil); end
  def next_schedule_utc(target_tenant, latest_child = nil); end
  def most_recent_send(target_tenant); end
  def old_next_schedule(target_tenant); end

  # Virtual read only (predicate)
  def due(target_tenant); end
  def due_today(target_tenant); end
  def default_override?; end
  def valid_approval?(approval_value); end
  def needs_test_send?; end
  def needs_unsubscribe?; end
  def pass_checklist?; end
  def has_required_custom_fields?(selected_tenant); end
  def all_have_required_custom_fields?(tenants); end
  def ready_to_send?(bypass_checklist = false); end
  def check_campaign_send?(target_tenant, bypass_checklist = false); end
  def in_lockout_period?(target_tenant); end
  def has_inline_images?; end

  # Virtual read only (policy or grant)
  def can_approve(target_tenant, target_user); end
  def can_cancel(target_tenant, target_user); end
  def awaiting_approval(target_tenant); end
  def needs_approval(target_tenant); end
  def modifiable(target_tenant, user); end
  def sendable(target_tenant, user, is_test_send = false); end
  def can_override_throttle(user); end
end
