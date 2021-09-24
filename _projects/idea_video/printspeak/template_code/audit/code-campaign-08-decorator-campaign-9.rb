def print
  campaign = Campaign.find(id).decorate

  puts campaign.schedule_week
  # => second_week
  puts campaign.schedule_week_label
  # => In two weeks time
end
