# Query contacts associated with a campaign
module Campaigns
  class CampaignContactsQuery < BaseQuery
    alias campaign object

    def query
      list = campaign.contact_lists.first

      return Contact.none unless list

      list.all_contacts(
        context.target_tenant,
        context.location,
        context.exclude_oversend || context.campaign.default_override?,
        context.only_oversend,
        context.search,
        context.background)
    end
  end
end
