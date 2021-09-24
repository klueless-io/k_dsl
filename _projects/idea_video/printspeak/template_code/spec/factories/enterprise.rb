# frozen_string_literal: true

FactoryBot.define do
  factory :enterprise do
    # initialize_with { Enterprise.find_or_create_by(name: name) }

    # Default column values
    # TODO: this needs to take into consideration the required flag
    #       default columns should be nil, unless they are required and in that scenario
    #       the value can be uncommented
    # TODO: This needs work from the data dictionary and use the faker gem
    # TODO: This needs to put created_at, updated_at and deleted_at in own traits
    name                                     { nil } # { "Name" }
    show_eula                                { nil } # { true }
    setup_user                               { nil } # { "Setup User" }
    setup_password                           { nil } # { "Setup Password" }
    campaign_test_address                    { nil } # { "Campaign Test Address" }
    banner_id                                { nil } # { 9999 }
    default_email_template_id                { nil } # { 9999 }
    campaign_approval_address                { nil } # { "Campaign Approval Address" }
    intercom_app_id                          { nil } # { "Intercom App" }
    freshchat_token                          { nil } # { "Freshchat Token" }
    portal_estimate_comment_template_id      { nil } # { 9999 }
    portal_estimate_approved_template_id     { nil } # { 9999 }
    portal_estimate_canceled_template_id     { nil } # { 9999 }
    default_company_emailt_id                { nil } # { 9999 }
    default_contact_emailt_id                { nil } # { 9999 }
    default_estimate_emailt_id               { nil } # { 9999 }
    default_order_emailt_id                  { nil } # { 9999 }
    default_sale_emailt_id                   { nil } # { 9999 }
    currency_locale                          { nil } # { "Currency Locale" }
    default_salestarget_amount               { nil } # { 9999 }
    default_salestarget_number               { nil } # { 9999 }
    api_token                                { nil } # { "Api Token" }
    default_inquiry_emailt_id                { nil } # { 9999 }
    connection_type                          { nil } # { "Connection Type" }
    locale                                   { nil } # { "Locale" }
    portal_proof_comment_template_id         { nil } # { 9999 }
    portal_proof_approved_template_id        { nil } # { 9999 }
    brand_colors                             { nil } # { { a: "brand_colors" } }
    default_roboto_font                      { nil } # { true }
    platform_type                            { nil } # { "Platform Type" }
    agi_brand                                { nil } # { true }
    show_language                            { nil } # { true }
    default_shipment_emailt_id               { nil } # { 9999 }


    trait :trait1 do
      name                                   { "A-Name" }
      show_eula                              { true }
      setup_user                             { "A-Setup User" }
      setup_password                         { "A-Setup Password" }
      campaign_test_address                  { "A-Campaign Test Address" }
      banner_id                              { 1111 }
      default_email_template_id              { 1111 }
      campaign_approval_address              { "A-Campaign Approval Address" }
      intercom_app_id                        { "A-Intercom App" }
      freshchat_token                        { "A-Freshchat Token" }
      portal_estimate_comment_template_id    { 1111 }
      portal_estimate_approved_template_id   { 1111 }
      portal_estimate_canceled_template_id   { 1111 }
      default_company_emailt_id              { 1111 }
      default_contact_emailt_id              { 1111 }
      default_estimate_emailt_id             { 1111 }
      default_order_emailt_id                { 1111 }
      default_sale_emailt_id                 { 1111 }
      currency_locale                        { "A-Currency Locale" }
      default_salestarget_amount             { 1111 }
      default_salestarget_number             { 1111 }
      api_token                              { "A-Api Token" }
      default_inquiry_emailt_id              { 1111 }
      connection_type                        { "A-Connection Type" }
      locale                                 { "A-Locale" }
      portal_proof_comment_template_id       { 1111 }
      portal_proof_approved_template_id      { 1111 }
      brand_colors                           { { a: "A-brand_colors" } }
      default_roboto_font                    { true }
      platform_type                          { "A-Platform Type" }
      agi_brand                              { true }
      show_language                          { true }
      default_shipment_emailt_id             { 1111 }
    end

    trait :trait2 do
      name                                   { "B-Name" }
      show_eula                              { false }
      setup_user                             { "B-Setup User" }
      setup_password                         { "B-Setup Password" }
      campaign_test_address                  { "B-Campaign Test Address" }
      banner_id                              { 2222 }
      default_email_template_id              { 2222 }
      campaign_approval_address              { "B-Campaign Approval Address" }
      intercom_app_id                        { "B-Intercom App" }
      freshchat_token                        { "B-Freshchat Token" }
      portal_estimate_comment_template_id    { 2222 }
      portal_estimate_approved_template_id   { 2222 }
      portal_estimate_canceled_template_id   { 2222 }
      default_company_emailt_id              { 2222 }
      default_contact_emailt_id              { 2222 }
      default_estimate_emailt_id             { 2222 }
      default_order_emailt_id                { 2222 }
      default_sale_emailt_id                 { 2222 }
      currency_locale                        { "B-Currency Locale" }
      default_salestarget_amount             { 2222 }
      default_salestarget_number             { 2222 }
      api_token                              { "B-Api Token" }
      default_inquiry_emailt_id              { 2222 }
      connection_type                        { "B-Connection Type" }
      locale                                 { "B-Locale" }
      portal_proof_comment_template_id       { 2222 }
      portal_proof_approved_template_id      { 2222 }
      brand_colors                           { { a: "B-brand_colors" } }
      default_roboto_font                    { false }
      platform_type                          { "B-Platform Type" }
      agi_brand                              { false }
      show_language                          { false }
      default_shipment_emailt_id             { 2222 }
    end

    trait :trait3 do
      name                                   { "C-Name" }
      show_eula                              { true }
      setup_user                             { "C-Setup User" }
      setup_password                         { "C-Setup Password" }
      campaign_test_address                  { "C-Campaign Test Address" }
      banner_id                              { 3333 }
      default_email_template_id              { 3333 }
      campaign_approval_address              { "C-Campaign Approval Address" }
      intercom_app_id                        { "C-Intercom App" }
      freshchat_token                        { "C-Freshchat Token" }
      portal_estimate_comment_template_id    { 3333 }
      portal_estimate_approved_template_id   { 3333 }
      portal_estimate_canceled_template_id   { 3333 }
      default_company_emailt_id              { 3333 }
      default_contact_emailt_id              { 3333 }
      default_estimate_emailt_id             { 3333 }
      default_order_emailt_id                { 3333 }
      default_sale_emailt_id                 { 3333 }
      currency_locale                        { "C-Currency Locale" }
      default_salestarget_amount             { 3333 }
      default_salestarget_number             { 3333 }
      api_token                              { "C-Api Token" }
      default_inquiry_emailt_id              { 3333 }
      connection_type                        { "C-Connection Type" }
      locale                                 { "C-Locale" }
      portal_proof_comment_template_id       { 3333 }
      portal_proof_approved_template_id      { 3333 }
      brand_colors                           { { a: "C-brand_colors" } }
      default_roboto_font                    { true }
      platform_type                          { "C-Platform Type" }
      agi_brand                              { true }
      show_language                          { true }
      default_shipment_emailt_id             { 3333 }
    end

    trait :deleted_at do
      deleted_at                             { Date.parse "01 Jan 2017" }
    end
  end
end
