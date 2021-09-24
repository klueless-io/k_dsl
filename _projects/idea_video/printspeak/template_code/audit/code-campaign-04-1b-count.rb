class Campaign < ActiveRecord::Base
  # Virtual read only (count)
  def tenant_count(target_tenant)
    counts.find_by(tenant_id: target_tenant.id).try(:total_count) || 0
  end
  def enterprise_count; end
  def views_for_date(date); end
  def total_clicks; end
end
