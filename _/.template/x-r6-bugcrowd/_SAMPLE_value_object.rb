# SOURCE: 
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/

# NOTES:
# Value Objects are simple objects whose equality is dependent on their value rather than an identity. They are usually immutable. Date, URI, and Pathname are examples from Ruby’s standard library, but your application can (and almost certainly should) define domain-specific Value Objects as well. Extracting them from ActiveRecords is low hanging refactoring fruit.
# 
# Beyond slimming down the ConstantSnapshot class, this has a number of advantages:

# - The #worse_than? and #better_than? methods provide a more expressive way to compare ratings than Ruby’s built-in operators (e.g. < and >).
# - Defining #hash and #eql? makes it possible to use a Rating as a hash key. Code Climate uses this to idiomatically group constants by their ratings using Enumberable#group_by.
# - The #to_s method allows me to interpolate a Rating into a string (or template) without any extra work.
# - The class definition provides a convenient place for a factory method, returning the correct Rating for a given “remediation cost” (the estimated time it would take to fix all of the smells in a given class).

# Usage
# class ConstantSnapshot < ActiveRecord::Base
#   # …

#   def rating
#     @rating ||= Rating.from_cost(cost)
#   end
# end

class Rating
  include Comparable

  def self.from_cost(cost)
    if cost <= 2
      new("A")
    elsif cost <= 4
      new("B")
    elsif cost <= 8
      new("C")
    elsif cost <= 16
      new("D")
    else
      new("F")
    end
  end

  def initialize(letter)
    @letter = letter
  end

  def better_than?(other)
    self > other
  end

  def <=>(other)
    other.to_s <=> to_s
  end

  def hash
    @letter.hash
  end

  def eql?(other)
    to_s == other.to_s
  end

  def to_s
    @letter.to_s
  end
end