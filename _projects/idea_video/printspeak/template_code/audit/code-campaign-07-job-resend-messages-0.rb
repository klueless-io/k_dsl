class Campaign < ActiveRecord::Base
  # Operation or Job
  def resend_messages
    return if self.paused

    messages.each { |message| message.send(self) }
  end
end
