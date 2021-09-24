class Campaign < ActiveRecord::Base
  enum schedule_week: {first_week: 1, second_week: 2, third_week: 3, last_week: -1}
end

module Campaigns
  class CampaignDecorator < Draper::Decorator
    def schedule_week_label
      case object.schedule_week
      when :first_week
        "Next week"
      when :second_week
        "In two weeks time"
      when :third_week
        distance_of_time_in_words(DateTime.today, DateTime.today + 3.weeks)
      else
        "Overdue"
      end
    end
  end
end
