#########################################################{
# PURPOSE
# Provides Billing details
#
# SOURCES
# Refines view billing
# References that must also be included in the same Explore:
#    currency_conversion_sdt
#    customers_md_rfn
#    materials_md_rfn
#    divisions_md_rfn
#
# REFERENCED BY
# Explore billing
#
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - This refinement view only includes fields added or edited. Full list of fields available are found in the base view.
#   - Header-level dimensions and measures shown in Explore under view label Billing.
#   - Item-level dimensions and measures shown in Explore under view label Billing Items.
#   - Includes fields which reference other views as outlined above in SOURCES.
#
#########################################################}

include: "/views/base/billing.view"

view: +billing {

  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${billing_document_vbeln},${billing_item_posnr});;
  }


#########################################################
# DIMENSIONS: Billing Document Attributes
#{

  dimension: client_mandt {
    hidden: yes
    label: "@{label_sap_field_name}"
  }

  dimension: billing_document_vbeln {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_document_aubel {
    hidden: no
    label: "@{label_sap_field_name}"
#--> opens Order Line Details dashboard for given Order Number
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = false %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      @{link_build_dashboard_url}
      "
    }
  }

  dimension: accounting_document_number_belnr {
    hidden: yes
    label: "@{label_sap_field_name}"
  }

  dimension: sales_organization_vkorg {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: distribution_channel_vtweg {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: billing_category_fktyp {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: is_cancelled {
    hidden: no
    type: yesno
    sql: COALESCE(${TABLE}.BillingDocumentIsCancelled_FKSTO,'No') = 'X' ;;
  }

  dimension: cost_center_kostl {
    hidden: no
    label: "@{label_sap_field_name}"
  }


#} end billing document attributes

#########################################################
# DIMENSIONS: Dates
#{
  dimension_group: billing_date_fkdat {
    hidden: no
    label: "Billing"
  }

  dimension: fiscal_year_gjahr {
    hidden: no
    label: "@{label_sap_field_name}"
  }


#} end date dimensions


#########################################################
# DIMENSIONS: Customer
#{
#--> requires Customers MD to be joined in same Explore using sold_to_party_kunnr

  dimension: sold_to_party_kunag {
    hidden: no
    label: "@{label_sap_field_name}"
  }

#--> cross references customers_md
  dimension: customer_name  {
    hidden: no
    label: "{%- if _explore._name == 'billing' -%}Sold to Party Name{%- else -%}Customer Name{%- endif -%}"
    description: "Customer Name (name1)"
    sql: COALESCE(${customers_md.customer_name},CONCAT('Sold to Party: ',${billing.sold_to_party_kunag})) ;;
  }

#} end customer dimensions

#########################################################
# DIMENSIONS: Currency
#{
# Requires currency_conversion_sdt to be joined in same Explore

  dimension: source_currency_waerk {
    hidden: no
    label: "Currency (Source) @{label_append_sap_code}"
    description: "SD Document Currency"
    sql: ${sd_document_currency_waerk} ;;
  }

  dimension: target_currency {
    hidden: no
    label: "Currency (Target)"
    description:  "Code indicating the target currency into which the source currency is converted"
    sql: {% parameter otc_common_parameters_xvw.parameter_target_currency %} ;;
  }

  dimension: exchange_rate_ukurs {
    hidden: no
    label: "@{label_sap_field_name}"
    sql: ${currency_conversion_sdt.exchange_rate_ukurs} ;;
  }

#} end currency dimensions

#########################################################
# DIMENSIONS: Item Attributes
#{
# requires materials_md and divisions_md to be joined in same Explore

  dimension: billing_item_posnr {
    hidden: no
    view_label: "Billing Items"
    label: "@{label_sap_field_name}"
  }

  dimension: sales_document_item_aupos {
    hidden: no
    view_label: "Billing Items"
    label: "@{label_sap_field_name}"
  }

  dimension: material_number_matnr {
    hidden: no
    view_label: "Billing Items"
    description: "Material number"
    label: "@{label_sap_field_name}"
  }

#--> cross references materials_md
  dimension: material_text_maktx {
    hidden: no
    view_label: "Billing Items"
    label: "@{label_sap_field_name}"
    sql: COALESCE(${materials_md.material_text_maktx},${material_number_matnr}) ;;
  }

  dimension: division_spart {
    hidden: no
    view_label: "Billing Items"
    label: "Division @{label_append_sap_code}"
  }

# #--> cross references divsions_md
  dimension: division_name_vtext {
    hidden: no
    view_label: "Billing Items"
    label: "@{label_sap_field_name}"
    sql: COALESCE(${divisions_md.division_name_vtext},${division_spart});;
  }


#} end item attributes

#########################################################
# DIMENSIONS: Item Monetary & Quantity Amounts
#{
# Hidden, as measures based on these dimensions will be shown in Explore


  dimension: item_billed_amount {
    hidden: no
    type: number
    view_label: "Billing Items"
    label: "Item Billed Amount (Source Currency)"
    description: "Item net value (NETWR)"
    sql: ${net_value_netwr} ;;
    value_format_name: decimal_2
  }

  dimension: item_billed_amount_target_currency {
    hidden: no
    type: number
    view_label: "Billing Items"
    # label: "Item Billed Amount (Target Currency)"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Item net value converted to target currency (NETWR)"
    sql:  ${net_value_netwr} * ${exchange_rate_ukurs};;
    value_format_name: decimal_2
  }

  dimension: tax_amount_mwsbk {
    hidden: no
    view_label: "Billing Items"
    label: "Item Tax Amount (Source Currency)@{label_append_sap_code}"
    description: "Tax amount applied for item in source currency (MWSBK)"
  }

  dimension: tax_amount_target_currency {
    hidden: no
    type: number
    view_label: "Billing Items"
    label: "Item Tax Amount (Target Currency)"
    description: "Tax amount applied for item in target currency (MWSBK)"
    sql: ${tax_amount_mwsbk} *  ${exchange_rate_ukurs} ;;
  }

  dimension: actual_billed_quantity_fkimg {
    hidden: no
    view_label: "Billing Items"
    label: "Item Billed Quantity@{label_append_sap_code}"
  }

#} end item amount dimensions

#########################################################
# MEASURES: Counts
#{
  measure: invoice_count {
    hidden: no
    type: count_distinct
    sql:  CONCAT(${client_mandt},${billing_document_vbeln}) ;;
  }

  measure: invoice_count_formatted {
    hidden: no
    type: number
    description: "Count of invoices formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${invoice_count} ;;
    value_format_name: format_large_numbers_d1
    link: {
      label: "Billing Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = true %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_billing_details}'| append: '||billing_date_fkdat_month|date'%}
      @{link_map_otc_target_dash_id_billing_details}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: invoice_line_count {
    hidden: no
    type: count
    view_label: "Billing Items"
  }

#} end count measures


#########################################################
# MEASURES: Amounts
#{

  measure: total_billed_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "Billing Items"
    group_label: "Amounts in Source Currency"
    label: "Total Billed Amount in Source Currency"
    description: "Sum of billed amount in source currency. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if billing.source_currency_waerk._is_selected -%}${item_billed_amount}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if billing.source_currency_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_billed_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Billing Items"
    # label: "@{label_currency}Total Sales Amount ({{currency}})"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of billed amounts across billing documents and lines converted to target currency"
    sql: ${item_billed_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_billed_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Billing Items"
    group_label: "Amounts Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign add_formatted = true -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of billed amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_billed_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
    link: {
      label: "Billing Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = true %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_billing_details}'| append: '||billing_date_fkdat_month|date'%}
      @{link_map_otc_target_dash_id_billing_details}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: total_tax_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "Billing Items"
    group_label: "Amounts in Source Currency"
    label: "Total Tax Amount in Source Currency"
    description: "Sum of tax amount in source currency (MWSBK). Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if billing.source_currency_waerk._is_selected -%}${tax_amount_mwsbk}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if billing.source_currency_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_tax_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Billing Items"
    # label: "@{label_currency}Total Sales Amount ({{currency}})"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of tax amounts across billing documents and lines converted to target currency"
    sql: ${tax_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_tax_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Billing Items"
    group_label: "Amounts Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign add_formatted = true -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of tax amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_tax_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }


#} end amount measures

#########################################################
# MEASURES: Helper
#{
# Hidden measures used to support url link generation
  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }
#} end helper measures

 }