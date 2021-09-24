class Campaign < ActiveRecord::Base
  validates :name, length: { minimum: 4 }

  validate :name_must_be_unique, :name_must_not_be_in_global

  def name_must_be_unique
    if self.parent_id.nil?
      found_template = self.tenant.campaigns.where(global: false).where(name: self.name, parent_id: nil)
      found_template = found_template.where.not(id: self.id) if self.id.present?
      if found_template.first.present?
        errors.add(:name, "This name has already been taken by a local campaign!")
      end
    end
  end

  def name_must_not_be_in_global
    if self.parent_id.nil?
      found_template = self.tenant.enterprise.campaigns.where(global: true).where(name: self.name, parent_id: nil)
      found_template = found_template.where.not(id: self.id) if self.id.present?
      if found_template.first.present?
        errors.add(:name, "This name has already been taken by a global campaign!")
      end
    end
  end
end
