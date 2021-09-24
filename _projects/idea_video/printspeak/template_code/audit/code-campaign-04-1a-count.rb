class Campaign < ActiveRecord::Base
  # Virtual read only (count)
  def tenant_count(target_tenant); end
  def enterprise_count; end
  def views_for_date(date); end
  def total_clicks; end
end
