module CampaignCommands
  class CheckBounceRate
    include Interactor
    include Ensure

    delegate :campaign, to: :context

    def call
      ensure_context_includes :campaign

      return if sent_message_count < 100

      bounce_rate = bounced_message_count.to_f / sent_message_count.to_f
      max_bounce_rate = RegionConfig.get_value("campaign_max_bounce_rate", 5).to_f / 100

      return if bounce_rate <= max_bounce_rate

      pause_campaign
      send_email
    end

    private

    def pause_campaign
      campaign.paused = true
      campaign.save
    end

    def sent_message_count
      @sent_message_count ||= campaign.messages.where(CampaignMessage.failed).or(CampaignMessage.sent).count
    end

    def bounced_message_count
      @bounced_message_count ||= campaign.messages.where(CampaignMessage.failed).count
    end

    def send_email
      addresses = RegionConfig.get_value("campaign_paused_alert", "").split(",").map{|s| s.squish.downcase }
      enterprise_address = campaign.tenant.enterprise.campaign_test_address
      addresses << enterprise_address unless enterprise_address.blank?

      Thread.new do
        Email.ses_send(addresses, "Print Speak: Campaign Paused: #{campaign.tenant.name} - #{campaign.tenant.number} (#{campaign.name})", %Q{
          <p>
            A campaign was paused for #{campaign.tenant.name} (#{campaign.name}).
          </p>
        })
        ActiveRecord::Base.clear_active_connections!
      end
    end
  end
end
