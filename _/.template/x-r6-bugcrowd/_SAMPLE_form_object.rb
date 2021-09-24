# SOURCE: 
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/

# NOTES:
# Extract Form Objects
# When multiple ActiveRecord models might be updated by a single form submission, 
# a Form Object can encapsulate the aggregation. 
#
# This is far cleaner than using accepts_nested_attributes_for, which, in my humble opinion, 
# should be deprecated. A common example would be a signup form that results in the creation of 
# both a Company and a User:

class Signup
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :user
  attr_reader :company

  attribute :name, String
  attribute :company_name, String
  attribute :email, String

  validates :email, presence: true
  # … more validations …

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

private

  def persist!
    @company = Company.create!(name: company_name)
    @user = @company.users.create!(name: name, email: email)
  end
end

# USAGE
class SignupsController < ApplicationController
  def create
    @signup = Signup.new(params[:signup])

    if @signup.save
      redirect_to dashboard_path
    else
      render "new"
    end
  end
end