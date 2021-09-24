# DSL
# Attributes
attr_accessor :new_schedule_date

# Enums
enum :status
enum :method
enum :schedule_week

# Validations
validates :name, length: { minimum: 4 }
validate :name_must_be_unique, :name_must_not_be_in_global

# Scopes
scope :scheduled
scope :without_hidden
scope :require_selected_enterprise

# relationships
has_and_belongs_to_many :contact_lists
has_many :messages
has_many :exclusions
has_many :counts
has_many :trackers
has_many :hits
has_many :email_template_values
has_many :campaign_calendar_entries
belongs_to :tenant
belongs_to :enterprise
belongs_to :email_template
belongs_to :user
belongs_to :identity

# callbacks
before_save :change_schedule
before_save :update_scheduled_at
before_save :make_global_if_enterprise

validate :name_must_be_unique, :name_must_not_be_in_global

# Complex validations
def name_must_be_unique; end
def name_must_not_be_in_global; end

# Scopes - class methods
def active_contacts; end
def old_schedule(date = Time.now); end
def last_run(target_tenant); end

# Virtual read only (or enum)
def steps; end

# Virtual read only field
def tenant_count(target_tenant); end
def enterprise_count; end
def views_for_date(date); end
def total_clicks; end

# Virtual read only (or lookup)
def last_enterprise_run; end
def next_enterprise_schedule(current_tenant); end
def next_schedule(target_tenant, latest_child = nil); end
def next_schedule_utc(target_tenant, latest_child = nil); end
def most_recent_send(target_tenant); end
def old_next_schedule(target_tenant); end

# Virtual read only (or predicate)
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

# Virtual read only (or policy)
def can_approve(target_tenant, target_user); end
def can_cancel(target_tenant, target_user); end
def awaiting_approval(target_tenant); end
def needs_approval(target_tenant); end
def modifiable(target_tenant, user); end
def sendable(target_tenant, user, is_test_send = false); end
def can_override_throttle(user); end

# Operation
def local_hide(tenant, hidden_state = true); end
def set_approval(target_tenant, desired_state); end
def set_skip(target_tenant, skip_time = Time.now); end
def change_schedule; end
def update_scheduled_at; end
def make_global_if_enterprise; end
def tracker_stats; end

# Virtual read only (or query)
def clicks; end

# private helper method
def self.valid_datetime?(datetime); end

# Presenter
def self.click_stats(campaign_ids, start_date, end_date); end
def self.categorized_click_stats(campaign_ids); end
# Presenter (or query)
def contacts(target_tenant, page = nil, per = nil, location = nil, exclude_oversend = nil, only_oversend = false, search = nil, sort = nil, direction = nil, background = false); end
# Presenter or (query, presenter and action)
def self.enterprise_report_job(job); end

# helper method
def self.url_data(url); end

# Action
def self.merger(campaign: nil, contact: nil, tenant: nil, identity: nil); end
def generate_new_schedule_date(base_datetime, last_datetime, new_count = 1); end
def update_calendars(target_tenant = nil); end
def check_bounce_rate; end
def new_contexts(klass, range: 30.days, sales_rep_user_id: 0); end
def send_campaign(user, target_tenant, identity, test, override_throttle = false, target_test_emails = []); end
