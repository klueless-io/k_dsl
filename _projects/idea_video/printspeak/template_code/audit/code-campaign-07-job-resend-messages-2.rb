module Campaigns
  class ResendMessages < ApplicationJob
    def perform(campaign)
      return if campaign.paused

      campaign.messages.each { |message| message.send(campaign) }
    end
  end
end
