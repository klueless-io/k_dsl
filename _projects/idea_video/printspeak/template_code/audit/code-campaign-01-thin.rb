# Persistence, simple validations, relationships & scopes.
class Campaign < ActiveRecord::Base
  attr_accessor :new_schedule_date

  enum status: [:unsent, :sent, :sending, :complete]
  enum method: [:email, :sms, :print, :phone]
  enum schedule_week: { first_week: 1, second_week: 2, third_week: 3, last_week: -1 }

  def steps; ["new", "details", "contact_lists", "test", "confirm"]; end
  
  validates :name, length: { minimum: 4 }
  validate :name_must_be_unique, :name_must_not_be_in_global

  scope :scheduled, -> (tenant) {  }
  scope :without_hidden, -> (tenant) {  }
  scope :require_selected_enterprise, -> (tenant) {  }

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
end
