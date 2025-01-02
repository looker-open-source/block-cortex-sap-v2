#########################################################{
# PURPOSE
# Field-only view that references sales_orders_v2, sales_order_item_billing_summary_sdt and
# sales_order_item_delivery_summary_ndt
#
# REFERENCED BY
# Explore sales_orders_v2
#
# NOTES
#   - When added to an Explore must include sales_orders_v2, sales_order_item_billing_summary_sdt and
#     sales_order_item_delivery_summary_ndt
#   - Fields shown in sales_orders_v2 explore as part of Sales Orders or Sales Orders Items depending on level of detail
#########################################################}

view: across_sales_and_billing_summary_xvw {

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${sales_orders_v2.client_mandt},${sales_orders_v2.sales_document_vbeln},${sales_orders_v2.item_posnr}) ;;
  }

  dimension: is_order_closed {
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    sql: ${sales_order_item_delivery_summary_ndt.is_order_delivered_in_full} = true AND
         ${sales_order_item_billing_summary_sdt.is_order_billed_in_full} = true ;;
  }

  dimension: order_status {
    type: string
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    sql:  CASE WHEN ${sales_order_item_delivery_summary_ndt.is_order_any_item_cancelled} = true then "Cancelled"
               WHEN ${is_order_closed} = true then "Closed"
               WHEN ${is_order_closed} = false then "Open"
          END ;;
  }

  dimension: order_status_with_symbols {
    type: string
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    sql: ${order_status} ;;
    html: {% if value == "Open" %}{%assign sym = "〇" %}{% assign color = "#98B6B1" %}
          {% elsif value == "Closed" %}{%assign sym = "◉"%}{% assign color = "#BFBDC1" %}
          {% elsif value == "Cancelled" %}{%assign sym = "X"%}{% assign color = "#EB9486" %}
            {% else %}
             {%assign sym = "" %}{% assign color = "#080808" %}
            {%endif%}<p style="color: {{color}}"><b> {{sym}} {{value}}</b> </p>;;
  }

  dimension: item_billed_amount {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "Billed Amount (Source Currency)"
    description: "Item Billed Quantity * Net Price (Source Currency)"
    sql:  ${sales_orders_v2.net_price_netpr} * ${sales_order_item_billing_summary_sdt.billing_quantity};;
    value_format_name: decimal_2
  }

  dimension: item_billed_amount_target_currency {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Amounts{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign field_name = 'Billed Amount' -%}@{label_currency_if_selected}"
    description: "Item Billed Quantity * Net Price (Target Currency)"
    sql:  ${sales_orders_v2.item_net_price_target_currency_netpr} * ${sales_order_item_billing_summary_sdt.billing_quantity};;
    value_format_name: decimal_2
  }

#########################################################
# MEASURES: Billed Amounts
#{

  measure: total_billed_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "Amounts in Source Currency"
    label: "Total Billed Amount in Source Currency"
    description: "Sum of billed amount in source currency. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}${item_billed_amount}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_billed_amount_target_currency {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Total billed amount converted to target currency"
    sql: ${item_billed_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_billed_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Amounts Formatted as Large Numbers{%- endif -%}"
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of billed amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_billed_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

#} end billed amount measures


}
