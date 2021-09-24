class Campaign < ActiveRecord::Base
  def resend_messages
    ResendMessages.perform_later(self)
  end
end
