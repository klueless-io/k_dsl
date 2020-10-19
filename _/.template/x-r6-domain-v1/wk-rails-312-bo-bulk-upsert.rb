module BulkUpsert

  class {{camelU settings.Model}}BulkUpsert < BaseBulkUpsert

    def initialize
      super({{camelU settings.Model}})

      @can_destroy_table = true
      
      # Currently not used as this is for SQL bulk insert
      @conflict_keys = ['{{snake settings.key.value}}']
    end

    # Note, this is really a GSheet sync tool and as such probabally should be named that way
    # Two required params would be name of google spreadsheet and name of actual sheet and name or filter key
    #
    # @param [String] source_key Defaults to 'sample' and represents the type of data you would like to sync, e.g. produciton, sample, unit-test
    def sync(source_key: 'production', spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME, worksheet_name: '{{dashify settings.Model}}')

      reader = Gsheet::Reader::Gs{{camelU settings.Model}}Reader.new(spreadsheet_name, worksheet_name)

      reader.read()

      self.source_rows = reader.get_filtered_rows(sample_key: source_key)

      # self.source_rows.each { |r| puts r.attributes}

      self.source_rows.each do |row|

{{#array_has_key_value rows 'db_type' 'jsonb'}}
{{#each rows_fields}}
  {{#ifx this.db_type '==' 'jsonb'}}
        if row.{{snake this.name}}.nil? || row.{{snake this.name}}.blank?
          row.{{snake this.name}} = { config: {} }
        end
  {{/ifx}}
{{/each}}
{{/array_has_key_value}}

        {{#if relations}}
        # Lookup relations that need to be looked up and attached to this object
        {{#each relations}}
        {{#ifx this.type '==' 'OneToOne'}}
        {{snake this.name}} = {{camelU this.name}}.find_by({{snake this.main_key}}: row.sync_fk_{{snake this.name}})

        if {{snake this.name}}.nil?
          L.kv '{{camelU this.name}} (not found)', row.sync_fk_{{snake this.name}}
        end

{{/ifx}}
{{/each}}
{{/if}}
        attributes = {
{{#each relations}}
{{#ifx this.type '==' 'OneToOne'}}
          {{snake this.name}}: {{snake this.name}},
{{/ifx}}
{{/each}}
{{#each rows_fields_and_virtual}}
          {{snake this.name}}: row.{{snake this.name}}{{#if @last}}{{else}},{{/if}}
{{/each}}
        }

{{#if settings.GsCutomLookup}}
        {{snake settings.Model}} = {{settings.GsCutomLookup}}
{{else if settings.key.yes}}
        # Use GsCutomLookup if you want to customize this lookup
        {{snake settings.Model}} = {{camelU settings.Model}}.find_by({{snake settings.key.value}}: row.sync_{{snake settings.key.value}})
{{else}}
        # Use GsLookkupKeys and list keys that can be used as a composite key for finding unique {{camelU settings.Models}}
        # {{snake settings.Model}} = {{camelU settings.Model}}.find_by({{#each settings.GsLookkupKeys}}{{snake .}}: row.{{snake .}}{{#if @last}}{{else}}, {{/if}}{{/each}})
{{/if}}

        if {{snake settings.Model}}.present?
          save(attributes, {{snake settings.Model}})
        else
          save(attributes)
        end

      end

    end

    def save(attributes, {{snake settings.Model}} = nil)
      is_create = {{snake settings.Model}}.nil?
      
      if is_create
        {{snake settings.Model}} = {{camelU settings.Model}}.new(attributes)
      else
        {{snake settings.Model}}.update(attributes)
      end

      if !{{snake settings.Model}}.save
        L.info "Could not #{is_create ? 'create' : 'update'} {{titleize settings.Model}}"
        L.block {{snake settings.Model}}.errors.full_messages
        L.kv '{{camelU settings.key.value}}', {{snake settings.Model}}.{{snake settings.key.value}}
        L.yaml attributes
      end
    end

  end

end
