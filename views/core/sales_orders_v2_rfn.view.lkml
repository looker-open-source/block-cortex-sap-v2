#########################################################{
# PURPOSE
# provides Sales Order Line Items (both Header and Line Items)
#
# SOURCES
# Refines view sales_orders_v2
# References that must also be included in the same Explore:
#    currency_conversion_sdt
#    customers_md_rfn
#    materials_md_rfn
#    divisions_md_rfn
#
# REFERENCED BY
# Explore sales_orders_v2
#
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - This refinement view only includes fields added or edited. Full list of fields available are found in the base view.
#   - Header-level dimensions and measures shown in Explore under view label Sales Orders.
#   - Item-level dimensions and measures shown in Explore under view label Sales Orders Items.
#   - Includes fields which reference other views as outlined above in SOURCES.
#   - This view includes both Orders and Returns. Use document_category_vbtyp to pick which type to include.
#
#########################################################}

include: "/views/base/sales_orders_v2.view"

view: +sales_orders_v2 {
  view_label: "Sales Orders"

  fields_hidden_by_default: yes

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${sales_document_vbeln},${item_posnr});;
  }

#########################################################
# PARAMETERS & FILTERS
#{
# parameter_display_product_level to show either Item or Sales Divisions in visualization
#    used in dimensions selected_product_dimension_id and selected_product_dimension_description

  parameter: parameter_display_product_level {
    hidden: no
    type: unquoted
    view_label: "@{label_view_for_filters}"
    label: "Display Sales Divisions or Items"
    description: "Select whether to display sales divisions or items in report. Use with dimensions Selected Product Dimension ID and Selected Product Dimension Description"
    allowed_value: {label: "Division" value: "Division"}
    allowed_value: {label: "Item" value: "Item"}
    default_value: "Item"
  }

#} end parameters & filters

#########################################################
# DIMENSIONS: Order Attributes
#{

  dimension: client_mandt {
    hidden: yes
    label: "@{label_sap_field_name}"
  }

  dimension: sales_document_vbeln {
    hidden: no
    label: "@{label_sap_field_name}"
    description: "Sales Order Number"
  }

  dimension: sales_document_type_auart {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: document_category_vbtyp {
    hidden: no
    label: "@{label_sap_field_name}"
    description: "Document Category (C, M, J, etc)"
  }

  dimension: sales_organization_vkorg {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: distribution_channel_vtweg {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_group_vkgrp {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_office_vkbur {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: cost_center_hdr_kostl {
    hidden: no
    label: "Cost Center@{label_append_sap_code}"
  }

  #} end order attributes

#########################################################
# DIMENSIONS: Customer
#{
#--> requires Customers MD to be joined in same Explore using sold_to_party_kunnr

  dimension: sold_to_party_kunnr {
    hidden: no
    label: "Sold to Party ID@{label_append_sap_code}"
  }

#--> cross references customers_md
  dimension: customer_name  {
    hidden: no
    label: "{%- if _explore._name == 'sales_orders_v2' -%}Sold to Party Name{%- else -%}Customer Name{%- endif -%}"
    description: "Customer Name (name1)"
    sql: COALESCE(${customers_md.customer_name},CONCAT('Sold to Party: ',${sales_orders_v2.sold_to_party_kunnr})) ;;
  }

#} end customer dimensions

#########################################################
# DIMENSIONS: Currency Conversion
#{
# Requires currency_conversion_sdt to be joined in same Explore

  dimension: currency_hdr_waerk {
    hidden: no
    label: "Currency (Source) @{label_append_sap_code}"
    description: "SD Document Currency at header level"
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
    value_format_name: decimal_4
  }

#}

#########################################################
# DIMENSIONS: Order Dates & Times
#{
  dimension_group: creation_date_erdat {
    hidden: no
    label: "Order"
    description: "Sales Order Creation Date ERDAT"
    timeframes: [raw, date, week, week_of_year, month, quarter, year]
  }

  dimension: day_of_sales_order_creation_date_erdat {
    hidden: no
    group_label: "Order Date"
    group_item_label: "Day of Month"
    description: "Day of month of sales order creation date ERDAT"
  }

  dimension: month_of_sales_order_creation_date_erdat {
    hidden: no
    group_label: "Order Date"
    group_item_label: "Month Number"
    description: "Month number of sales order creation date ERDAT"
  }

  dimension: quarter_of_sales_order_creation_date_erdat {
    hidden: no
    group_label: "Order Date"
    group_item_label: "Quarter Number"
    description: "Quarter number of sales order creation date ERDAT"
  }

  dimension: year_of_sales_order_creation_date_erdat {
    hidden: no
    group_label: "Order Date"
    group_item_label: "Year Number"
    description: "Year number of sales order creation date ERDAT"
    value_format_name: id
  }

  dimension: order_date_as_string {
    hidden: yes
    type: string
    label: "Order Date"
    sql: STRING(${creation_date_erdat_raw}) ;;
  }

  dimension: creation_time_erzet {
    hidden: yes
    group_label: "Order Date"
    group_item_label: "Time"
    sql: FORMAT_TIME('%H:%M:%S',${TABLE}.CreationTime_ERZET) ;;
  }

  dimension: creation_timestamp {
    hidden: no
    type: date_time
    group_label: "Order Date"
    group_item_label: "Time"
    description: "Sales Order Creation Date & Time"
    sql: TIMESTAMP(CONCAT(${creation_date_erdat_raw},' ',${creation_time_erzet})) ;;
    convert_tz: no
  }

  dimension_group: requested_delivery_date_vdatu {
    hidden: no
    label: "Requested Delivery"
    description: "Requested Delivery Date VDATU"
    timeframes: [raw, date, week, week_of_year, month, quarter, year]
  }

  dimension: day_of_requested_delivery_date_vdatu {
    hidden: no
    group_label: "Requested Delivery Date"
    group_item_label: "Day of Month"
    description: "Day of month of requested delivery date VDATU"
  }

  dimension: month_of_requested_delivery_date_vdatu {
    hidden: no
    group_label: "Requested Delivery Date"
    group_item_label: "Month Number"
    description: "Month number of requested delivery date VDATU"
  }

  dimension: quarter_of_requested_delivery_date_vdatu {
    hidden: no
    group_label: "Requested Delivery Date"
    group_item_label: "Quarter Number"
    description: "Quarter number of requested delivery date VDATU"
  }

  dimension: year_of_requested_delivery_date_vdatu {
    hidden: no
    group_label: "Requested Delivery Date"
    group_item_label: "Year Number"
    description: "Year number of requested delivery date VDATU"
    value_format_name: id
  }

#} end dates & times

#########################################################
# DIMENSIONS: Item Attributes
#{
# requires materials_md and divisions_md to be joined in same Explore

  dimension: item_posnr {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
    description: "Item Number"
  }

  dimension: material_number_matnr {
    hidden: no
    view_label: "Sales Orders Items"
    description: "Material number"
    label: "@{label_sap_field_name}"
  }

#--> cross references materials_md
  dimension: material_text_maktx {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
    sql: COALESCE(${materials_md.material_text_maktx},${sales_orders_v2.material_number_matnr}) ;;
  }

  dimension: division_hdr_spart {
    hidden: no
    view_label: "Sales Orders Items"
    label: "Division @{label_append_sap_code}"
  }

#--> cross references divsions_md
  dimension: division_name_vtext {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
    sql: COALESCE(${divisions_md.division_name_vtext},${division_hdr_spart});;
  }

#--> cross references materials_md and divisions_md
  dimension: selected_product_dimension_description {
    hidden: no
    # group_label: "Item Categories & Descriptions"
    view_label: "Sales Orders Items"
    label: "{%- if _field._is_selected -%}
    {%- if sales_orders_v2.parameter_display_product_level._parameter_value == 'Item' -%}Material Text{%- else -%}Division{%- endif -%}
    {%- else -%}Selected Product Dimension Description
    {%- endif -%}"
    description: "Values are either Material Text or Division Description based on user selection for Parameter Display Product Level"
    sql: {% if sales_orders_v2.parameter_display_product_level._parameter_value == 'Item'%}${material_text_maktx}{%else%}${division_name_vtext}{%endif%} ;;
    can_filter: yes
  }

  dimension: selected_product_dimension_id {
    hidden: no
    type: string
    # group_label: "Item Categories & Descriptions"
    view_label: "Sales Orders Items"
    label: "{%- if _field._is_selected -%}
                {%- if parameter_display_product_level._parameter_value == 'Item' -%}Item ID{%- else -%}Division ID{%- endif -%}
            {%- else -%}Selected Product Dimension ID{%- endif -%}"
    description: "Values are either Item ID or Division ID based on user selection for Parameter Display Product Level"
    sql: {% if parameter_display_product_level._parameter_value == 'Item' %}${item_posnr}{%else%}${division_hdr_spart}{%endif%} ;;
    can_filter: yes
    value_format_name: id
  }

  dimension: product_hierarchy_prodh {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
  }

  dimension: item_category_pstyv {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
  }


#} end item attributes

#########################################################
# DIMENSIONS: Item Status
#{

  dimension: rejection_reason_abgru {
    hidden: no
    view_label: "Sales Orders Items"
    label: "@{label_sap_field_name}"
  }

  dimension: is_item_cancelled {
    hidden: no
    type: yesno
    view_label: "Sales Orders Items"
    sql: ${rejection_reason_abgru} is not null and ${rejection_reason_abgru} <> '' ;;
  }

#} end item status dimensions

#########################################################
# DIMENSIONS: Item Quantity
#{
  # dimension: cumulative_order_quantity_kwmeng {
  #   hidden: no
  #   view_label: "Sales Orders Items"
  #   label: "Item Ordered Quantity@{label_append_sap_code}"
  # }

  dimension: ordered_quantity_kwmeng {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Item Quantities"
    label: "@{label_sap_field_name}"
    description: "Ordered quantity of item in sale unit of measure (KWMENG)"
    sql: ${cumulative_order_quantity_kwmeng} ;;
    value_format_name: decimal_0
  }

  dimension: cumulative_confirmed_quantity_kbmeng {
    hidden: no
    view_label: "Sales Orders Items"
    group_label: "Item Quantities"
    label: "Confirmed Quantity@{label_append_sap_code}"
    description: "Cumulative confirmed quantity of item in sale unit of measure (KBMENG)"
  }

  dimension: cumulative_confirmed_quantity_klmeng {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Item Quantities"
    label: "Confirmed Quantity (Base Units)@{label_append_sap_code}"
    description: "Cumulative confirmed quantity of item in base unit of measure (KLMENG)"
    sql: ${cumulative_confirmed_quantity_in_base_uo_m_klmeng} ;;
  }

  dimension: base_unit_of_measure_meins {
    hidden: no
    view_label: "Sales Orders Items"
    group_label: "Item Quantities"
    label: "Base UoM@{label_append_sap_code}"
    description: "Base Unit of Measure (MEINS)"
  }

  dimension: sales_unit_vrkme {
    hidden: no
    view_label: "Sales Orders Items"
    group_label: "Item Quantities"
    label: "@{label_sap_field_name}"
    }

# } end item quantity dimensions

#########################################################
# DIMENSIONS: Item Amounts
#{
# Hidden, as measures based on these dimensions will be shown in Explore
  dimension: net_price_netpr {
    hidden: no
    view_label: "Sales Orders Items"
    group_label: "Item Prices & Discounts"
    label: "Item Price (Source Currency)@{label_append_sap_code}"
    description: "Net Price of Item (Source Currency)"
    value_format_name: decimal_2
  }

  dimension: item_net_price_target_currency_netpr {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Item Prices & Discounts"
    label: "Item Price (Target Currency)@{label_append_sap_code}"
    description: "Net Price of Item (Target Currency)"
    sql: ${sales_orders_v2.net_price_netpr} * ${currency_conversion_sdt.exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: item_ordered_amount {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Item Amounts"
    label: "Ordered Amount (Source Currency)"
    description: "Item Qty * Net Price (Source Currency)"
    sql: ${sales_order_value_line_item_source_currency} ;;
    value_format_name: decimal_2
  }

  dimension: item_ordered_amount_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Item Amounts"
    # label: "Item Ordered Amount (Target Currency)"
    label: "@{label_currency_defaults}{%- assign field_name = 'Ordered Amount' -%}@{label_currency_if_selected}"
    description: "Item Quantity * Net Price (Target Currency)"
    sql:  ${item_net_price_target_currency_netpr} * ${cumulative_order_quantity_kwmeng};;
    value_format_name: decimal_2

  }

#} end item amount dimensions

#########################################################
# MEASURES: Counts & Percent of Total
#{
  measure: order_line_count {
    hidden: no
    type: count
    view_label: "Sales Orders Items"
    description: "Count of order lines"
    }

  measure: order_count {
    hidden: no
    type: count_distinct
    description: "Distinct count of Sales Document VBELN"
    sql: ${sales_document_vbeln} ;;
  }

  measure: sales_order_count {
    hidden: no
    type: count_distinct
    description: "Distinct count of Sales Document VBELN when Document Category VBTYP = C"
    sql: ${sales_document_vbeln} ;;
    filters: [document_category_vbtyp: "C"]
  }

  measure: percent_of_sales_orders {
    hidden: no
    type: percent_of_total
    description: "Column Percent of Sales Orders"
    direction: "column"
    sql: ${sales_order_count} ;;
  }

  measure: sold_to_customer_count {
    hidden: no
    type: count_distinct
    description: "Distinct count of Sold to Party KUNNR"
    sql: ${sold_to_party_kunnr} ;;
  }

  measure: cancelled_order_count {
    hidden: no
    description: "Count of orders with at least 1 item cancelled"
    type: count_distinct
    sql: ${sales_document_vbeln} ;;
    filters: [is_item_cancelled: "Yes"]
  }

  measure: cancelled_order_percent {
    hidden: no
    type: number
    description: "Percent of orders with at least 1 item cancelled"
    sql: SAFE_DIVIDE(${cancelled_order_count}, ${order_count});;
    value_format_name: percent_1
  }

#} end count and percent measures

#########################################################
# MEASURES: Counts Formatted for Large Numbers
#{

  measure: order_count_formatted {
    hidden: no
    type: number
    group_label: "Counts Formatted as Large Numbers"
    description: "Count of orders formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${order_count} ;;
    value_format_name: format_large_numbers_d1
  }

  measure: sales_order_count_formatted {
    hidden: no
    type: number
    group_label: "Counts Formatted as Large Numbers"
    description: "Count of orders with document category VBTYP = C and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${sales_order_count} ;;
    value_format_name: format_large_numbers_d1
    link: {
      label: "Show Sales Orders by Month"
      url: "@{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign measure = 'sales_orders_v2.sales_order_count' %}
      {% assign m = 'sales_orders_v2.creation_date_erdat_month' %}
      {% assign drill_fields =  m | append: ',' | append: measure %}
      @{link_vis_line_chart_1_date_1_measure}
      @{link_build_explore_url}
      "
    }
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_target_dash_id_order_details}
      @{link_build_dashboard_url}
      "
    }
  }

#} end formatted count measures

#########################################################
# MEASURES: Amounts in Source Currency
#{

  measure: total_ordered_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    group_label: "Amounts in Source Currency"
    label: "Total Ordered Amount in Source Currency"
    description: "Sum of ordered amount in source currency. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}${item_ordered_amount}{%- else -%}NULL{%- endif -%} ;;
    value_format_name: decimal_2
    html: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

  measure: total_sales_amount_in_source_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    group_label: "Amounts in Source Currency"
    label: "Total Sales Amount in Source Currency"
    description: "Sum of ordered amount in source currency where document category type = 'C'. Currency (Source) is required field to avoid summing across multiple currencies. If currency not included, a warning message is returned"
    sql: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}${item_ordered_amount}{%- else -%}NULL{%- endif -%} ;;
    filters: [document_category_vbtyp: "C"]
    value_format_name: decimal_2
    html: {%- if sales_orders_v2.currency_hdr_waerk._is_selected -%}{{rendered_value}}{%- else -%}Add Currency (Source) to query as dimension{%- endif -%} ;;
  }

#} end amounts in source currency

#########################################################
# MEASURES: Amounts in Target Currency
#{

  measure: total_ordered_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    # label: "@{label_currency}Total Sales Amount ({{currency}})"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of ordered amounts across orders and lines converted to target currency"
    sql: ${item_ordered_amount_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: total_sales_amount_target_currency {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of ordered amounts across sales orders (document category VBTYP = 'C') converted to target currency"
    sql: ${item_ordered_amount_target_currency} ;;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
    value_format_name: decimal_2
  }

  measure: cumulative_sales_amount_target_currency {
    hidden: no
    type: running_total
    view_label: "Sales Orders Items"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Cumulative sum of sales amount in target currency"
    sql: ${total_sales_amount_target_currency} ;;
    direction: "column"
    value_format_name: decimal_2
  }

  measure: average_ordered_amount_per_order_target_currency {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "@{label_currency_defaults}{%- assign field_name = 'Average Amount per Order' -%}@{label_currency_if_selected}"
    description: "Average amount per order in target currency"
    sql: SAFE_DIVIDE(${total_ordered_amount_target_currency},${order_count});;
    value_format_name: decimal_2
  }



#} end amounts in target currency

#########################################################
# MEASURES: Amounts in Target Currency Formatted for Large Numbers
#{

  measure: total_ordered_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Amounts Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of ordered amount in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_ordered_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
  }

  measure: total_sales_amount_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders Items"
    group_label: "Amounts Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign add_formatted = true -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of ordered amounts across sales orders (document category VBTYP = 'C') converted to target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_sales_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
#-->  opens modal showing sales by month
    link: {
      label: "Show Sales by Month"
      url: "@{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign measure = 'sales_orders_v2.total_sales_amount_target_currency' %}
      {% assign m = 'sales_orders_v2.creation_date_erdat_month' %}
      {% assign drill_fields =  m | append: ',' | append: measure %}
      @{link_vis_line_chart_1_date_1_measure}
      @{link_build_explore_url}
      "
    }
#-->  links to Order Line Details dashboard
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign append_extra_mapping = false %}
      {% assign expl = _explore._name %}
      {% if expl == 'sales_orders_v2' %}
        @{link_map_otc_sales_orders_to_order_details_extra_mapping}
      {% endif %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      {% if append_extra_mapping == true %}
        {% assign source_to_destination_filters_mapping = source_to_destination_filters_mapping | append: extra_mapping %}
      {% endif %}
      @{link_map_otc_target_dash_id_order_details}
      @{link_build_dashboard_url}
      "
    }
  }


  measure: average_ordered_amount_per_order_target_currency_formatted {
    hidden: no
    type: number
    view_label: "Sales Orders"
    label: "@{label_currency_defaults}{%- assign add_formatted = true -%}{%- assign field_name = 'Average Amount per Order' -%}@{label_currency_if_selected}"
    description: "Average amount per order in target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    # label: "@{label_currency}Average Sales per Order ({{currency}}) Formatted"
    sql: ${average_ordered_amount_per_order_target_currency};;
    value_format_name: format_large_numbers_d1
#-->  opens modal showing sales by month
    link: {
      label: "Show Average Sales per Order by Month"
      url: "@{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign measure = 'sales_orders_v2.average_ordered_amount_per_order_target_currency' %}
      {% assign m = 'sales_orders_v2.creation_date_erdat_month' %}
      {% assign drill_fields =  m | append: ',' | append: measure %}
      @{link_vis_line_chart_1_date_1_measure}
      @{link_build_explore_url}
      "
    }
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
      @{link_map_otc_sales_orders_to_order_details_extra_mapping}
      {% if append_extra_mapping == true %}
        {% assign source_to_destination_filters_mapping = source_to_destination_filters_mapping | append: extra_mapping %}
      {% endif %}
      @{link_map_otc_target_dash_id_order_details}
      @{link_build_dashboard_url}
      "
    }
  }

#} end target currency amounts formatted as large numbers

#########################################################
# MEASURES: Misc
#{
  measure: percent_of_total_sales_amount_target_currency {
    hidden: no
    type: percent_of_total
    view_label: "Sales Orders Items"
    label: "Percent of Total Sales (Target Currency)"
    sql: ${total_sales_amount_target_currency} ;;
  }

  measure: total_ordered_quantity {
    hidden: no
    type: sum
    view_label: "Sales Orders Items"
    sql: ${ordered_quantity_kwmeng} ;;
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