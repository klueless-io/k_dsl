class Campaign < ActiveRecord::Base
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
end
