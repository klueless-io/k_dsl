ActiveAdmin.register {{camelU settings.Model}} do

  menu false

  permit_params {{#each rows_and_virtual}}:{{snake this.name}}{{#ifx this.type '==' 'ForeignKey'}}_id{{/ifx}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{#each relations_many_to_many}}, {{snake this.name}}_ids: []{{/each}}

  # ----------------------------------------------------------------------
  # Custom Action Buttons
  # ----------------------------------------------------------------------

{{#ifx settings.ModelType '==' 'AdminUser'}}
  # action_item :destroy_table, :only => :index do
  #   link_to 'Destroy ', :action => 'destroy_table_action'
  # end

  # action_item :destroy_table, :only => :index do
  #   link_to 'Destroy ', :action => 'destroy_table_action'
  # end

  # action_item :synch_table, :only => :index do
  #   link_to 'Synchronize', :action => 'synch_table_action'
  # end

  # todo-dave support this setting in DomainModel
  batch_action :destroy, false
{{else ifx settings.ModelType '==' 'BasicUser'}}
  # action_item :destroy_table, :only => :index do
  #   link_to 'Destroy ', :action => 'destroy_table_action'
  # end

  action_item :destroy_table, :only => :index do
    link_to 'Destroy ', action: :destroy_table_action
  end

  action_item :synch_table, :only => :index do
    link_to 'Synchronize', action: :synch_table_action
  end
{{else}}
  action_item :destroy_table, :only => :index do
    link_to 'Destroy ', action: :destroy_table_action
  end

  action_item :synch_table, :only => :index do
    link_to 'Synchronize', action: :synch_table_action
  end

  action_item :copy, :only => :show do
    link_to 'Make a Copy', action: :clone_{{snake settings.Model}}
  end
{{/ifx}}

  {{#if relations_one_to_one}}
  includes {{#each relations_one_to_one}}:{{this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{/if}}
  
  # ----------------------------------------------------------------------
  # Scoped Views
  # ----------------------------------------------------------------------
  scope :all, default: true

{{#each relations}}
{{#ifx this.type '==' 'OneToOne'}}
  # scope("{{titleize this.name}}") { |scope| scope.joins(:{{snake this.name}}) }
{{/ifx}}
{{/each}}

  # Complex examples (Find in Klue-Video - app/admin/video_slide.rb)
  # scope("Man") { |scope| scope.joins(video_deck: { video_config: :project }).where(projects: {name: '01-gents-territory' }) }
  # scope("Golf") { |scope| scope.joins(video_deck: { video_config: :project }).where(projects: {name: '02-golf-gears-direct' }) }

  # ----------------------------------------------------------------------
  # Index Columns
  # ----------------------------------------------------------------------
  index do
    selectable_column
    id_column
{{#each relations_one_to_one}}
    column :{{this.name}}
{{/each}}
{{#each rows_fields}}
    column :{{snake this.name}}
{{/each}}
{{#each relations_one_to_many}}
    column '{{titleize (humanize this.name_plural)}}' do |{{snake ../settings.Model}}|
      count = {{camelU this.name}}.where({{snake ../settings.Model}}_id: {{snake ../settings.Model}}.id).count

      if count == 0
        'None'
      else
        link_to count, admin_{{snake this.name_plural}}_path(
          q: { {{snake ../settings.Model}}_id_eq: {{snake ../settings.Model}}.id },
          order: :created_at,
          scope: :all
      )
      end
    end
{{/each}}
    actions
  end

  # ----------------------------------------------------------------------
  # Filters for Index Columns
  # ----------------------------------------------------------------------
{{#each relations_one_to_one}}
  filter :{{this.name}}
  # Alternative (lookup by string)
  # filter :{{this.name}}_name, as: :string
  # Alternative (lookup by custom query)
  # filter :{{snake this.name}}, collection: -> {
  #   {{camelU this.name}}.select { |{{snake this.name}}| {{snake this.name}}.active? }
  # }
{{/each}}
{{#each rows_fields}}
  filter :{{snake this.name}}, label: '{{titleize (humanize this.name)}}'
{{/each}}

  # ----------------------------------------------------------------------
  # Edit Form
  # ----------------------------------------------------------------------
  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Admin Details" do

{{#each relations}}
{{#ifx this.type '==' 'OneToOne'}}
      f.input :{{this.name}}
{{/ifx}}
{{/each}}
{{#each rows_and_virtual}}
{{#ifx this.type '==' 'Date'}}
      f.input :{{snake this.name}}, as: :datepicker
{{else ifx this.type '==' 'PrimaryKey'}}
      f.input :id, input_html: { disabled: true }
{{else ifx this.type '==' 'ForeignKey'}}
{{else}}
      f.input :{{snake this.name}}
{{/ifx}}
{{/each}}

{{#if relations_many_to_many}}
      # Many to Many
{{#each relations_many_to_many}}
      f.input :{{snake this.name_plural}}, label: '{{titleize (humanize this.name_plural)}}',
              as: :select, collection: {{camelU this.name}}.all, #.where(somefield: resource.somefield),
              include_blank: false, multiple: true, input_html: { class: 'multiple-select' }
{{/each}}
{{/if}}

    end
    f.actions
  end

  # ----------------------------------------------------------------------
  # Show Form
  # ----------------------------------------------------------------------
  show do |f|
    attributes_table do

{{#each relations}}
{{#ifx this.type '==' 'OneToOne'}}
      row :{{this.name}}
{{/ifx}}
{{/each}}
{{#each rows_fields_and_pk}}
      row :{{snake this.name}}
    {{/each}}

{{#if relations_many_to_many}}
      # Many to Many
{{#each relations_many_to_many}}
      row :{{snake this.name_plural}} do
        f.{{snake this.name_plural}}.map(&:name).sort.join(', ')
      end
{{/each}}
{{/if}}

    end
  end

  # ----------------------------------------------------------------------
  # Custom Actions
  # ----------------------------------------------------------------------
  
{{#ifx settings.ModelType '==' 'AdminUser'}}
  # member_action :clone_{{snake settings.Model}}, method: :get do
  #   {{snake settings.Model}} = {{camelU settings.Model}}.find(params[:id])
  #   @{{snake settings.Model}} = {{snake settings.Model}}.dup
  #
  #   render :new, layout: false
  # end

  # collection_action :destroy_table_action do
  #   SynchronizeService.{{snake settings.Models}}(reset_table: true)
  #
  #   redirect_to admin_{{snake settings.Models}}_path
  # end

  # collection_action :synch_table_action do
  #   SynchronizeService.{{snake settings.Models}}(sync: true)
  #
  #   redirect_to admin_{{snake settings.Models}}_path
  # end
{{else ifx settings.ModelType '==' 'BasicUser'}}
  # member_action :clone_{{snake settings.Model}}, method: :get do
  #   {{snake settings.Model}} = {{camelU settings.Model}}.find(params[:id])
  #   @{{snake settings.Model}} = {{snake settings.Model}}.dup
  #
  #   render :new, layout: false
  # end

  collection_action :destroy_table_action do
    SynchronizeService.{{snake settings.Models}}(reset_table: true)

    redirect_to admin_{{snake settings.Models}}_path
  end

  collection_action :synch_table_action do
    SynchronizeService.{{snake settings.Models}}(sync: true)

    redirect_to admin_{{snake settings.Models}}_path
  end
{{else}}
  member_action :clone_{{snake settings.Model}}, method: :get do
    # {{snake settings.Model}} = {{camelU settings.Model}}.find(params[:id])
    # @{{snake settings.Model}} = {{snake settings.Model}}.dup
    @{{snake settings.Model}} = resource.dup

    render :new, layout: false
  end

  collection_action :destroy_table_action do
    SynchronizeService.{{snake settings.Models}}(reset_table: true)

    redirect_to admin_{{snake settings.Models}}_path
  end

  collection_action :synch_table_action do
    SynchronizeService.{{snake settings.Models}}(sync: true)

    redirect_to admin_{{snake settings.Models}}_path
  end
{{/ifx}}
end

# ----------------------------------------------------------------------
# Optional Extras
# ----------------------------------------------------------------------
#
# * Put near the top if you need different sort order
# 
# config.sort_order = 'created_at_desc'
#
# * Disable some of the custom actions
#
# actions :all, except: [:destroy]  # disable delete on {{camelU settings.Model}}
#
# * Change default scope
# 
# controller do
#   def scoped_collection
#     {{camelU settings.Model}}.unscoped
#   end
# end
#
# * Setup a batch action
# 
# batch_action :make_inactive do |{{snake this.name}}_ids|
#   batch_action_collection.where(id: {{snake this.name}}_ids).each do |account|
#     {{snake this.name}}.active = false
#     {{snake this.name}}.save
#   end
#   redirect_back(fallback_location: collection_path)   # index
# end
#
# * Sample Code that can go into a an index Action
#
# column 'Account Owner' do |account|
#   if account.user.present?
#     link_to account.user.name, admin_user_path(account.user)
#   else
#     'WARN: Account has no owner!'
#   end
# end
# column 'Companies' do |account| 
#   if account.staffroom.present?
#     link_to(account.staffroom.name, admin_company_path(account.staffroom))
#   else
#     'WARN: No companies assigned to account!'
#   end
# end
# 
# * Sample Code that can go into a form Action for custom attributes against a textbox
# 
# f.input :user_id, input_html: {
#  :class       => 'select-user-email',
#  'value-text' => f.object.user ? f.object.user.email : nil,
# }
#
# * Sample Code that can go into a form Action for HINTS
# 
# f.input :automatic_payment_enabled, hint: 'NOTE: If you turn automatic payments off, you will not be able to get automatic invoices turned back on without intervention by developers due to a flaw in billing system. Have a lovely day :)'
#
# * Sample Code that can go into an Index Action for custom links
# 
# row 'Companies' do |resource|
#   if resource.staffroom.present?
#     link_to(resource.staffroom.company.name, admin_company_path(resource.staffroom.company))
#   else
#     'WARN: No companies assigned to account!'
#   end
# end
# row :account_state do |resource|
#   status_tag resource.account_state.humanize
# end
#
# * Sample Codes that can go into a Show Action for JSON
#
# row :config do
#   if {{snake settings.Model}}.config
#       pre JSON.pretty_generate({{snake settings.Model}}.config_as_hash)
#   end
# end
#
# * Custom CSV
#
# csv do
{{#each relations_one_to_one}}
#   column :{{this.name}}
{{/each}}
{{#each rows_fields_and_pk}}
#   column :{{snake this.name}}
{{/each}}
# end
