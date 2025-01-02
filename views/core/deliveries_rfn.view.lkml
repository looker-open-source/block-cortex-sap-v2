#########################################################{
# PURPOSE
# Provides Delivery details. Note a sales order may have one or more deliveries
#
# SOURCES
# Refines view deliveries
#
# REFERENCED BY
# Explore sales_orders_v2
# View sales_order_item_delivery_summary_ndt
# View across_sales_and_deliveries_xvw
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - This refinement view only includes fields added or edited. Full list of fields available are found in the base view.
#   - Additional fields that require Sales Orders are found in field-only view across_sales_and_deliveries_xvw
#########################################################}

include: "/views/base/deliveries.view"

view: +deliveries {
  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${delivery_vbeln},${delivery_item_posnr}) ;;
  }

#########################################################
# DIMENSIONS: ID fields
#{
  dimension: client_mandt {
    hidden: yes
    label: "@{label_sap_field_name}"
  }

  dimension: delivery_vbeln {
    hidden: no
    label: "Delivery ID@{label_append_sap_code}"
  }

  dimension: delivery_item_posnr {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: material_number_matnr {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_order_number_vgbel {
    hidden: no
    label: "@{label_sap_field_name}"
    }

  dimension: sales_order_item_vgpos {
    hidden: no
    label: "@{label_sap_field_name}"
    }
# } end ID dimensions

#########################################################
# DIMENSIONS: Dates
#{
  dimension_group: date_created_erdat {
    hidden: no
    label: "Creation"
    description: "Creation Date (ERDAT)"
  }

  dimension: create_time_erzet {
    hidden: yes
    label: "Creation Time ERZET"
  }

  dimension: create_timestamp {
    hidden: no
    type: date_time
    group_label: "Creation Date"
    group_item_label: "Time"
    label: "Delivery Create Timestamp"
    sql: TIMESTAMP(concat(${date_created_erdat_raw},' ',${create_time_erzet})) ;;
  }

  dimension_group: delivery_date_lfdat {
    hidden: no
    label: "Delivery"
    description: "Delivery date (LFDAT)"
  }

  dimension_group: proof_of_delivery {
    hidden: no
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date__proofOfDelivery___PODAT ;;
  }

  dimension: proof_of_delivery_timestamp {
    type: date_time
    hidden: no
    group_label: "Proof of Delivery Date"
    group_item_label: "Time"
    sql: timestamp(concat(${proof_of_delivery_raw},' ',${confirmation_time_potim})) ;;
  }

  dimension_group: planned_goods_movement_date_wadat {
    hidden: no
    label: "Goods Movement Planned"
    description: "Planned goods movement date (WADAT)"
  }

  dimension_group: actual_goods_movement_date_wadat_ist {
    hidden: no
    label: "Goods Movement Actual"
    description: "Actual goods movement date (WADAT_IST)"
  }

#} end dates

#########################################################
# DIMENSIONS: Status
#{
  dimension: delivery_type_lfart {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: is_blocked {
    hidden: no
    type: yesno
    sql: (${delivery_block_document_header_lifsk} is not null or
         ${billing_block_in_sd_document_faksk} is not null)
    ;;
  }

  dimension: is_blocked_with_symbols {
    hidden: no
    type: string
    sql: if(${is_blocked},"Blocked","");;
    html: {% if value == "Blocked" %}{%assign sym = "⏹" %}{% assign color = "#D22B2B" %}
            {% else %}
             {%assign sym = "" %}{% assign color = "#080808" %}
            {%endif%}<p style="color: {{color}}"><b> {{sym}} {{value}}</b> </p>;;
  }

  dimension: is_blocked_in_delivery {
    hidden: yes
    type: yesno
    group_label: "Status"
    description: "Delivery Block Document Header (LIFSK) is not null"
    sql:  ${delivery_block_document_header_lifsk} is not null;;
  }

  dimension: is_blocked_in_billing {
    hidden: yes
    type: yesno
    group_label: "Status"
    description: "Billing Block in SD Document (FAKSK) is not null"
    sql:  ${billing_block_in_sd_document_faksk} is not null;;
  }

#} end delivery statuses



#### Delivery Quantity, Price and Value
#{

  dimension: sd_document_currency_waerk {
    hidden: no
    label: "Currency (Source)@{label_append_sap_code}"
  }

  dimension: actual_quantity_delivered_in_sales_units_lfimg {
    hidden: no
    label: "Delivered Quantity@{label_append_sap_code}"
    description: "Actual quantity delivered in sales units (LFMIG)"
    }

  dimension: net_price_netpr {
    hidden: no
    label: "Net Price (Source Currency)@{label_append_sap_code}"
    description: "Net price of item in source currency (NETPR)"
    value_format_name: decimal_2
  }

  dimension: net_value_in_document_currency_netwr {
    hidden: no
    label: "Net Value (Source Currency)@{label_append_sap_code}"
    description: "Net Price * Quantity Delivered in source currency (NETWR)"
  }


#}

  measure: delivery_line_item_count {
    type: count
    hidden: no
    description: "Count of delivery line items"
  }

  measure: delivery_count {
    hidden: no
    description: "Distinct count of delivery VBELN ids (complete and in-progress)"
    type: count_distinct
    sql: ${delivery_vbeln} ;;
  }

  measure: total_delivered_quantity {
    hidden: no
    type: sum
    description: "Sum of delivered quantity in sales units (LFIMG)"
    sql: ${actual_quantity_delivered_in_sales_units_lfimg} ;;
  }

  measure: min_delivery_date_lfdat {
    hidden: yes
    type: date
    sql: min(${delivery_date_lfdat_raw}) ;;
  }

  measure: max_delivery_date_lfdat {
    hidden: yes
    type: date
    sql: max(${delivery_date_lfdat_raw}) ;;
  }

  measure: max_proof_of_delivery_date_podat  {
    hidden: yes
    type: date_time
    sql: max(${proof_of_delivery_raw}) ;;
  }

  measure: max_proof_of_delivery_timestamp  {
    hidden: yes
    type: date_time
    sql: max(${proof_of_delivery_timestamp}) ;;
  }

  measure: min_actual_goods_movement_date_wadat_ist {
    hidden: yes
    type: date_time
    sql: min(${actual_goods_movement_date_wadat_ist_raw}) ;;
  }


}