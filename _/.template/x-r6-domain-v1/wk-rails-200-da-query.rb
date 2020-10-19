module Query

  # {{camelU settings.Model}}Query provides flexible queries against the {{camelU settings.Model}} table.
  #
  # It is useful in user driven queries such as Angular or VUE Widgets where users need flexible querying
  class {{camelU settings.Model}}Query < Query::BaseQuery

    #======================================================================
    # {{camelU settings.Model}}Query
    #======================================================================

    # Construct a query against the {{camelU settings.Model}} table
    # 
    # @example
    #
    # config = <<-JSON
    #     {
    #       "page": {
    #           "no": 2,
    #           "size": 5
    #       },
    #       "filter": {
    #         "search": "bob",
    #         "{{snake settings.key.value}}s": ["bob", "jane"]
    #       },
    #       "sort": [
    #         { "field": "{{snake settings.key.value}}" },  
    #         { "field": "created_at", "direction": "desc" }  
    #       ]
    #     }
    # 
    # query = Query::{{camelU settings.Model}}Query.new(config.parse_json)
    #
    # result = query.run
    # page = query.get_current_page()
    # 
    # For more examples, check out the unit tests at /spec/services/{{snake settings.Model}}_query_spec.rb
    #
    # @param [Hash] options List of filter, pagination and sort options for this query
    # @param [ActiveRecord::Relation] scoped relation to use as the starting point for a query generally you can use the default which is {{camelU settings.Model}}.all
    def initialize(options, relation = {{camelU settings.Model}}.all)
      super relation, '{{camelU settings.Model}}', options
  
      # ID or Comma seperated list of ID's
      @id = get_filter_value('id')

      # Valid values are ['all', 'active', 'inactive']
      @active = get_filter_value('active', 'all').downcase

      # search for words in any order in {{snake settings.key.value}}, ALL words must match, e.g. ben hurr will match 'ben god killer hurr' and 'Mr Hurr, Ben'
      @{{snake settings.key.value}} = get_filter_value('{{snake settings.key.value}}')

      # # search for words in any order in {{snake settings.key.value}}, ANY words must match, e.g. ben hurr will match 'ben god killer hurr' and 'Mr Hurr, Ben'
      # @{{snake settings.key.value}}_any = get_filter_value('{{snake settings.key.value}}_any')

      # # search across multiple text fields with one search time
      # @search = get_filter_value('search')

    end
    
    # Dynamically build the main query using the filters that are passed through
    def query
      # L.block ['{{camelU settings.Model}}', "Query"]

      # @relation = @relation.select("{{#each rows}}{{snake ../settings.Models}}.{{snake this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}")
      @relation = @relation.select("*")

      # One ID or many comma seperated ID's can be passed
      @relation = @relation.where(id: @id.split(','))                         if @id.present?

      # Valid values are ['all', 'active', 'inactive']
      @relation = @relation.where(active: @active.is_equal?('active'))        if @active.present? && ['active', 'inactive'].include?(@active)

      # Suggest iLike All
      @relation = add_suggest_ilike_all(:{{snake settings.key.value}}, @{{snake settings.key.value}}.split(' '))              if @{{snake settings.key.value}}.present?

      # # Suggest iLike Any
      # @relation = add_suggest_ilike_any(:{{snake settings.key.value}}, @{{snake settings.key.value}}_any.split(' '))        if @{{snake settings.key.value}}_any.present?

      # # search across multiple text fields with one search term
      # @relation = add_suggest_ilike(:{{snake settings.key.value}}, @search)
      #                 .or(add_suggest_ilike(:data, @search))                if @search.present?

    end

  end
end
