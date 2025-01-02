#########################################################{
# PURPOSE
# Retrieve information about sales orders, including both
# header-level attributes and line-item details.
#
# SOURCES
# see include: statements
#
# REFERENCED BY
#   LookML dashboards:
#     otc_order_status
#     otc_order_sales_performance
#     otc_order_fulfillment
#     otc_order_details
# NOTES
# - Some fields in sales_orders_v2 reference other views
#   (e.g., customer_name references customers_md.name1_name1).
#   Because the field references are present in sales_orders_v2,
#   some joins do not bring in any additional fields.
#########################################################}

#--> base
include: "/views/core/sales_orders_v2_rfn.view"

#--> facts
include: "/views/core/one_touch_order_rfn.view"
include: "/views/core/currency_conversion_sdt.view"
include: "/views/core/deliveries_rfn.view"
include: "/views/core/sales_order_item_delivery_summary_ndt.view"
include: "/views/core/returns_sdt.view.lkml"
include: "/views/core/sales_order_item_billing_summary_sdt.view"
include: "/views/core/sales_order_partner_function_sdt.view"

#--> included _md views for labels
include: "/views/core/customers_md_rfn.view"
include: "/views/core/materials_md_rfn.view"
include: "/views/core/divisions_md_rfn.view"
include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/distribution_channels_md_rfn.view"
include: "/views/core/countries_md_rfn.view"

#--> field-only views
include: "/views/core/otc_common_parameters_xvw.view"
include: "/views/core/across_sales_and_deliveries_xvw.view"
include: "/views/core/across_sales_and_returns_xvw.view"
include: "/views/core/across_sales_and_billing_summary_xvw.view"

#--> dashboard navigation
include: "/views/core/otc_dashboard_navigation_xvw.view"

explore: sales_orders_v2 {
  label: "Sales Orders"
  description: "Sales Orders including both header and line item details."
  sql_always_where: ${sales_orders_v2.client_mandt}='@{CLIENT_ID}'

 -- and
--      {% if otc_common_parameters_xvw.filter_date._is_filtered %}
--      {% condition otc_common_parameters_xvw.filter_date %} timestamp(${sales_orders_v2.creation_date_erdat_raw}) {% endcondition %}
--      {% else %}
      --filter to last 3 years by default
--      ${sales_orders_v2.creation_date_erdat_raw} >= date_sub(current_date,interval 3 YEAR)
--      {% endif %}
;;

  join: otc_dashboard_navigation_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: otc_common_parameters_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: currency_conversion_sdt {
    type: inner
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt}=${currency_conversion_sdt.client_mandt} AND
            ${sales_orders_v2.currency_waerk}=${currency_conversion_sdt.from_currency_fcurr} AND
            ${sales_orders_v2.creation_date_erdat_raw} = ${currency_conversion_sdt.conv_date};;
    #--> fields are referenced in sales_orders_v2_rfn
    fields: []
  }

  join: materials_md {
    view_label: "Sales Orders Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.material_number_matnr}=${materials_md.material_number_matnr} AND
            ${sales_orders_v2.client_mandt}=${materials_md.client_mandt} AND
            ${materials_md.language_spras} = @{user_language}
             ;;
    #--> fields are referenced in sales_orders_v2_rfn
    fields: []
  }

  join: divisions_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${divisions_md.client_mandt} AND
            ${sales_orders_v2.division_spart} = ${divisions_md.division_spart} AND
            ${divisions_md.language_spras} = @{user_language}
            ;;
    #--> fields are referenced in sales_orders_v2_rfn
    fields: []
  }

  join: sales_organizations_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_organizations_md.client_mandt} AND
            ${sales_orders_v2.sales_organization_vkorg} = ${sales_organizations_md.sales_org_vkorg} AND
            ${sales_organizations_md.language_spras} = @{user_language}
             ;;
    fields: [sales_organizations_md.sales_org_name_vtext]
  }

  join: distribution_channels_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${distribution_channels_md.client_mandt} AND
            ${sales_orders_v2.distribution_channel_vtweg} = ${distribution_channels_md.distribution_channel_vtweg} AND
            ${distribution_channels_md.language_spras} = @{user_language}
            ;;
    fields: [distribution_channels_md.distribution_channel_name_vtext]
  }

  join: customers_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${customers_md.client_mandt} AND
            ${sales_orders_v2.sold_to_party_kunnr} = ${customers_md.customer_number_kunnr} AND
            ${customers_md.language_key_spras} = @{user_language}
           ;;
    #--> fields are referenced in sales_orders_v2_rfn
    fields: []
  }

  join: countries_md {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${countries_md.client_mandt} AND
            ${customers_md.country_key_land1} = ${countries_md.country_key_land1} AND
            ${countries_md.language_spras} = @{user_language}
            ;;
    fields: [countries_md.country_name_landx]
  }

  join: one_touch_order {
    view_label: "Sales Orders"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${one_touch_order.vbapclient_mandt} AND
            ${sales_orders_v2.sales_document_vbeln} = ${one_touch_order.vbapsales_document_vbeln} AND
            ${sales_orders_v2.item_posnr} = ${one_touch_order.vbapsales_document_item_posnr};;
  }

  join: deliveries {
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.client_mandt} = ${deliveries.client_mandt} AND
            ${sales_orders_v2.sales_document_vbeln} = ${deliveries.sales_order_number_vgbel} AND
            ${sales_orders_v2.item_posnr} = ${deliveries.sales_order_item_vgpos} ;;
  }

  join: sales_order_item_delivery_summary_ndt {
    type: inner
    relationship: one_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_item_delivery_summary_ndt.client_mandt} AND
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_item_delivery_summary_ndt.sales_document_vbeln} AND
            ${sales_orders_v2.item_posnr} = ${sales_order_item_delivery_summary_ndt.item_posnr} ;;
  }

  join: returns_sdt {
    type: left_outer
    relationship: one_to_many
    sql_on: ${sales_orders_v2.client_mandt} = ${returns_sdt.client_mandt} AND
            ${sales_orders_v2.sales_document_vbeln} = ${returns_sdt.reference_sales_document_vbeln} AND
            ${sales_orders_v2.item_posnr} = ${returns_sdt.reference_item_posnr} ;;
  }

  join: sales_order_item_billing_summary_sdt {
    type: left_outer
    relationship: one_to_one
    sql_on:   ${sales_orders_v2.client_mandt} = ${sales_order_item_billing_summary_sdt.client_mandt} AND
              ${sales_orders_v2.sales_document_vbeln} = ${sales_order_item_billing_summary_sdt.sales_document_vbeln} AND
              ${sales_orders_v2.item_posnr} = ${sales_order_item_billing_summary_sdt.item_posnr} ;;
  }

  join: sales_order_partner_function_sdt {
    view_label: "Sales Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sales_orders_v2.client_mandt} = ${sales_order_partner_function_sdt.client_mandt} AND
            ${sales_orders_v2.sales_document_vbeln} = ${sales_order_partner_function_sdt.sales_document_vbeln} ;;
  }

  join: across_sales_and_deliveries_xvw {
    view_label: "Deliveries"
    relationship: one_to_one
    sql:  ;;
  }

  join: across_sales_and_returns_xvw {
    relationship: one_to_one
    sql:  ;;
  }

  join: across_sales_and_billing_summary_xvw {
    relationship: one_to_one
    sql:  ;;
  }

}