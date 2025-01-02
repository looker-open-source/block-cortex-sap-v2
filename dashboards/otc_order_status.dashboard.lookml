#########################################################{
# Order Status dashboard provides an overview of order-related metrics,
# including order volume, a breakdown of the order flow status from order to billing,
# and an analysis of order status categories (open, closed, and cancelled).
#
# Extends otc_template and modifies:
#   dashboard_navigation to set parameter_navigation_focus_page: '1'
#
# Visualization Elements:
#   total_sales_orders - single-value viz
#   return_sales_order_percent - single-value viz
#   one_touch_orders_percent - single-value viz
#   blocked_orders - single-value viz
#   order_to_billing_funnel - looker_funnel
#   order_status_donut - looker_pie
#
#########################################################}

- dashboard: otc_order_status
  title: Order Status
  description: "Provides an overview of order-related metrics, including order volume, a breakdown of the order flow status from booking to billing, and an analysis of order status categories (open, closed, and cancelled)."
  extends: otc_template
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '1'
#####################################################################################################
  - name: total_sales_orders
    title: Total Sales Orders
    explore: sales_orders_v2
    type: single_value
    fields: [ sales_orders_v2.sales_order_count_formatted,
              across_sales_and_returns_xvw.has_return_sales_order_percent,
              one_touch_order.one_touch_sales_order_percent,
              across_sales_and_deliveries_xvw.blocked_order_count]
    hidden_fields: [across_sales_and_returns_xvw.has_return_sales_order_percent,
                    one_touch_order.one_touch_sales_order_percent,
                    across_sales_and_deliveries_xvw.blocked_order_count]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
    note_state: collapsed
    note_display: hover
    note_text: "The number of sales orders."
    row: 2
    col: 0
    width: 6
    height: 2
######################################################################################################
  - name: return_sales_order_percent
    title: Return Orders
    explore: sales_orders_v2
    type: single_value
    fields: [ sales_orders_v2.sales_order_count_formatted,
              across_sales_and_returns_xvw.has_return_sales_order_percent,
              one_touch_order.one_touch_sales_order_percent,
              across_sales_and_deliveries_xvw.blocked_order_count]
    hidden_fields: [sales_orders_v2.sales_order_count_formatted,
                    one_touch_order.one_touch_sales_order_percent,
                    across_sales_and_deliveries_xvw.blocked_order_count]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders with a product return."
    row: 2
    col: 6
    width: 6
    height: 2
######################################################################################################
  - name: one_touch_sales_order_percent
    title: One Touch Orders
    explore: sales_orders_v2
    type: single_value
    fields: [ sales_orders_v2.sales_order_count_formatted,
              across_sales_and_returns_xvw.has_return_sales_order_percent,
              one_touch_order.one_touch_sales_order_percent,
              across_sales_and_deliveries_xvw.blocked_order_count]
    hidden_fields: [sales_orders_v2.sales_order_count_formatted,
                    across_sales_and_returns_xvw.has_return_sales_order_percent,
                    across_sales_and_deliveries_xvw.blocked_order_count]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders processed without any holds."
    row: 2
    col: 12
    width: 6
    height: 2
######################################################################################################
  - name: blocked_orders
    title: Blocked Orders
    explore: sales_orders_v2
    type: single_value
    fields: [ sales_orders_v2.sales_order_count_formatted,
              across_sales_and_returns_xvw.has_return_sales_order_percent,
              one_touch_order.one_touch_sales_order_percent,
              across_sales_and_deliveries_xvw.blocked_order_count]
    hidden_fields: [sales_orders_v2.sales_order_count_formatted,
                    across_sales_and_returns_xvw.has_return_sales_order_percent,
                    one_touch_order.one_touch_sales_order_percent]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
    note_state: collapsed
    note_display: hover
    note_text: "The number of sales orders blocked (is on hold or has backorder)."
    row: 2
    col: 18
    width: 6
    height: 2
######################################################################################################
  - name: order_to_billing_funnel
    title: Order to Billing
    explore: sales_orders_v2
    type: looker_funnel
    fields: [sales_orders_v2.total_sales_amount_target_currency_formatted,
            sales_order_item_delivery_summary_ndt.total_delivered_amount_target_currency_formatted,
            across_sales_and_billing_summary_xvw.total_billed_amount_target_currency_formatted]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: rows
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: inline
    color_application:
      collection_id: 1bc1f1d8-7461-4bfd-8c3b-424b924287b5
      custom:
        id: 92e66b84-021e-3146-39de-2f52135eba51
        label: Custom
        type: continuous
        stops:
        - color: "#468FAF"
          offset: 0
        - color: "#013A63"
          offset: 100
      options:
        steps: 3
        reverse: true
    isStepped: true
    labelOverlap: false
    note_state: collapsed
    note_display: hover
    note_text: |-
      Beginning with Total Sales Ordered Amount, this funnel depicts the flow of amounts across the stages of a line item:
      </br>Order
      </br>Delivery
      </br>Billing
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 4
    col: 0
    width: 12
    height: 8
######################################################################################################
  - name: order_status_donut
    title: Order Status
    explore: sales_orders_v2
    type: looker_pie
    fields: [across_sales_and_billing_summary_xvw.order_status, sales_orders_v2.sales_order_count_formatted]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
      across_sales_and_billing_summary_xvw.order_status: "-NULL"
    sorts: [across_sales_and_billing_summary_xvw.order_status desc]
    title_hidden: true
    value_labels: labels
    label_type: labVal
    inner_radius: 60
    start_angle:
    end_angle:
    series_colors:
      Open: "#98B6B1"
      Closed: "#BFBDC1"
      Cancelled: "#EB9486"
    advanced_vis_config: |-
      {
        plotOptions: {
          pie: {
            dataLabels: {
              format: '<b>{key}</b><span style="font-weight: normal"> - <br>{percentage:.1f}%<br>{point.rendered}</span>',
            }
          }
        },
        title: {
          text: 'Order<br>Status',
          verticalAlign: 'middle',
        },
        tooltip: {
          enabled: false,
        },
      }
    note_state: collapsed
    note_display: hover
    note_text: "Percent of Sales Orders by Status: Open, Cancelled, or Closed."
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
    row: 4
    col: 12
    width: 12
    height: 8