class Campaign < ActiveRecord::Base
  # Simple scopes
  scope :scheduled, -> (tenant) {  }
  scope :without_hidden, -> (tenant) { }
  scope :require_selected_enterprise, -> (tenant) { }

  # Class scopes
  def active_contacts; end
  def old_schedule(date = Time.now); end
  def last_run(target_tenant); end
end
