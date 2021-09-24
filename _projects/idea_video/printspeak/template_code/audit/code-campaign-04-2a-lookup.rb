class Campaign < ActiveRecord::Base
  # Virtual read only (lookup)
  def last_enterprise_run; end
  def next_enterprise_schedule(current_tenant); end
  def next_schedule(target_tenant, latest_child = nil); end
  def next_schedule_utc(target_tenant, latest_child = nil); end
  def most_recent_send(target_tenant); end
  def old_next_schedule(target_tenant); end
end
