class Campaign < ActiveRecord::Base
  enum schedule_week: {first_week: 1, second_week: 2, third_week: 3, last_week: -1}
end
