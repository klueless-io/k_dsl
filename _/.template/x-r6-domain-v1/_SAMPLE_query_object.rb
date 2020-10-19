# SOURCE: 
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/

# NOTES:
# Query Objects
#
#


class AbandonedTrialQuery
  def initialize(relation = Account.scoped)
    @relation = relation
  end

  def find_each(&block)
    @relation.
      where(plan: nil, invites_count: 0).
      find_each(&block)
  end
end

# USAGE

AbandonedTrialQuery.new.find_each do |account|
  account.send_offer_for_support
end

old_accounts = Account.where("created_at < ?", 1.month.ago)
old_abandoned_trials = AbandonedTrialQuery.new(old_accounts)
