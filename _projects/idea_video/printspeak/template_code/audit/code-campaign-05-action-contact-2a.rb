module Contacts
  class ContactListPresenter < BasePresenter
    alias contact object

    def present
      OpenStruct.new(
        first_name: contact.first_name, last_name: contact.last_name,
        email: contact.email, phone: contact.phone,mobile: contact.mobile
      )
    end
  end
end
