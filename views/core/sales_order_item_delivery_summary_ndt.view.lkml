#########################################################{
# PURPOSE
# Native derived table that aggregates Delivery details to the Sales Document, Item level and derive
# Order-level delivery status based delivery completeness for all items in order
#
# SOURCE
# Explore sales_orders_v2
# References that must also be included in the same Explore:
#    sales_orders_v2
#
# REFERENCED BY
# Explore sales_orders_v2
# View across_sales_and_billing_summary_xvw
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore
#   - Fields are shown in sales_orders_v2 explore as part of Sales Orders or Sales Orders Items depending on level of detail
#   - Includes fields which reference the sales_orders_v2 view.
#
#########################################################}

include: "/explores/sales_orders_v2.explore.lkml"


view: sales_order_item_delivery_summary_ndt {
  view_label: "Delivery Summary"
  fields_hidden_by_default: yes

  derived_table: {
    explore_source: sales_orders_v2 {
      column: client_mandt {field: sales_orders_v2.client_mandt}
      column: sales_document_vbeln {field: sales_orders_v2.sales_document_vbeln}
      column: document_category_vbtyp { field: sales_orders_v2.document_category_vbtyp}
      column: item_posnr {field: sales_orders_v2.item_posnr}
      column: material_number_matnr { field: sales_orders_v2.material_number_matnr}
      column: is_item_cancelled { field: sales_orders_v2.is_item_cancelled }
      column: creation_timestamp { field: sales_orders_v2.creation_timestamp }
      column: requested_delivery_date_vdatu { field: sales_orders_v2.requested_delivery_date_vdatu_raw }
      column: item_ordered_quantity { field: sales_orders_v2.total_ordered_quantity }
      column: item_delivered_quantity { field: deliveries.total_delivered_quantity }
      column: min_delivery_date_lfdat { field: deliveries.min_delivery_date_lfdat }
      column: max_proof_of_delivery_date_podat { field: deliveries.max_proof_of_delivery_date_podat }
      column: max_proof_of_delivery_timestamp { field: deliveries.max_proof_of_delivery_timestamp }
      column: min_actual_goods_movement_date_wadat_ist { field: deliveries.min_actual_goods_movement_date_wadat_ist}
##--> derived columns
      derived_column: is_order_delivered_in_full {
        sql: min(item_ordered_quantity = item_delivered_quantity) over (partition by  client_mandt, sales_document_vbeln)  ;;}
      derived_column: is_order_on_time {
        sql: min(if(max_proof_of_delivery_date_podat is null,null, max_proof_of_delivery_date_podat <= requested_delivery_date_vdatu)) over (partition by  client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_late {
        sql: max(if(max_proof_of_delivery_date_podat is null,null,max_proof_of_delivery_date_podat > requested_delivery_date_vdatu)) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_delivered {
        sql: min(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_any_item_delivered {
        sql: max(max_proof_of_delivery_date_podat is not null) over (partition by client_mandt, sales_document_vbeln) ;;
      }
      derived_column: is_order_any_item_cancelled {
        sql: max(is_item_cancelled) over (partition by client_mandt, sales_document_vbeln);;
      }
      derived_column: is_order_cancelled {
        sql:min(is_item_cancelled) over (partition by client_mandt, sales_document_vbeln);;
      }
##--> bind_all_filters: yes causes a circular reference if fields based on NDT included as a filter (eg., order_status)
      bind_filters: {from_field:  sales_orders_v2.creation_date_erdat_date
                    to_field:    sales_orders_v2.creation_date_erdat_date}
      bind_filters: {from_field:  sales_orders_v2.creation_date_erdat_month
                     to_field:    sales_orders_v2.creation_date_erdat_month}
      bind_filters: {from_field:  countries_md.country_name_landx
                    to_field:    countries_md.country_name_landx}
      bind_filters: {from_field:  sales_organizations_md.sales_org_name_vtext
                    to_field:    sales_organizations_md.sales_org_name_vtext}
      bind_filters: {from_field:  distribution_channels_md.distribution_channel_name_vtext
                    to_field:    distribution_channels_md.distribution_channel_name_vtext}
      bind_filters: {from_field:  sales_orders_v2.division_name_vtext
                    to_field:    sales_orders_v2.division_name_vtext}
      bind_filters: {from_field:  sales_orders_v2.material_text_maktx
                    to_field:    sales_orders_v2.material_text_maktx}
    }

  }

  dimension: key {
    primary_key: yes
    type: string
    sql: CONCAT(${client_mandt},${sales_document_vbeln},${item_posnr}) ;;
  }

#########################################################
# DIMENSIONS: Order Attributes
#{

  dimension: client_mandt {}

  dimension: sales_document_vbeln {}

  dimension: document_category_vbtyp {}

  dimension: requested_delivery_date_vdatu {
    type: date
  }

  dimension: requested_delivery_date_as_string {
    label: "Requested Delivery Date"
    sql: STRING(${requested_delivery_date_vdatu}) ;;
  }

  dimension: creation_timestamp {
    hidden: yes
  }

  dimension: is_order_delivered_in_full {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    description: "Delivered quantity equals ordered quantity for all items in order"
    sql: ${TABLE}.is_order_delivered_in_full ;;
  }

  dimension: is_order_on_time {
    hidden: no
    type: string
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    label: "Is Order On Time (Yes / No)"
    description: "All items in order have been delivered on time (Proof of Delivery before or on Requested Delivery Date)"
    sql: CASE ${TABLE}.is_order_on_time
            WHEN TRUE then 'Yes'
            WHEN FALSE then 'No'
            WHEN NULL then NULL
         END
    ;;
  }

  dimension: is_order_on_time_and_in_full {
    hidden: no
    type: string
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    label: "Is Order On Time & In Full (OTIF) (Yes / No)"
    sql: CASE WHEN ${TABLE}.is_order_on_time is NULL THEN NULL
              WHEN ${TABLE}.is_order_delivered_in_full = TRUE AND ${TABLE}.is_order_on_time = TRUE THEN 'Yes'
         ELSE 'No'
         END
        ;;
  }

  dimension: is_order_late {
    hidden: no
    type: string
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    label: "Is Order Late (Yes / No)"
    description: "At least 1 item in order has been delivered late (Proof of Delivery after Requested Delivery Date)"
    sql: CASE ${TABLE}.is_order_late
            WHEN TRUE THEN 'Yes'
            WHEN FALSE THEN 'No'
            WHEN NULL THEN NULL
         END
      ;;
  }

  dimension: is_order_delivered {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    description: "All items in order have been delivered with valid Proof of Delivery Date"
    sql: ${TABLE}.is_order_delivered ;;
  }

  dimension: is_order_any_item_delivered {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Delivery Status"
    label: "Has a Delivered Item"
    description: "At least 1 item in order has been delivered with valid Proof of Delivery Date"
    sql: ${TABLE}.is_order_any_item_delivered ;;
  }

  dimension: is_order_any_item_cancelled {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    description: "At least 1 item in order has been cancelled"
    sql: ${TABLE}.is_order_any_item_cancelled ;;
  }

  dimension: is_order_cancelled {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    description: "All items in order have been cancelled"
    sql: ${TABLE}.is_order_cancelled ;;
  }

#} end order attribute dimensions

#########################################################
# DIMENSIONS: Item Attributes
#{

  dimension: item_posnr {}

  dimension: material_number_matnr {}

  dimension: item_ordered_quantity {
    type: number
    description: "Total quantity ordered for the line item"
  }

  dimension: item_delivered_quantity {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Quantities{%- endif -%}"
    label: "Delivered Quantity"
    description: "Quantity delivered for the line item"
    value_format_name: decimal_0
  }

  dimension: min_delivery_date_lfdat {
    hidden: no
    type: date
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    label: "Earliest Delivery Date of Line Item @{label_append_sap_code}"
    description: "Line Item's Minimum Delivery Date (LFDAT)"
  }

  dimension: max_proof_of_delivery_date_podat {
    hidden: no
    type: date
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    label: "Latest Proof of Delivery Date of Line Item @{label_append_sap_code}"
    description: "Line Item's Maximum Proof of Delivery Date (PODAT)"
  }

  dimension: max_proof_of_delivery_date_as_string {
    hidden: yes
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    label: "Latest Proof of Delivery Date of Line Item (String) "
    sql: STRING(${max_proof_of_delivery_date_podat}) ;;
  }

  dimension: max_proof_of_delivery_timestamp {
    hidden: no
    type: date_time
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    label: "Latest Proof of Delivery Timestamp of Line Item"
    description: "Line Item's Latest Proof of Delivery Date & Time PODAT"
    sql: TIMESTAMP(${TABLE}.max_proof_of_delivery_timestamp) ;;
  }

  dimension: min_actual_goods_movement_date_wadat_ist {
    hidden: no
    type: date
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    label: "Earliest Actual Goods Movement Date of Line Item"
    description: "Line Item's First Goods Movement Date (WADAT IST)"
    sql: ${TABLE}.min_actual_goods_movement_date_wadat_ist ;;
  }

  dimension: is_item_delivered {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    sql: ${max_proof_of_delivery_date_podat} is not null ;;
  }

  dimension: is_item_in_full {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    sql: ${item_delivered_quantity} = ${item_ordered_quantity} ;;
  }

  dimension: is_item_on_time {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    sql: ${max_proof_of_delivery_date_podat} <= ${min_delivery_date_lfdat} ;;
  }

  dimension: is_item_late {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Item Delivery Status"
    sql: ${max_proof_of_delivery_date_podat} > ${min_delivery_date_lfdat} ;;
  }

  dimension: item_cycle_time_days {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Cycle Time"
    label: "Order Cycle Time (Days)"
    sql: CASE WHEN ${min_actual_goods_movement_date_wadat_ist} IS NOT NULL THEN
         TIMESTAMP_DIFF(TIMESTAMP(${max_proof_of_delivery_timestamp}),TIMESTAMP(${creation_timestamp}),DAY)
         END;;
  }

  dimension: item_days_late {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Cycle Time"
    description: "Number of days between actual delivery date and requested delivery date. Positive value indicates item arrived late"
    sql: DATE_DIFF(${max_proof_of_delivery_date_podat},${requested_delivery_date_vdatu},DAY) ;;
  }

#} end item-level dimensions

#########################################################
# DIMENSIONS: Item Amounts
#{
#--> cross-reference of sales_orders_v2 fields
  dimension: item_delivered_amount {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "Delivered Amount (Source Currency)"
    description: "Item Delivered Quantity * Net Price (Source Currency)"
    sql:  ${sales_orders_v2.net_price_netpr} * ${sales_order_item_delivery_summary_ndt.item_delivered_quantity};;
    value_format_name: decimal_2
  }

  dimension: item_delivered_amount_target_currency {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign field_name = 'Delivered Amount' -%}@{label_currency_if_selected}"
    description: "Item Delivered Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${sales_order_item_delivery_summary_ndt.item_delivered_quantity};;
    value_format_name: decimal_2
  }

#} end item amount dimensions

#########################################################
# MEASURES: Delivery Order Counts
#{

  measure: delivered_order_count {
    hidden: no
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes"]
  }

  measure: on_time_order_count {
    hidden: no
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_on_time: "Yes"]
  }

  measure: late_order_count {
    hidden: no
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_late: "Yes"]
  }

  measure: in_full_order_count {
    hidden: no
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_delivered_in_full: "Yes"]
  }

  measure: on_time_and_in_full_order_count {
    hidden: no
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    label: "On Time & In Full (OTIF) Order Count"
    sql: ${sales_document_vbeln} ;;
    filters: [is_order_delivered: "Yes",is_order_on_time_and_in_full: "Yes"]
  }


#} end delivery order count measures

#########################################################
# MEASURES: Delivery Counts as Percent of Orders
#{

  measure: delivered_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered"
    sql: SAFE_DIVIDE(${delivered_order_count}, ${sales_orders_v2.order_count}) ;;
    value_format_name: percent_1
  }

  measure: on_time_order_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered on time"
    sql: SAFE_DIVIDE(${on_time_order_count}, ${sales_orders_v2.order_count}) ;;
    value_format_name: percent_1
#--> link to order line details dashboards with filter for is_order_on_time = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_on_time=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: late_order_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders with at least 1 item delivered late (Proof of Delivery after Requested Delivery Date)"
    sql: SAFE_DIVIDE(${late_order_count}, ${sales_orders_v2.order_count}) ;;
    value_format_name: percent_1
#-->  returns table of 50 items sorted in descending order of late order percent
    link: {
      label: "Show Top 50 Items with Highest Late Order Percent"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx, sales_orders_v2.division_name_vtext, sales_order_item_delivery_summary_ndt.late_order_percent, sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,sales_order_item_delivery_summary_ndt.late_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#-->  returns table of 50 sold to customers sorted in descending order of has return sales order percent
    link: {
      label: "Show Top 50 Customers with Highest Late Order Percent"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.sold_to_party_kunnr, sales_orders_v2.customer_name, sales_order_item_delivery_summary_ndt.late_order_percent,sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,sales_order_item_delivery_summary_ndt.late_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
 #-->  returns table of Orders that are Late sorted by Max Days Late (across items in order)
    link: {
      label: "Show Late Orders"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign header_drill = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols, sales_orders_v2.creation_date_erdat_date, sales_orders_v2.customer_name' %}
      {% assign line_drill = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx,sales_order_item_delivery_summary_ndt.item_ordered_quantity, sales_order_item_delivery_summary_ndt.requested_delivery_date_as_string, sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_as_string,sales_order_item_delivery_summary_ndt.max_days_late, sales_order_item_delivery_summary_ndt.item_delivery_quantity' %}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill | append: ',' %}
      {% assign default_filters = 'sales_order_item_delivery_summary_ndt.is_order_late=Yes' %}
      {% assign cell_visualization = '\"sales_order_item_delivery_summary_ndt.max_days_late\":{\"is_active\":true}' %}
      {% assign sorts='sales_order_item_delivery_summary_ndt.max_days_late+desc,sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
#--> link to order line details dashboards with filter for is_order_late = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_late=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: in_full_order_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    sql: SAFE_DIVIDE(${in_full_order_count}, ${sales_orders_v2.order_count}) ;;
    value_format_name: percent_1
#--> link to order line details dashboards with filter for is_order_delivered_in_full = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_delivered_in_full=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: on_time_and_in_full_order_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    label: "On Time & In Full (OTIF) Order Percent"
    description: "% of orders delivered on time and in full (delivered quantity equals ordered quantity for all items in order)"
    sql: SAFE_DIVIDE(${on_time_and_in_full_order_count}, ${sales_orders_v2.order_count}) ;;
    value_format_name: percent_1
#--> link to order line details dashboards with filter for is_order_on_time_and_in_full = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_on_time_and_in_full=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

#} end delivery percents

#########################################################
# MEASURES: Delivery Counts as Percent of Orders Formatted for 0 - 100
#{
##--> converted to 0 to 100 scale to appear correctly in shared tooltips

  measure: on_time_order_percent_formatted {
    hidden: yes
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered on time"
    sql: ${on_time_order_percent} * 100 ;;
    value_format_name: decimal_1
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = false %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' | append: '||sales_orders_v2.creation_date_erdat_month|date' %}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_on_time=Yes' %}
      {% assign use_default_filters_to_override=true %}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: in_full_order_percent_formatted {
    hidden: yes
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    sql: ${in_full_order_percent} * 100 ;;
    value_format_name: decimal_1
#--> link to order line details dashboards with filter for is_delivered_in_full = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'  %}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_delivered_in_full=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: on_time_and_in_full_order_percent_formatted {
    hidden: yes
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "% of orders delivered in full (delivered quantity equals ordered quantity for all items in order)"
    type: number
    sql: ${on_time_and_in_full_order_percent} * 100 ;;
    value_format_name: decimal_1
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
#--> link to order line details dashboards with filter for is_order_on_time_and_in_full = Yes
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = false %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' %}
      @{link_map_otc_target_dash_id_order_details}
      {% assign default_filters='is_order_on_time_and_in_full=Yes'%}
      {% assign use_default_filters_to_override = true %}
      @{link_build_dashboard_url}
      "
    }
  }

#} end delivery percents formatted

#########################################################
# MEASURES: Delivery Amounts
#{

  measure: total_delivered_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Amounts in Source Currency"
    label: "Total Delivered Amount in Source Currency"
    description: "Sum of delivered amount in source currency. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}${item_delivered_amount}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_delivered_amount_target_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Total delivered amount converted to target currency"
    sql: ${item_delivered_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_delivered_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Amounts Formatted as Large Numbers{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of delivered amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_delivered_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

#} end delivery amount measures

#########################################################
# MEASURES: Misc
#{
  measure: avg_order_cycle_time {
    hidden: no
    type: average
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    label: "Item Average Cycle Time per Order (Days)"
    description: "Item's Average Cycle Time per Order (Days between Order and Delivery). Must always include Item Number or Name with this measure."
    sql: ${item_cycle_time_days} ;;
    value_format_name: decimal_1
    required_fields: [material_number_matnr]
#--> returns a table listing fulfilled order lines sorted in descending order by cycle_time_days
    link: {
      label: "Show Fulfillment Details"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign header_drill = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols,  sales_orders_v2.customer_name' %}
      {% assign line_drill = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx,sales_order_item_delivery_summary_ndt.item_ordered_quantity,  sales_order_item_delivery_summary_ndt.item_delivered_quantity' %}
      {% assign cycle_drill = 'sales_orders_v2.creation_date_erdat_date,sales_order_item_delivery_summary_ndt.requested_delivery_date, sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat,sales_order_item_delivery_summary_ndt.item_cycle_time_days' %}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill | append: ',' | append: cycle_drill %}
      {% assign cell_visualization = '\"sales_order_item_delivery_summary_ndt.item_cycle_time_days\":{\"is_active\":true}' %}
      {% assign default_filters = 'sales_order_item_delivery_summary_ndt.is_order_delivered=Yes' %}
      {% assign sorts='sales_order_item_delivery_summary_ndt.item_cycle_time_days+desc,sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
#--> opens Orders Details dashboard
    link: {
      label: "Show Order Details"
      icon_url: "/favicon.ico"
      url: "
        @{link_build_variable_defaults}
        {% assign link = link_generator._link %}
        {% assign filters_mapping = '@{link_map_otc_sales_orders_to_order_details}' %}
        {% assign target_dashboard = _model._name | append: '::otc_order_details' %}
        @{link_build_dashboard_url}
      "
      }
  }

  measure: total_delivered_quantity {
    hidden: no
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    type: sum
    sql: ${item_delivered_quantity} ;;
  }

#} end misc measures

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
