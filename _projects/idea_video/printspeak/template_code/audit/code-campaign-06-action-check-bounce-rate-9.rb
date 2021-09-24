class Campaign < ActiveRecord::Base
  def check_bounce_rate
    CampaignCommands::CheckBounceRate.call(self)
  end
end

class Utils::SqsRead
  def self.handle_bounce(message)
    message_id = message.try(:[], "mail").try(:[], "messageId")
    campaign_message = CampaignMessage.where(sent_message_id: message_id).first

    campaign_message.contact.unsubscribe("hard_bounce", data: {bounce_reason: bounce_reason, campaign_message_ids: [campaign_message.id]})
      
    campaign_message.failed = true
    campaign_message.failed_reason = "#{message['bounce']['bounceType']}_#{message['bounce']['bounceSubType'].underscore}".upcase
    campaign_message.save
    campaign_message.generate_failed_activity

    campaign_message.campaign.check_bounce_rate
  end
end
