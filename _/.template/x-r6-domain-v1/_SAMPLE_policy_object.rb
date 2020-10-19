# SOURCE: 
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/

# NOTES:
# Policy Objects
# 
# Sometimes complex read operations might deserve their own objects. 
# In these cases I reach for a Policy Object. This allows you to keep tangential logic, 
# like which users are considered active for analytics purposes, out of your core domain objects. 
# For example:

class ActiveUserPolicy
  def initialize(user)
    @user = user
  end

  def active?
    @user.email_confirmed? &&
    @user.last_login_at > 14.days.ago
  end
end

# This Policy Object encapsulates one business rule, that a user is considered active if 
# they have a confirmed email address and have logged in within the last two weeks. 
# You can also use Policy Objects for a group of business rules like an Authorizer that regulates 
# which data a user can access.
#
# Policy Objects are similar to Service Objects, but I use the term “Service Object” for write operations 
# and “Policy Object” for reads. They are also similar to Query Objects, but Query Objects focus on 
# executing SQL to return a result set, whereas Policy Objects operate on domain models already 
# loaded into memory.