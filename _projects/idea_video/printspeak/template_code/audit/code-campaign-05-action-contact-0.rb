class Campaign < ActiveRecord::Base

  # Three concerns in this method
  # - Query (x 2)
  # - Cache update
  # - Pagination (cross cutting concern)
  def contacts(target_tenant, page = nil, per = nil, location = nil, exclude_oversend = nil, only_oversend = false, search = nil, sort = nil, direction = nil, background = false)
    # Paginated contacts when no contact_lists
    result = Kaminari.paginate_array(Contact.none, total_count: 0).page(page).per(per)

    exclude_oversend = default_override? if exclude_oversend.nil?

    list = contact_lists.first
    
    # Paginated and filtered contacts when there is contact_lists
    result = list.all_contacts(target_tenant,
      page,
      per,
      false,
      self,
      location,
      exclude_oversend,
      only_oversend,
      search,
      sort,
      direction,
      background) if list

    # Procedure - edge cased that performs a cache update
    if location.nil? && exclude_oversend == default_override? && only_oversend == false
      count = counts.find_or_initialize_by(tenant_id: target_tenant.id)
      count.assign_attributes(total_count: result.total_count)
      count.save
    end

    # Result has a page of contacts
    result
  end
end