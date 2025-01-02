#########################################################{
# PURPOSE
# Field-only view that references sales_orders_v2 and returns_sdt
#
# REFERENCED BY
# Explore sales_orders_v2
#
# NOTES
#   - When added to an Explore must include both sales_orders_v2 and returns_sdt
#   - Shown in sales_orders_v2 explore as part of Sales Orders or Sales Orders Items depending on level of detail
#########################################################}

view: across_sales_and_returns_xvw {

  label: "Returns"

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${sales_orders_v2.client_mandt},${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr}) ;;
  }

#########################################################
# DIMENSIONS: Item Amounts
#{

  dimension: item_returned_amount {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "Returned Amount (Source Currency)"
    description: "Item Returned Quantity * Net Price (Source Currency)"
    sql:  ${sales_orders_v2.net_price_netpr} * ${returns_sdt.item_return_quantity};;
    value_format_name: decimal_2
  }

  dimension: item_returned_amount_target_currency {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign field_name = 'Returned Amount' -%}@{label_currency_if_selected}"
    description: "Item Returned Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${returns_sdt.item_return_quantity};;
    value_format_name: decimal_2
  }

#} end amount dimensions

#########################################################
# MEASURES: Order Counts
#{

  measure: has_return_sales_order_count {
    type: count_distinct
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    sql: ${returns_sdt.reference_sales_document_vbeln};;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
  }

  measure: has_return_sales_order_percent {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    description: "Percent of Sales Orders with at least 1 item returned"
    sql:  SAFE_DIVIDE(${has_return_sales_order_count},${sales_orders_v2.sales_order_count});;
    value_format_name: percent_1
#-->  returns table of 50 items sorted in descending order of has return sales order percent
    link: {
      label: "Show Top 50 Items with Highest Return Rate"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx, sales_orders_v2.division_name_vtext, across_sales_and_returns_xvw.has_return_sales_order_percent,across_sales_and_returns_xvw.total_returned_amount_target_currency,sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,across_sales_and_returns_xvw.has_return_sales_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#-->  returns table of 50 sold to customers sorted in descending order of has return sales order percent
    link: {
      label: "Show Top 50 Customers with Highest Return Rate"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.sold_to_party_kunnr, sales_orders_v2.customer_name, across_sales_and_returns_xvw.has_return_sales_order_percent,across_sales_and_returns_xvw.total_returned_amount_target_currency,sales_orders_v2.sales_order_count' %}
      {% assign limit = 50 %}
      {% assign default_filters = 'sales_orders_v2.sales_document_category_type_vbtyp=C,across_sales_and_returns_xvw.has_return_sales_order_percent=%3E%200' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }

    link: {
      label: "Show Orders and Lines with Returns"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign header_drill = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols, sales_orders_v2.creation_date_erdat_date, sales_orders_v2.customer_name' %}
      {% assign line_drill = 'sales_orders_v2.item_posnr, sales_orders_v2.material_text_maktx,sales_orders_v2.total_ordered_quantity, returns_sdt.total_returned_quantity, sales_orders_v2.base_unit_of_measure_meins,sales_orders_v2.total_sales_amount_target_currency,across_sales_and_returns_xvw.total_returned_amount_target_currency, returns_sdt.is_return' %}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill | append: ',' %}
      {% assign default_filters = 'returns_sdt.is_return=Yes' %}
      {% assign cell_visualization = '\"sales_orders_v2.total_sales_amount_target_currency\":{\"is_active\":true},\"across_sales_and_returns_xvw.total_returned_amount_target_currency\":{\"is_active\":true}' %}
      {% assign sorts='across_sales_and_returns_xvw.total_returned_amount_target_currency+desc,sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
  }

#} end order count measures

#########################################################
# MEASURES: Return Amounts
#{

  measure: total_returned_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Amounts in Source Currency"
    label: "Total Returned Amount in Source Currency"
    description: "Sum of returned amount in source currency. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}${item_returned_amount}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_returned_amount_target_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Total amount of returned items converted to target currency"
    sql: ${item_returned_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_returned_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Amounts Formatted as Large Numbers{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of returned amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_returned_amount_target_currency} ;;
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
