module Contacts
  class ContactFormPresenter < BasePresenter
    alias contact object

    def present
      OpenStruct.new(
        first_name: contact.first_name, last_name: contact.last_name,
        email: contact.email, phone: contact.phone,
        gender: contact.gender, mobile: contact.mobile,
        fax: contact.fax, home_phone: contact.home_phone,
        twitter: contact.twitter, facebook: contact.facebook,website: contact.website,
        buy_frequency: contact.buy_frequency,
      )
    end

    private

    def sales_rep_user
      OpenStruct.new(
        id: contact.sales_rep_user.id,
        name: contact.sales_rep_user.name
      )
    end
  end
end
