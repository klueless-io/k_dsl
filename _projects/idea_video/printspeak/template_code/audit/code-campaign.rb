  # Complex validation
  # Presenter
  # Presenter (or query)
  # Scope
  # Scope - class method
  # Query - Active record
  # Lookup - is a single value query
  # Predicate - is an object that returns true or false
  # Policy - is a predicate that returns true or false based on the some sort of privelaged that usually refers to an access right that is true or false
  # Virtual read only
  # Virtual read only (or predicate)
  # Virtual read only (or policy)
  # Virtual read only (or event)
  # Virtual read only (or enum)
  # Virtual read only (or query)
  # Virtual read only (or lookup)
  # Action
  # Operation
  # private helper method

class Campaign < ActiveRecord::Base
  enum status: [:unsent, :sent, :sending, :complete]
  enum method: [:email, :sms, :print, :phone]
  enum schedule_week: {first_week: 1, second_week: 2, third_week: 3, last_week: -1}

  validates :name, length: { minimum: 4 }

  has_and_belongs_to_many :contact_lists, -> { uniq }, autosave: true
  has_many :messages, class_name: "CampaignMessage", dependent: :destroy
  has_many :exclusions, class_name: "CampaignExclusion", dependent: :destroy
  has_many :counts, class_name: "CampaignCount", dependent: :destroy
  has_many :trackers, through: :messages
  has_many :hits, through: :trackers
  has_many :email_template_values, as: :element
  has_many :campaign_calendar_entries
  belongs_to :tenant
  belongs_to :enterprise
  belongs_to :email_template
  belongs_to :user
  belongs_to :identity

  before_save :change_schedule
  before_save :update_scheduled_at
  before_save :make_global_if_enterprise

  scope :scheduled, -> (tenant) { where(parent_id: nil, scheduled: true).where("campaigns.schedule_interval_type <> 'none' OR (campaigns.schedule_interval_type = 'none' AND (NOW() - (campaigns.schedule_date[1] - interval '#{Time.now.in_time_zone(tenant.time_zone).utc_offset} second') <= interval '3 days') AND NOT EXISTS(SELECT null FROM campaigns c1 WHERE c1.tenant_id = #{tenant.id} AND c1.parent_id = campaigns.id AND c1.test = FALSE AND c1.created_at >= ((campaigns.schedule_date[1] - interval '#{Time.now.in_time_zone(tenant.time_zone).utc_offset} second') - interval '2 days' )))")}
  scope :without_hidden, -> (tenant) { where("(campaigns.hidden_tenants->>'#{tenant.id}')::BOOLEAN IS DISTINCT FROM TRUE AND campaigns.global_hide IS DISTINCT FROM TRUE")}
  scope :require_selected_enterprise, -> (tenant) { where("campaigns.enterprise_campaign = FALSE OR (campaigns.enterprise_campaign = TRUE AND ? = ANY(campaigns.selected_tenants))", tenant.id)}

  attr_accessor :new_schedule_date

  validate :name_must_be_unique, :name_must_not_be_in_global

  # Complex validation
  def name_must_be_unique
    if self.parent_id.nil?
      found_template = self.tenant.campaigns.where(global: false).where(name: self.name, parent_id: nil)
      found_template = found_template.where.not(id: self.id) if self.id.present?
      if found_template.first.present?
        errors.add(:name, "This name has already been taken by a local campaign!")
      end
    end
  end

  # Complex validation
  def name_must_not_be_in_global
    if self.parent_id.nil?
      found_template = self.tenant.enterprise.campaigns.where(global: true).where(name: self.name, parent_id: nil)
      found_template = found_template.where.not(id: self.id) if self.id.present?
      if found_template.first.present?
        errors.add(:name, "This name has already been taken by a global campaign!")
      end
    end
  end

  # Presenter
  def contacts(target_tenant, page = nil, per = nil, location = nil, exclude_oversend = nil, only_oversend = false, search = nil, sort = nil, direction = nil, background = false)
    result = Kaminari.paginate_array(Contact.none, total_count: 0).page(page).per(per)

    exclude_oversend = default_override? if exclude_oversend.nil?

    list = contact_lists.first
    result = list.all_contacts(target_tenant, page, per, false, self, location, exclude_oversend, only_oversend, search, sort, direction, background) if list

    if location.nil? && exclude_oversend == default_override? && only_oversend == false
      count = counts.find_or_initialize_by(tenant_id: target_tenant.id)
      count.assign_attributes(total_count: result.total_count)
      count.save
    end

    result
  end

  # Virtual read only field (or predicate)
  def default_override?
    !(scheduled && schedule_auto_send && auto_send_throttle_override)
  end

  # Virtual read only field
  def tenant_count(target_tenant)
    counts.find_by(tenant_id: target_tenant.id).try(:total_count) || 0
  end

  # Virtual read only field
  def enterprise_count
    result = 0
    campaign_counts = CampaignCount.where(tenant_id: selected_tenants, campaign_id: id)
    if campaign_counts.where("total_count < 0").count > 0
      result = -1
    else
      result = campaign_counts.sum(:total_count)
    end
    result
  end

  # Scope - class method
  def active_contacts
    Contact.joins(:campaign_messages).where(campaign_messages: { campaign_id: id })
  end

  # Action
  def new_contexts(klass, range: 30.days, sales_rep_user_id: 0)
    contact_ids = active_contacts.pluck(:id)
    if contact_ids.count > 0
      attribution_start = created_at
      campaign_attribution_offset = RegionConfig.get_value("campaign_attribution_offset", 0).to_i
      if campaign_attribution_offset > 0
        attribution_start = created_at + campaign_attribution_offset.days
      end
      object = klass.where(tenant_id: tenant_id, contact_id: contact_ids,  ordered_date: attribution_start..(created_at + range))

      if sales_rep_user_id != 0
        if sales_rep_user_id == -1
          if tenant.sales_rep_for_locations
            object.where(location_user_id: nil)
          else
            object.where(sales_rep_user_id: nil)
          end
        else
          if tenant.sales_rep_for_locations
            object.where(location_user_id: sales_rep_user_id)
          else
            object.where(sales_rep_user_id: sales_rep_user_id)
          end
        end
      end

      return object
    else
      klass.none
    end
  end

  # Operation
  def local_hide(tenant, hidden_state = true)
    self.hidden_tenants[tenant.id] = hidden_state
    self.save
  end

  # Operation
  def set_approval(target_tenant, desired_state)
    now = nil
    now = Time.now if desired_state
    if self.enterprise_campaign
      self.approvals["-1"] = now
    else
      self.approvals["#{target_tenant.id}"] = now
    end
    self.save
  end

  # Operation
  def set_skip(target_tenant, skip_time = Time.now)
    if self.enterprise_campaign
      self.skips["-1"] = skip_time
    else
      self.skips["#{target_tenant.id}"] = skip_time
    end
    self.save
  end

  # Operation
  def can_approve(target_tenant, target_user)
    result = false
    if target_user.is_enterprise_user?
      result = true
    elsif !self.enterprise_campaign && self.scheduled && target_user.is_admin?
      result = true
    end

    result
  end

  # Virtual read only (policy or grant)
  def can_cancel(target_tenant, target_user)
    result = false

    if self.enterprise_campaign && self.modifiable(target_tenant, target_user)
      result = true
    elsif self.global && (target_user.is_admin? || target_user.is_enterprise_user?) && !self.auto_send_tenants.nil? && self.auto_send_tenants.include?(target_tenant.id)
      result = true
    elsif !self.global && (target_user.is_admin? || target_user.is_enterprise_user?)
      result = true
    end

    result
  end

  # Virtual read only (policy or grant)
  def awaiting_approval(target_tenant)
    result = false
    result = true if self.scheduled && self.schedule_auto_send && self.needs_approval(target_tenant) && ((Time.now - self.next_schedule(target_tenant)).abs <= 2.days)
    if result && self.global && !self.enterprise_campaign && !self.auto_send_tenants.include?(target_tenant.id)
      result = false
    end
    result
  end

  # Virtual read only (policy or grant)
  def needs_approval(target_tenant)
    result = true

    if self.enterprise_campaign && self.valid_approval?(self.approvals["-1"])
      result = false
    elsif !self.enterprise_campaign && self.valid_approval?(self.approvals["#{target_tenant.id}"])
      result = false
    end

    result
  end

  # Virtual read only (policy or grant)
  def valid_approval?(approval_value)
    result = false

    if self.auto_approve == true
      result = true
    elsif !approval_value.nil? && Time.now <= (approval_value.to_datetime + 2.days)
      result = true
    end

    result
  end

  # Operation or Event or Job
  def tracker_stats
    stats = Hash.new
    self.trackers.each do |tracker|
      if stats[tracker.path]
        stats[tracker.path] += tracker.hits
      else
        stats[tracker.path] = tracker.hits
      end
    end
    stats
  end

  # Virtual read only (or enum)
  def steps
    ["new", "details", "contact_lists", "test", "confirm"]
  end

  # Action
  def send_campaign(user, target_tenant, identity, test, override_throttle = false, target_test_emails = [])
    parent = Campaign.find(self.parent_id) if self.parent_id
    if parent
      exclude_oversend = !allow_override
      exclude_oversend = false if self.test
      
      target_contacts = []
      
      if test
        if target_tenant.sales_rep_for_locations
          target_tenant.locations.each do |location|
            location_contact = parent.contacts(target_tenant, 1, 1, location, exclude_oversend).first(1)
            target_contacts = target_contacts + location_contact if !location_contact.nil?
          end
        else
          target_contacts = parent.contacts(target_tenant, 1, 3, nil, exclude_oversend).first(enterprise_campaign ? 1 : 3)
        end
      else
        target_contacts = parent.contacts(target_tenant, -1, nil, nil, exclude_oversend)
      end
      
      ActiveRecord::Base.transaction do
        target_contacts.each do |contact|
          next if contact.tenant_id != target_tenant.id
          parent_message = CampaignMessage.joins(:campaign, :contact).where(campaigns: {id: self.id}, parent_message_id: nil).where("LOWER(BTRIM(contacts.email)) = ?", Email.clean_email(contact.email)).first
          message = CampaignMessage.find_or_initialize_by(tenant_id: self.tenant_id, campaign_id: self.id, contact_id: contact.id)
          if parent_message
            message.parent_message_id = parent_message.id
            message.sent = parent_message.sent
            message.opened = parent_message.opened
            message.failed = parent_message.failed
            message.failed_reason = parent_message.failed_reason
          else
            message.sent = false
            message.opened = false
          end
          message.save
          Activity.create!(tenant_id: self.tenant_id, contact_id: contact.id, company_id: contact.company.try(:id), campaign_id: self.id, campaign_message_id: message.id, activity_for: "campaign_message") unless test
        end
      end
      self.status = :sent
      self.save
      unless test
        Activity.find_or_create_by(user_id: self.user_id, tenant_id: self.tenant_id, campaign_id: self.id, activity_for: "campaign_sent")
        CampaignExclusion.joins(:contact).where(campaign_id: parent.id, contacts: {tenant_id: target_tenant}).destroy_all if parent.clear_exclusions
        count = counts.find_or_initialize_by(tenant_id: target_tenant.id)
        count.assign_attributes(total_count: 0)
        count.save
      end
      self
    else
      child = self.dup
      child.test = test
      child.test_emails = target_test_emails
      child.parent_id = self.id
      child.tenant_id = target_tenant.id
      child.user_id = user.id
      child.identity_id = identity.try(:id)
      child.allow_override = self.can_override_throttle(user) ? override_throttle : false
      child.allow_override = true if test
      child.status = :sending
      child.save

      if self.email_template
        self.email_template.email_template_fields.each do |field|
          EmailTemplateValue.where(email_template_field_id: field.id, element_type: "Campaign", element_id: self.id).where("tenant_id IS NULL OR tenant_id = ?", target_tenant.id).each do |field_value|
            new_value = field_value.dup
            new_value.element_id = child.id
            new_value.save
          end
        end
      end

      child.send_campaign(user, target_tenant, identity, test)
    end
  end

  # Virtual read only (or lookup)
  def last_enterprise_run
    return nil if !self.enterprise_campaign || self.selected_tenants.count == 0
    last_run_date = nil
    target_tenants = Tenant.where(id: self.selected_tenants)
    target_tenants.each do |target_tenant|
      last_run_date = last_run(target_tenant)
      if !last_run_date.nil?
        break
      end
    end
    last_run_date
  end

  # Virtual read only (or lookup)
  def next_enterprise_schedule(current_tenant)
    return nil if !self.enterprise_campaign || self.selected_tenants.count == 0
    next_date = nil
    target_tenants = Tenant.where(id: self.selected_tenants)
    target_tenants.each do |target_tenant|
      next_date = next_schedule_utc(target_tenant)
      if !next_date.nil?
        next_date = current_tenant.change_to_time_zone(next_date)
        break
      end
    end
    next_date
  end

  # Virtual read only (or lookup)
  def next_schedule(target_tenant, latest_child = nil)
    return nil if self.enterprise_campaign && !self.selected_tenants.include?(target_tenant.id)
    next_date = next_schedule_utc(target_tenant, latest_child)
    if !next_date.nil?
      next_date = target_tenant.change_to_time_zone(next_date)
    end
    next_date
  end

  # Virtual read only (or lookup)
  def next_schedule_utc(target_tenant, latest_child = nil)
    if self.scheduled && self.schedule_date.count < 1
      self.new_schedule_date = self.old_next_schedule(self.tenant)
      self.schedule_interval_type = "month"
      self.schedule_day_lock = "weekday"
      self.save
    end
    return nil if !self.scheduled || self.schedule_date.count < 1
    now = DateTime.now
    expiration_duration = 7.days
    expiration_duration = 3.days if self.schedule_interval_type == "week"
    latest_child = last_run(target_tenant) if latest_child.nil?
    latest_child_time = DateTime.new
    latest_child_time = latest_child.created_at if !latest_child.nil?

    skip_date = self.skips[self.enterprise_campaign ? "-1" : "#{target_tenant.id}"]
    

    if self.schedule_interval_type == "none"
      first_schedule_date = target_tenant.change_to_time_zone(self.schedule_date.first)
      if (!latest_child.nil? && latest_child.created_at >= (first_schedule_date - 2.days)) || (now.to_i - first_schedule_date.to_i) > 3.days
        return nil
      else
        return self.schedule_date.first
      end
    end

    next_date = nil
    last_date = nil
    self.schedule_date.each_with_index do |date, index|
      next if latest_child_time.between?(date - expiration_duration, date + expiration_duration) || (!skip_date.nil? && (skip_date.to_datetime + 2.days) >= date)
      if (last_date.nil? && now < (date + expiration_duration)) || (!last_date.nil? && now.between?(last_date + expiration_duration, date + expiration_duration))
        next_date = date
        break
      end
      
      last_date = date
    end
    
    if next_date.nil?
      new_date = generate_new_schedule_date(self.schedule_date.first, self.schedule_date.last, 1)
      if !new_date.nil? && !new_date.first.nil? && new_date.first > self.schedule_date.last
        self.schedule_date = self.schedule_date + new_date
        self.save
        next_date = self.next_schedule(target_tenant, latest_child)
      end
    end
    next_date
  end

  # Action
  def generate_new_schedule_date(base_datetime, last_datetime, new_count = 1)
    return nil if !self.scheduled || self.schedule_date.count < 1 || self.schedule_interval_type == "none"

    new_datetime = nil
    case self.schedule_interval_type
    when "week"
      new_datetime = last_datetime + (self.schedule_interval.weeks)
    when "month"
      new_datetime = last_datetime + (self.schedule_interval.months) + (base_datetime.day - last_datetime.day).days
    when "quarter"
      new_datetime = last_datetime
      time_since_quarter_start = base_datetime - base_datetime.beginning_of_quarter
      quarters_to_advance = self.schedule_interval
      while quarters_to_advance > 0
        new_datetime = new_datetime.end_of_quarter + 1.second + time_since_quarter_start
        quarters_to_advance = quarters_to_advance - 1
      end
    when "year"
      new_datetime = last_datetime + (self.schedule_interval.years)
    end

    forward_search_datetime = nil
    reverse_search_datetime = nil
    reverse_span = nil
    forward_span = nil

    case self.schedule_day_lock
    when "none"
      if self.schedule_interval_type == "month" || self.schedule_interval_type == "year"
        forward_search_datetime = new_datetime
        best_forward_search_datetime = forward_search_datetime
        search_days = 0
        while forward_search_datetime.day != base_datetime.day && search_days < 7
          best_forward_search_datetime = forward_search_datetime if (best_forward_search_datetime.day - base_datetime.day).abs > (forward_search_datetime.day - base_datetime.day).abs
          forward_search_datetime = forward_search_datetime + 1.day
          search_days += 1
        end

        if search_days >= 7
          forward_search_datetime = best_forward_search_datetime
        end
        
        reverse_search_datetime = new_datetime
        best_reverse_search_datetime = reverse_search_datetime
        search_days = 0
        while reverse_search_datetime.day != base_datetime.day && search_days < 7
          best_reverse_search_datetime = reverse_search_datetime if (best_reverse_search_datetime.day - base_datetime.day).abs > (reverse_search_datetime.day - base_datetime.day).abs
          reverse_search_datetime = reverse_search_datetime - 1.day
          search_days += 1
        end

        if search_days >= 7
          reverse_search_datetime = best_reverse_search_datetime
        end
      else
        forward_search_datetime = new_datetime
        reverse_search_datetime = new_datetime
      end

      reverse_span = new_datetime - reverse_search_datetime
      forward_span = forward_search_datetime - new_datetime
    when "weekday"
      forward_search_datetime = new_datetime
      while forward_search_datetime.wday != base_datetime.wday
        forward_search_datetime = forward_search_datetime + 1.day
      end

      reverse_search_datetime = new_datetime
      while reverse_search_datetime.wday != base_datetime.wday
        reverse_search_datetime = reverse_search_datetime - 1.day
      end

      reverse_span = new_datetime - reverse_search_datetime
      forward_span = forward_search_datetime - new_datetime
    when "business"
      forward_search_datetime = new_datetime
      while [0, 6].include?(forward_search_datetime.wday)
        forward_search_datetime = forward_search_datetime + 1.day
      end

      reverse_search_datetime = new_datetime
      while [0, 6].include?(reverse_search_datetime.wday)
        reverse_search_datetime = reverse_search_datetime - 1.day
      end

      reverse_span = new_datetime - reverse_search_datetime
      forward_span = forward_search_datetime - new_datetime
    end

    case self.schedule_interval_type
    when "week"
      if reverse_span >= forward_span
        new_datetime = forward_search_datetime
      else
        new_datetime = reverse_search_datetime
      end
    when "month"
      target_month = (last_datetime.month + self.schedule_interval)
      while target_month > 12 do
        target_month = target_month - 12
      end
      if reverse_span >= forward_span && (forward_search_datetime.month == target_month)
        new_datetime = forward_search_datetime
      else
        if reverse_search_datetime.month == target_month
          new_datetime = reverse_search_datetime
        elsif reverse_search_datetime.month > target_month
          new_datetime = reverse_search_datetime - 7.days
        elsif reverse_search_datetime.month < target_month
          new_datetime = reverse_search_datetime + 7.days
        end
      end

      if new_datetime.month != target_month
        if forward_search_datetime.month == target_month
          new_datetime = forward_search_datetime
        elsif reverse_search_datetime.month == target_month
          new_datetime = reverse_search_datetime
        else
          raise "Schedule could not reach target month. Campaign: #{self.id}"
        end
      end
    when "quarter"
      raw_quarter = (((last_datetime.month - 1) / 3) + self.schedule_interval)
      target_quarter = (raw_quarter % 4) + ((last_datetime.year + (raw_quarter / 4).floor) * 10)
      forward_quarter = ((forward_search_datetime.month - 1) / 3) + (forward_search_datetime.year * 10)
      reverse_quarter = ((reverse_search_datetime.month - 1) / 3) + (reverse_search_datetime.year * 10)
      if reverse_span >= forward_span && (forward_quarter == target_quarter)
        new_datetime = forward_search_datetime
      else
        if reverse_quarter == target_quarter
          new_datetime = reverse_search_datetime
        elsif reverse_quarter > target_quarter
          new_datetime = reverse_search_datetime - 7.days
        elsif reverse_quarter < target_quarter
          new_datetime = reverse_search_datetime + 7.days
        end
      end
    when "year"
      if reverse_span >= forward_span && (forward_search_datetime.year == last_datetime.year + self.schedule_interval)
        new_datetime = forward_search_datetime
      else
        new_datetime = reverse_search_datetime
      end
    end

    result = []
    result << new_datetime
    if new_count > 1
      result = result + generate_new_schedule_date(base_datetime, new_datetime, new_count - 1)
    end

    result.compact
  end

  # Virtual read only (or lookup)
  def old_next_schedule(target_tenant)
    time = Time.now.in_time_zone(target_tenant.time_zone)
    result = time
    if (old_schedule < created_at || (old_schedule + 7.days) < time) || (!scheduled_at.nil? && old_schedule < scheduled_at)
      result = old_schedule(old_schedule.end_of_month + 1.day)
    else
      latest_child = last_run(target_tenant)
      if latest_child && (old_schedule < latest_child.created_at || latest_child.created_at.beginning_of_day >= 30.days.ago)
        result = old_schedule(latest_child.created_at.end_of_month + 1.day)
      elsif (old_schedule + 7.days) < time
        result = old_schedule(old_schedule.end_of_month + 1.day)
      else
        result = old_schedule(time)
      end
    end
    result = result.beginning_of_day + schedule_hour.hours

    result
  end

  # Scope - class method
  def old_schedule(date = Time.now)
    ApplicationController.helpers.weekday_of_month(Campaign.schedule_weeks[schedule_week], schedule_weekday, date)
  end

  # Action
  def self.merger(campaign: nil, contact: nil, tenant: nil, identity: nil)
    raise "Campaign object required for campaign merger." if campaign.nil?
    raise "Tenant object required for campaign merger." if tenant.nil?
    raise "Identity object required for campaign merger." if identity.nil?
    TemplateMerger.new(campaign, contact, tenant, identity)
  end

  # Virtual read only
  def due(target_tenant)
    return false if next_schedule(target_tenant).nil?
    next_schedule(target_tenant) < Time.now.in_time_zone(target_tenant.time_zone)
  end

  # Virtual read only
  def due_today(target_tenant)
    return false if next_schedule(target_tenant).nil?
    next_schedule(target_tenant).to_date <= Time.now.in_time_zone(target_tenant.time_zone).to_date
  end

  # Action
  def update_calendars(target_tenant = nil)
    target_tenant = tenant if target_tenant.nil?
    next_date = next_schedule_utc(target_tenant)

    if scheduled && !next_date.nil? && (!self.enterprise_campaign || (self.enterprise_campaign && self.selected_tenants.include?(target_tenant.id)))
      require "google/apis/calendar_v3"
      summary = "Print Speak Campaign: #{name}"
      start_time = next_date.asctime.in_time_zone(target_tenant.time_zone).to_datetime
      event_start = Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time.rfc3339)
      event_end = Google::Apis::CalendarV3::EventDateTime.new(date_time: (start_time + 15.minutes).rfc3339)
      event = Google::Apis::CalendarV3::Event.new(summary: summary, start: event_start, end: event_end)

      user_ids = target_tenant.visible_users.where(marketing_calendar_events: true).pluck(:id)
      entries = CampaignCalendarEntry.where(campaign_id: id, tenant_id: target_tenant.id)
      entries.each do |entry|
        user_ids.delete(entry.user_id)
        user = entry.user
        if !user.nil?
          if !user.marketing_calendar_events
            user.delete_calendar_event("primary", entry.calendar_entry_id)
            entry.destroy
          elsif entry.date != next_date
            result_id = user.update_calendar_event("primary", entry.calendar_entry_id, event)
            if result_id == "not_found"
              entry.destroy
            else
              entry.update_attributes(calendar_entry_id: result_id, date: next_date) if !result_id.nil? && result_id != "failed"
            end
          end
        else
          entry.destroy
        end
      end
      user_ids.each do |user_id|
        user = User.find(user_id)
        result_id = user.create_calendar_event("primary", event)
        CampaignCalendarEntry.create(campaign_id: id, tenant_id: target_tenant.id, user_id: user.id, calendar_entry_id: result_id, date: next_date) if !result_id.nil? && result_id != "failed"
      end
    else
      entries = CampaignCalendarEntry.where(campaign_id: id, tenant_id: target_tenant.id)
      entries.each do |entry|
        user = entry.user
        if !user.nil?
          user.delete_calendar_event("primary", entry.calendar_entry_id)
        end
        entry.destroy
      end
    end
  end

  # Virtual read only
  def total_clicks
    ids = trackers.where.not(method: 0).pluck(:id)
    TrackerHit.where(tracker_id: ids).count()
  end

  # Virtual read only(or query)
  def clicks
    ids = trackers.where.not(method: 0).pluck(:id)
    @trackers = TrackerHit.where(tracker_id: ids).where.not(method: 0)
  end

  # Virtual read only
  def modifiable(target_tenant, user)
    (!global && !enterprise_campaign && target_tenant.id == tenant_id) || (user.is_enterprise_user? && user.enterprise_id == enterprise_id)
  end

  # Virtual read only
  def sendable(target_tenant, user, is_test_send = false)
    result = false
    result = true if user.is_admin? && (global || target_tenant.id == tenant_id) && !enterprise_campaign

    result = true if user.is_enterprise_user? && user.enterprise_id == enterprise_id

    result = false if self.schedule_auto_send && !is_test_send

    return result
  end

  # Scope - class method
  def last_run(target_tenant)
    target_tenant.campaigns.where(parent_id: id).where.not(test: true).order(created_at: :desc).first
  end

  # Virtual read only (policy or grant)
  def can_override_throttle(user)
    (global && allow_override) || (!global && user.is_admin?)
  end

  # Virtual read only
  def has_inline_images?
    /src=["']data:[a-zA-Z]+\/[a-zA-Z]+;.+["']/ =~ body
  end

  # Virtual read only (or predicate)
  def needs_test_send?
    enterprise_campaign ? tenants_missing_test_send.count > 0 : Campaign.where(parent_id: id, test: true).where("MD5(body) = ?", Digest::MD5.hexdigest(body || "")).count == 0
  end

 # Virtual read only
 def tenants_missing_test_send
    result = []

    if enterprise_campaign
      test_sends = Campaign.where(parent_id: id, test: true).where("MD5(body) = ?", Digest::MD5.hexdigest(body || "")).pluck(:tenant_id)
      selected_tenants.each do |selected_tenant|
        result << selected_tenant unless test_sends.include?(selected_tenant)
      end
    end

    result
  end

  # Virtual read only (or predicate)
  def needs_unsubscribe?
    result = true
    if !body.blank?
      template_merger = TemplateMerger.new(self)
      untranslated_body = template_merger.untranslated_merge(body)
      result = !(untranslated_body.include?("{{unsubscribe}}") || untranslated_body.include?("{{unsubscribe_template}}"))
    end
    result
  end

  # Virtual read only (or predicate)
  def pass_checklist?
    result = true
    result = false if needs_test_send?
    result = false if needs_unsubscribe?
    result = false if has_inline_images?
    result
  end

  # Virtual read only
  def views_for_date(date)
    subquery = CampaignMessage.select("campaign_messages.id, MIN(tracker_hits.created_at) AS latest_hit").where(campaign_id: id).joins(:hits).group("campaign_messages.id").to_sql
    CampaignMessage.all.from("(#{subquery}) messages").where("messages.latest_hit BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day).count
  end

  # Action
  def check_bounce_rate
    return if self.paused
    sent_messages = self.messages.where("sent = TRUE OR failed = TRUE").count
    if sent_messages >= 100
      bounced_messages = self.messages.where(failed: true).count
      bounce_rate = bounced_messages.to_f / sent_messages.to_f
      max_bounce_rate = RegionConfig.get_value("campaign_max_bounce_rate_percent", 5).to_f / 100
      if bounce_rate > max_bounce_rate
        self.paused = true
        self.save

        addresses = RegionConfig.get_value("campaign_paused_alert", "").split(",").map{|s| "#{s.squish.downcase}"}
        enterprise_address = self.tenant.enterprise.campaign_test_address
        addresses << enterprise_address if !enterprise_address.blank?

        Thread.new do
          Email.ses_send(addresses, "Print Speak: Campaign Paused: #{self.tenant.name} - #{self.tenant.number} (#{self.name})", %Q{
            <p>
              A campaign was paused for #{self.tenant.name} (#{self.name}).
            </p>
          })
          ActiveRecord::Base.clear_active_connections!
        end


      end
    end
  end

  # Virtual read only (or predicate)
  def has_required_custom_fields?(selected_tenant)
    result = true
    !self.email_template.nil? && self.email_template.email_template_fields.where(required: true).each do |field|
      result = false if field.get_value(self, selected_tenant.id).blank?
    end
    result
  end

  # Virtual read only (or predicate)
  def all_have_required_custom_fields?(tenants)
    result = true
    tenants.each do |tenant|
      result = false if !has_required_custom_fields?(tenant)
    end
    result
  end

  # private helper method
  def self.valid_datetime?(datetime)
    valid = false
    begin
      datetime.to_datetime
      valid = true
    rescue
    end
    valid
  end

  # Virtual read only (or predicate)
  def ready_to_send?(bypass_checklist = false)
    result = false

    if !self.global && !self.enterprise_campaign
      result = true if self.check_campaign_send?(self.tenant, bypass_checklist)
    elsif self.global && !self.enterprise_campaign
      target_tenants = Tenant.where(id: self.auto_send_tenants, enterprise_id: self.tenant.enterprise.id)
      target_tenants.each do |target_tenant|
        result = true if self.check_campaign_send?(target_tenant, bypass_checklist)
      end
    elsif self.global && self.enterprise_campaign
      target_tenants = Tenant.where(id: self.selected_tenants, enterprise_id: self.tenant.enterprise.id)
      target_tenants.each do |target_tenant|
        result = true if self.check_campaign_send?(target_tenant, bypass_checklist)
      end
    end

    result
  end

  # Virtual read only (or predicate)
  def check_campaign_send?(target_tenant, bypass_checklist = false)
    result = false

    now = Time.current

    next_send = self.id.nil? ? target_tenant.change_to_time_zone(self.schedule_date.first) : self.next_schedule(target_tenant)
    if next_send
      if now >= next_send && !self.needs_approval(target_tenant) && ((now - next_send) <= 3.days)
        result = true if bypass_checklist || (self.pass_checklist? && self.has_required_custom_fields?(target_tenant))
      end
    end

    result
  end

  # Virtual read only (or predicate)
  def in_lockout_period?(target_tenant)
    result = false
    recent_send = Campaign.where(parent_id: self.id, tenant_id: target_tenant.id, test: false).where("created_at > ?", 1.day.ago).first
    result = true if recent_send
    result
  end

  # Lookup - is a single value query
  def most_recent_send(target_tenant)
    result = nil
    Campaign.uncached do 
      result = Campaign.where(parent_id: self.id, tenant_id: target_tenant.id).order(created_at: :desc).first
    end
    result
  end

  # Presenter (or query)
  def self.click_stats(campaign_ids, start_date, end_date)
    result = {
      total_trackers: 0,
      unique_clicks: 0
    }
    query = %Q{
      SELECT
        COUNT(tracker_hits.tracker_id) AS total_trackers,
        COUNT(DISTINCT tracker_hits.tracker_id) AS unique_clicks
      FROM trackers
      INNER JOIN campaign_messages_trackers ON campaign_messages_trackers.tracker_id = trackers.id
      INNER JOIN campaign_messages ON campaign_messages.id = campaign_messages_trackers.campaign_message_id
      LEFT OUTER JOIN tracker_hits ON tracker_hits.tracker_id = trackers.id
      WHERE trackers.method != 0
      AND trackers.path NOT LIKE '%unsubscribe%'
      AND campaign_messages.campaign_id IN (#{campaign_ids.to_csv})
      AND tracker_hits.created_at BETWEEN '#{start_date}'::timestamp AND '#{end_date}'::timestamp
    }
    if campaign_ids.count > 0
      query_result = ActiveRecord::Base.connection.execute(query).first
      if query_result
        result = {
          total_trackers: query_result["total_trackers"].try(:to_i) || 0,
          unique_clicks: query_result["unique_clicks"].try(:to_i) || 0,
        }
      end
    end
    result
  end

  # Presenter (or query)
  def self.categorized_click_stats(campaign_ids)
    categories = {}
    query = %Q{
      SELECTs
        campaigns.tenant_id,
        trackers.path,
        COUNT(trackers.id) AS total_trackers,
        (
          SELECT COUNT(DISTINCT tracker_hits.tracker_id)
          FROM tracker_hits
          WHERE tracker_hits.tracker_id = ANY (ARRAY_AGG(trackers.id))
        ) AS unique_clicks
      FROM trackers
      INNER JOIN campaign_messages_trackers ON campaign_messages_trackers.tracker_id = trackers.id
      INNER JOIN campaign_messages ON campaign_messages.id = campaign_messages_trackers.campaign_message_id
      INNER JOIN campaigns ON campaigns.id = campaign_messages.campaign_id
      WHERE trackers.method != 0
      AND trackers.path NOT LIKE '%unsubscribe%'
      AND campaign_messages.campaign_id IN (#{campaign_ids.to_csv})
      GROUP BY campaigns.tenant_id, trackers.path
    }
    if campaign_ids.count > 0
      query_result = ActiveRecord::Base.connection.execute(query)
      if query_result
        url_data = []
        query_result.each do |stats|
          url = Campaign.url_data(stats["path"])
          url_data << {
            tenant_id: stats["tenant_id"].to_i,
            total_trackers: stats["total_trackers"].try(:to_i) || 0,
            unique_clicks: stats["unique_clicks"].try(:to_i) || 0,
            url: stats["path"],
            domain: url[:domain],
            base_domain: url[:base_domain],
            path: url[:path],
            clean_url: url[:clean_url]
          }
        end

        identities = Identity.all.as_json

        url_data.each do |data|
          category = nil
          title = nil
          sub_title = nil
          base_domain = data[:base_domain].try(:downcase)
          clean_url = data[:clean_url].try(:downcase)
          if base_domain == "facebook.com"
            category = "facebook"
            title = "Facebook"
          elsif base_domain == "twitter.com"
            category = "twitter"
            title = "Twitter"
          elsif base_domain == "printspeak.com" && clean_url.include?("email_view")
            category = "email_view"
            title = "Email View"
          else
            target_identities = identities.select{|t| t["tenant_id"] == data[:tenant_id]}
            if target_identities.count > 0
              target_identities.each do |identity|
                break if !category.blank?
                identity["request_quote_url_data"] ||= Campaign.url_data(identity["request_quote_url"])
                if !identity["request_quote_url_data"].nil? && !identity["request_quote_url_data"][:clean_url].blank?
                  request_quote_url = identity["request_quote_url_data"][:clean_url]
                  if request_quote_url == clean_url
                    category = "request_a_quote"
                    title = "Request A Quote"
                  end
                end
                
                identity["website_url_data"] ||= Campaign.url_data(identity["website_url"])
                if category.blank? && !identity["website_url_data"].nil? && !identity["website_url_data"][:clean_url].blank?
                  website_url = identity["website_url_data"][:clean_url]
                  if website_url == clean_url
                    category = "website"
                    title = "Website"
                  else
                    if clean_url.start_with?(website_url)
                      website_path = clean_url.split(website_url).try(:[], 1)
                      if !website_path.blank?
                          website_path = website_path[1..-1] if website_path[0] == "/"
                          category = "website/#{website_path}"
                          title = "Website"
                          sub_title = website_path
                      end
                    end
                  end
                end
              end
            end

            if category.blank?
              if data[:path].blank? || data[:path] == "/"
                category = base_domain
                title = base_domain
              else
                slash = "/" if data[:path][0] != "/"
                path = data[:path][1..-1] if data[:path][0] == "/"
                category = "#{base_domain}/#{path}"
                title = base_domain
                sub_title = URI.decode(path)
              end
            end
          end

          if !category.blank?
            title = category if title.blank?
            if categories.has_key?(category)
              categories[category][:total_trackers] += data[:total_trackers]
              categories[category][:unique_clicks] += data[:unique_clicks]
              categories[category][:urls] << data
            else
              categories[category] = {
                title: title,
                sub_title: sub_title,
                total_trackers: data[:total_trackers],
                unique_clicks: data[:unique_clicks],
                urls: [data]
              }
            end
          end
        end
      end
    end
    categories
  end

  # helper method
  def self.url_data(url)
    result = nil
    begin
      url = url.gsub(/https?:\/\//, "")
      uri = URI.parse("http://#{url}")
      host = PublicSuffix.domain(uri.host)
      result = {
        domain: uri.host,
        base_domain: host,
        path: uri.path,
        clean_url: "#{host}#{uri.path}".try(:downcase).try(:chomp, "/")
      }
    rescue
    end
    result
  end

  # Presenter (or query, presenter and action)
  def self.enterprise_report_job(job)
    total_stats = {
      estimate_count: 0,
      estimate_total: 0,
      invoice_count: 0,
      invoice_total: 0,
      messages_count: 0,
      messages_sent: 0,
      messages_opened: 0,
      messages_failed: 0,
      messages_unsubscribed: 0
    }

    attribution_start = "campaigns.created_at"
    campaign_attribution_offset = RegionConfig.get_value("campaign_attribution_offset", 0).to_i
    if campaign_attribution_offset > 0
      attribution_start = "campaigns.created_at + interval '#{campaign_attribution_offset} days'"
    end

    sent_campaign_ids = job.data["sent_campaign_ids"]
    start_date = job.data["start_date"].to_datetime
    end_date = job.data["end_date"].to_datetime
    click_stats = Campaign.click_stats(sent_campaign_ids, start_date, end_date)

    campaign_stats_query = %Q{
      SELECT
        campaign_stats.tenant_id,
        ARRAY_AGG(campaign_stats.id) AS campaign_ids,
        SUM(campaign_stats.estimate_info[1]) AS estimate_count,
        SUM(campaign_stats.estimate_info[2]) AS estimate_total,
        SUM(campaign_stats.invoice_info[1]) AS invoice_count,
        SUM(campaign_stats.invoice_info[2]) AS invoice_total,
        SUM(campaign_stats.campaign_info[1]) AS messages_count,
        SUM(campaign_stats.campaign_info[2]) AS messages_sent,
        SUM(campaign_stats.campaign_info[3]) AS messages_opened,
        SUM(campaign_stats.campaign_info[4]) AS messages_failed,
        SUM(campaign_stats.campaign_info[5]) AS messages_unsubscribed,
        MAX(campaign_stats.created_at) AS latest_send_date
      FROM (
        SELECT
          campaigns.id,
          campaigns.tenant_id,
          campaigns.created_at,
          (
            SELECT ARRAY[
              COALESCE(COUNT(estimates.id), 0),
              COALESCE(SUM(estimates.grand_total), 0)
            ]
            FROM estimates
            WHERE estimates.tenant_id = campaigns.tenant_id
            AND estimates.voided = FALSE
            AND estimates.deleted = FALSE
            AND estimates.ordered_date BETWEEN #{attribution_start} AND campaigns.created_at + interval '30 days'
            AND estimates.ordered_date BETWEEN '#{start_date}'::timestamp AND '#{end_date}'::timestamp
            AND EXISTS (
              SELECT null
              FROM campaign_messages
              WHERE campaign_messages.tenant_id = campaigns.tenant_id
              AND campaign_messages.contact_id = estimates.contact_id
              AND campaign_messages.campaign_id = campaigns.id
            )
          ) AS estimate_info,
          (
            SELECT ARRAY[
              COALESCE(COUNT(invoices.id), 0),
              COALESCE(SUM(invoices.grand_total), 0)
            ]
            FROM invoices
            WHERE invoices.tenant_id = campaigns.tenant_id
            AND invoices.voided = FALSE
            AND invoices.deleted = FALSE
            AND invoices.ordered_date BETWEEN #{attribution_start} AND campaigns.created_at + interval '30 days'
            AND invoices.ordered_date BETWEEN '#{start_date}'::timestamp AND '#{end_date}'::timestamp
            AND EXISTS (
              SELECT null
              FROM campaign_messages
              WHERE campaign_messages.tenant_id = campaigns.tenant_id
              AND campaign_messages.contact_id = invoices.contact_id
              AND campaign_messages.campaign_id = campaigns.id
            )
          ) AS invoice_info,
          (
            SELECT ARRAY[
              COALESCE(COUNT(campaign_messages.id), 0),
              COUNT(CASE WHEN campaign_messages.sent = TRUE THEN 1 END),
              COUNT(CASE WHEN campaign_messages.opened = TRUE THEN 1 END),
              COUNT(CASE WHEN campaign_messages.failed = TRUE THEN 1 END),
              COUNT(CASE WHEN campaign_messages.unsubscribed = TRUE THEN 1 END)
            ]
            FROM campaign_messages
            WHERE campaign_messages.tenant_id = campaigns.tenant_id
            AND campaign_messages.campaign_id = campaigns.id
            AND campaign_messages.created_at BETWEEN '#{start_date}'::timestamp AND '#{end_date}'::timestamp
          ) AS campaign_info
        FROM campaigns
        WHERE campaigns.test = FALSE
        AND campaigns.id IN (#{sent_campaign_ids.to_csv})
      ) campaign_stats
      GROUP BY campaign_stats.tenant_id
    }

    if sent_campaign_ids.count > 0
      campaign_stats = ActiveRecord::Base.connection.execute(campaign_stats_query).to_a
      campaign_stats.each do |campaign_stat|
        total_stats[:estimate_count] += campaign_stat["estimate_count"].try(:to_i) || 0
        total_stats[:estimate_total] += campaign_stat["estimate_total"].try(:to_f) || 0.0
        total_stats[:invoice_count] += campaign_stat["invoice_count"].try(:to_i) || 0
        total_stats[:invoice_total] += campaign_stat["invoice_total"].try(:to_f) || 0.0
        total_stats[:messages_count] += campaign_stat["messages_count"].try(:to_i) || 0
        total_stats[:messages_sent] += campaign_stat["messages_sent"].try(:to_i) || 0
        total_stats[:messages_opened] += campaign_stat["messages_opened"].try(:to_i) || 0
        total_stats[:messages_failed] += campaign_stat["messages_failed"].try(:to_i) || 0
        total_stats[:messages_unsubscribed] += campaign_stat["messages_unsubscribed"].try(:to_i) || 0
      end
    else
      campaign_stats = {}
    end

    csv_result = CSV.generate do |csv|
      fields = [
        "date",
        "tenants",
        "total_contacts",
        "new_estimates",
        "new_invoices",
        "emails_sent",
        "opened",
        "total clicks",
        "bounced",
        "unsubscribes"
      ]
      csv << fields

      open_rate = 0

      if total_stats["messages_count"].to_f > 0 && total_stats["messages_opened"].to_f > 0
        open_rate = ((total_stats["messages_opened"].to_f / total_stats["messages_count"].to_f) * 100.0).round
      end

      values = [
        job.tenant.local_strftime(job.data["start_date"]),
        campaign_stats.count,
        total_stats["messages_count"],
        total_stats["estimate_total"],
        total_stats["invoice_total"],
        total_stats["messages_sent"],
        total_stats["messages_opened"],
        open_rate,
        click_stats["unique_clicks"],
        total_stats["messages_failed"],
        total_stats["messages_unsubscribed"]
      ]
      csv << values
    end

    lifespan = 5.minutes
    if end_date < Date.yesterday
      lifespan = 1.year
    end

    {
      total_stats: total_stats,
      campaign_stats: campaign_stats,
      click_stats: click_stats,
      csv: Base64.encode64(csv_result),
      csv_filename: "#{job.name}_#{job.job_hash}".parameterize.underscore,
      lifespan: lifespan
    }
  end

  private

  # Operation
  def change_schedule
    if new_schedule_date && Campaign.valid_datetime?(new_schedule_date)
      self.schedule_date = [self.new_schedule_date]
    end
  end

  # Operation
  def update_scheduled_at
    self.scheduled_at = Time.now if scheduled_changed? || schedule_week_changed? || schedule_weekday_changed? || scheduled_at.nil?
  end

  # Operation
  def make_global_if_enterprise
    self.global = true if self.enterprise_campaign
  end

  has_many :messages, class_name: "CampaignMessage", dependent: :destroy

  # Operation or Job
  def resend_messages
    return if self.paused

    messages.each { |message| message.send(self) }
  end

  # Job
  def alert_calendar_entry_due
    return unless due(tenant)

    CalendarMailer.entry_due_email(tenant, self).deliver_now
  end

end
