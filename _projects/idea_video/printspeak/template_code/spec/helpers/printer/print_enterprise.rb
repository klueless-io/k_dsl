# frozen_string_literal: true

# Print helpers for Enterprises
module Printer
  def print_enterprises(rows = nil, format: :default)
    log.section_heading "Enterprises"

    rows = Enterprise.unscoped.all if rows.nil?

    rows.each do |row|
      print_enterprise_detailed(row) if format == :detailed
      print_enterprise(row) if format == :default
    end
  end

  def print_enterprises_as_table(rows = nil, format: :default)
    log.section_heading "Enterprises"

    rows = Enterprise.unscoped.all if rows.nil?

    tp rows, :id, 'default_group.name', :name, :show_eula, :campaign_test_address, :connection_type, :brand_colors, :show_language
  end

  def print_enterprise(row)
    log.kv "id", row.id
    log.kv "name", row.name
    
    # Has one relationships
    if row.group
      log.kv "group > name", row.group.name if row.group.name
    end

    log.line
  end

  def print_enterprise_detailed(row)
    log.kv "id", row.id
    log.kv "name", row.name
    log.kv "created_at", row.created_at
    log.kv "updated_at", row.updated_at
    log.kv "show_eula", row.show_eula
    log.kv "eula_body", row.eula_body
    log.kv "setup_user", row.setup_user
    log.kv "setup_password", row.setup_password
    log.kv "campaign_test_address", row.campaign_test_address
    log.kv "unsubscribe_template", row.unsubscribe_template
    log.kv "banner_id", row.banner_id
    log.kv "default_email_template_id", row.default_email_template_id
    log.kv "campaign_approval_address", row.campaign_approval_address
    log.kv "intercom_app_id", row.intercom_app_id
    log.kv "freshchat_token", row.freshchat_token
    log.kv "portal_estimate_comment_template_id", row.portal_estimate_comment_template_id
    log.kv "portal_estimate_approved_template_id", row.portal_estimate_approved_template_id
    log.kv "portal_estimate_canceled_template_id", row.portal_estimate_canceled_template_id
    log.kv "portal_estimate_copy", row.portal_estimate_copy
    log.kv "default_company_emailt_id", row.default_company_emailt_id
    log.kv "default_contact_emailt_id", row.default_contact_emailt_id
    log.kv "default_estimate_emailt_id", row.default_estimate_emailt_id
    log.kv "default_order_emailt_id", row.default_order_emailt_id
    log.kv "default_sale_emailt_id", row.default_sale_emailt_id
    log.kv "currency_locale", row.currency_locale
    log.kv "statement_template_name", row.statement_template_name
    log.kv "statement_template", row.statement_template
    log.kv "pdf_gen_link", row.pdf_gen_link
    log.kv "default_salestarget_amount", row.default_salestarget_amount
    log.kv "default_salestarget_number", row.default_salestarget_number
    log.kv "deleted_at", row.deleted_at
    log.kv "api_token", row.api_token
    log.kv "default_inquiry_emailt_id", row.default_inquiry_emailt_id
    log.kv "connection_type", row.connection_type
    log.kv "locale", row.locale
    log.kv "portal_proof_comment_template_id", row.portal_proof_comment_template_id
    log.kv "portal_proof_approved_template_id", row.portal_proof_approved_template_id
    log.kv "portal_proof_copy", row.portal_proof_copy
    log.kv "brand_colors", row.brand_colors
    log.kv "default_roboto_font", row.default_roboto_font
    log.kv "platform_type", row.platform_type
    log.kv "agi_brand", row.agi_brand
    log.kv "show_language", row.show_language
    log.kv "default_shipment_emailt_id", row.default_shipment_emailt_id
    
    # Has one relationships
    if row.group
      log.kv "group > name", row.group.name if row.group.name
    end

    log.line
  end
end
