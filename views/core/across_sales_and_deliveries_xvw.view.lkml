#########################################################{
# PURPOSE
# Field-only view that references sales_orders_v2 and deliveries
#
# REFERENCED BY
# Explore sales_orders_v2
#
# NOTES
#   - When added to an Explore must also include sales_orders_v2
#   - Fields appear under view label "Deliveries"
#########################################################}

view: across_sales_and_deliveries_xvw {

#########################################################
# MEASURES
#{

  measure: blocked_order_count {
    hidden: no
    type: count_distinct
    description: "Count of orders with a least one item blocked in delivery or billing"
    sql:  ${sales_orders_v2.sales_document_vbeln};;
    filters: [deliveries.is_blocked: "Yes"]
#--> opens order line details with filter is blocked = Yes
    link: {
      label: "Order Line Details"
      icon_url: "/favicon.ico"
      url: "
        @{link_build_variable_defaults}
        {% assign link = link_generator._link %}
        {% assign source_to_destination_filters_mapping = '@{link_map_otc_sales_orders_to_order_details}'%}
        @{link_map_otc_target_dash_id_order_details}
        {% assign default_filters='is_blocked=Yes'%}
        {% assign use_default_filters_to_override = true %}
        @{link_build_dashboard_url}
      "
    }
#--> returns table showing blocked order count and percent of total by has_backorder and is_held
    link: {
      label: "Show Sources of Blocks"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'deliveries.is_blocked_in_delivery, deliveries.is_blocked_in_billing, sales_orders_v2.sales_order_count, sales_orders_v2.percent_of_sales_orders' %}
      {% assign default_filters = 'deliveries.is_blocked=Yes' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#--> returns table of blocked orders
    link: {
      label: "Show Blocked Orders"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'sales_orders_v2.sales_document_vbeln, sales_orders_v2.document_category_vbtyp, across_sales_and_billing_summary_xvw.order_status_with_symbols, sales_orders_v2.creation_date_erdat_date, sales_orders_v2.customer_name, sales_orders_v2.total_sales_amount_target_currency, deliveries.is_blocked_in_delivery, deliveries.is_blocked_in_billing' %}
      {% assign default_filters = 'deliveries.is_blocked=Yes' %}
      {% assign sorts = 'sales_orders_v2.total_sales_amount_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
  }

  measure: difference_order_qty_delivery_qty {
    type: number
    label: "Difference between Order Quantity and Delivery Quantity"
    description: "Total ordered quantity minus total delivered quantity"
    sql: ${sales_orders_v2.total_ordered_quantity} - ${deliveries.total_delivered_quantity};;
    value_format_name: decimal_0
#--> returns a table listing order lines sorted in descending order by difference between ordered and fulfilled quantity, ordered amount and ordered date
    link: {
      label: "Show Orders with Differences"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {%- assign header_drill = 'sales_orders_v2.sales_document_vbeln,
        sales_orders_v2.document_category_vbtyp,
        across_sales_and_billing_summary_xvw.order_status_with_symbols,
        sales_orders_v2.creation_date_erdat_date,
        sales_orders_v2.customer_name' -%}
      {%- assign line_drill = 'sales_orders_v2.item_posnr,
        sales_orders_v2.material_text_maktx,
        sales_orders_v2.base_unit_of_measure_mein,
        sales_orders_v2.total_ordered_quantity,
        deliveries.total_delivered_quantity,
        across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty' -%}
      {% assign drill_fields = header_drill | append: ',' | append: line_drill %}
      {% assign sorts = 'across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty+desc,sales_orders_v2.creation_date_erdat_date+desc' %}
      {% assign cell_visualization = '\"across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty\":{\"is_active\":true}' %}
      @{link_vis_table_assign_cell_visualization}
      @{link_build_explore_url}
      "
    }
  }

  measure: percent_difference_order_qty_delivery_qty {
    hidden: no
    type: number
    label: "Percent Difference between Order Quantity and Delivery Quantity"
    description: "(total ordered quantity - total delivered quantity) / total ordered quantity"
    sql: 1 - SAFE_DIVIDE(${deliveries.total_delivered_quantity},${sales_orders_v2.total_ordered_quantity});;
    value_format_name: percent_1
  }

#} end measures


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
