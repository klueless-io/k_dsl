module Gsheet

  class Gs{{camelU settings.Model}}
    include Virtus.model

    # What sort of sample data, e.g. unit-test, unit-test-query
    attribute :sample_key, String

    # What field could we use as a synchronization key
    attribute :sync_{{snake settings.MainKey}}, String

    # Unique test key, this key is used by factory bot unit tests
    attribute :test_key, String

    {{#if relations}}
    # Foreign keys that need to be looked up and attached to this object
    {{#each relations}}
    {{#ifx this.type '==' 'OneToOne'}}
    attribute :sync_fk_{{snake this.name}}, String
    {{/ifx}}
    {{/each}}
    {{/if}}

    def initialize(attributes = nil)
      # Virtus will take your attributes and match them to the attribute definitions listed below
      super(attributes)
    end

    {{#each rows_and_virtual}}
    {{#ifx this.type '==' 'PrimaryKey'}}
    attribute :{{snake this.name}}, Integer
    {{else ifx this.type '==' 'ForeignKey'}}
    attribute :{{snake this.name}}, Integer      # This will be lookedup via a tkey
    {{else ifx this.db_type '==' 'jsonb'}}
    attribute :{{snake this.name}}, Hash
    {{else}}
    attribute :{{snake this.name}}, {{camelU this.type}}
{{/ifx}}
    {{/each}}
  end

end