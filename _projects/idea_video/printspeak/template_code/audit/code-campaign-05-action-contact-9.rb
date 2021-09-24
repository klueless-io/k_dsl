module Campaigns
  class ContactsController
    # Paginated list of contacts
    def index
      contact_list = Campaigns::CampaignContactsQuery.query(campaign)
      @contacts = Contacts::ContactListPresenter
                    .present_paginated_collection(contact_list, page: page)
    end

    # Paginated contacts in card format and filtering based on some input
    def cards
      contact_list = Campaigns::CampaignContactsQuery.query(campaign,
                                                        location: location,
                                                        exclude_oversend: false,
                                                        only_oversend: true,
                                                        search: 'abc',
                                                        background: nil)

      @contacts = Contacts::ContactSummaryPresenter
                    .present_paginated_collection(contact_list, page: page)
    end

    # Find contact by ID and display all details
    def show
      @contacts = Contacts::ContactFormPresenter.present(find_contact)
    end
  end
end
