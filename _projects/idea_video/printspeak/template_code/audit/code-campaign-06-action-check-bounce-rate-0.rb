class Campaign < ActiveRecord::Base
  # Three concerns in this method
  # - Multiple Queries, Lookups & Counts
  # - Procedure
  # - Action (send an email)
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
end
