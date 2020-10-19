module TestData

  # ---------------------------------------------
  # Test Data structure and mapper specifically for {{camelU settings.Model}} API V1
  # ---------------------------------------------

  # {{camelU settings.Model}} object that is returned by API V1 actions
  class TdApi{{camelU settings.Model}}Row
    include Virtus.model

    def initialize(attributes)
      super(attributes)
    end

    {{#each rows}}
    {{#ifx this.type '==' 'Boolean'}}
    attribute :{{snake this.name}}, Boolean
    {{else ifx this.type '==' 'PrimaryKey'}}
    attribute :{{snake this.name}}, Integer
    {{else ifx this.type '==' 'ForeignKey'}}
    attribute :{{snake this.name}}_id, Integer
    {{else ifx this.type '==' 'Integer'}}
    attribute :{{snake this.name}}, Integer
    {{else ifx this.type '==' 'Float'}}
    attribute :{{snake this.name}}, Float
    {{else ifx this.type '==' 'DateTime'}}
    attribute :{{snake this.name}}, DateTime
    {{else}}
    attribute :{{snake this.name}}, String
{{/ifx}}
    {{/each}}

      # Map JSON row from API V1 actions to {{camelU settings.Model}}
    def self.map(data)
      return data.blank? ? nil : TdApi{{camelU settings.Model}}Row.new({
      {{#each rows}}
      {{#ifx this.type '==' 'Boolean'}}
        {{snake this.name}}: !!data['{{snake this.name}}']{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'PrimaryKey'}}
        {{snake this.name}}: data['{{snake this.name}}'].to_i{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'ForeignKey'}}
        {{snake this.name}}_id: data['{{snake this.name}}_id'].to_i{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}}: data['{{snake this.name}}'].to_i{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Float'}}
        {{snake this.name}}: data['{{snake this.name}}'].to_f{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Date'}}
        {{snake this.name}}: data['{{snake this.name}}'].try(:to_datetime){{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}}: data['{{snake this.name}}'].try(:to_datetime){{#if @last}}{{else}},{{/if}}
      {{else}}
        {{snake this.name}}: data['{{snake this.name}}']{{#if @last}}{{else}},{{/if}}
{{/ifx}}
      {{/each}}
      })
    end

  end

end

