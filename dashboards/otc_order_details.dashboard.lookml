#########################################################{
# Order Details dashboard provides
# a table of orders including details like customer, items,
# ordered quantities and amounts.
#
# This dashboard is accessed through drills from select KPIs.
#
# Extends otc_template and modifies to:
#   add filters to support KPI-specific drills
#   update dashboard_navigation to:
#       set parameter_navigation_focus_page: '4'
#       set parameter_navigation_subject: 'odetails'
#
# Visualization Elements:
#   order_details_table
#########################################################}


- dashboard: otc_order_details
  title: Order Details
  description: 'Provides a table of orders including details like customer, items, ordered quantities and amounts.'
  extends: otc_template
#####################################################################################################
  filters:
  - name: order_status
    title: Order Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    explore: sales_orders_v2
    field: across_sales_and_billing_summary_xvw.order_status

  - name: is_blocked
    title: Is Blocked
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: sales_orders_v2
    field: deliveries.is_blocked

  - name: is_order_on_time
    title: Is Order Delivered On Time
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: sales_orders_v2
    field: sales_order_item_delivery_summary_ndt.is_order_on_time

  - name: is_order_delivered_in_full
    title: Is Order Delivered In Full
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: sales_orders_v2
    field: sales_order_item_delivery_summary_ndt.is_order_delivered_in_full

  - name: is_order_on_time_and_in_full
    title: Is Order Delivered On Time & In Full
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: sales_orders_v2
    field: sales_order_item_delivery_summary_ndt.is_order_on_time_and_in_full

  - name: is_order_late
    title: Is Order Delivered Late
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: sales_orders_v2
    field: sales_order_item_delivery_summary_ndt.is_order_late

  - name: sales_document
    title: Sales Document
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: sales_orders_v2
    field: sales_orders_v2.sales_document_vbeln

#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '4'
      otc_dashboard_navigation_xvw.parameter_navigation_subject: 'odetails'
#####################################################################################################
  - name: order_details_table
    title: Order Details
    explore: sales_orders_v2
    type: looker_grid
    fields: [
             sales_orders_v2.sales_document_vbeln,
             sales_orders_v2.item_posnr,
             sales_orders_v2.material_text_maktx,
             across_sales_and_billing_summary_xvw.order_status_with_symbols,
             deliveries.is_blocked_with_symbols,
             sales_order_partner_function_sdt.customer_names_sold_to,
             sales_order_partner_function_sdt.customer_names_ship_to,
             sales_order_partner_function_sdt.customer_names_bill_to,
             sales_orders_v2.creation_date_erdat_date,
             sales_orders_v2.requested_delivery_date_vdatu_date,
             sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat,
             sales_orders_v2.base_unit_of_measure_meins,
             sales_orders_v2.ordered_quantity_kwmeng,
             sales_order_item_delivery_summary_ndt.item_delivered_quantity,
             sales_orders_v2.item_ordered_amount,
             sales_orders_v2.currency_hdr_waerk,
             sales_orders_v2.item_ordered_amount_target_currency,
             sales_orders_v2.target_currency,
             sales_orders_v2.exchange_rate_ukurs]
    sorts: [sales_orders_v2.sales_document_vbeln, sales_orders_v2.item_posnr]
    limit: 200
    show_view_names: false
    show_row_numbers: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    truncate_header: false
    pinned_columns:
      sales_orders_v2.sales_document_vbeln: left
      sales_orders_v2.item_posnr: left
      sales_orders_v2.material_text_maktx: left
    series_labels:
      across_sales_and_billing_summary_xvw.order_status_with_symbols: Order Status
      deliveries.is_blocked_with_symbols: Is Blocked
      sales_order_item_partner_function_sdt.customer_names_sold_to: Sold To
      sales_order_item_partner_function_sdt.customer_names_ship_to: Ship To
      sales_order_item_partner_function_sdt.customer_names_bill_to: Billed To
      sales_orders_v2.creation_date_erdat_date: Creation Date
      sales_orders_v2.requested_delivery_date_vdatu_date: Requested Delivery Date
      sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat: Proof
        of Delivery Date
      sales_orders_v2.currency_hdr_waerk: Source Currency
      sales_orders_v2.target_currency: Target Currency
      sales_orders_v2.exchange_rate_ukurs: Exchange Rate
    minimum_column_width: 75
    series_column_widths:
      materials_md.material_text_maktx: 250
      sales_orders_v2.creation_date_erdat_date: 100
      sales_orders_v2.requested_delivery_date_vdatu_date: 100
      sales_order_item_delivery_summary_ndt.max_proof_of_delivery_date_podat: 100
      sales_orders_v2.base_unit_of_measure_meins: 75
      sales_orders_v2.ordered_quantity_kwmeng: 100
      sales_order_item_delivery_summary_ndt.item_delivered_quantity: 100
      sales_orders_v2.currency_hdr_waerk: 75
      sales_orders_v2.target_currency: 75
      sales_orders_v2.item_ordered_amount: 100
      sales_orders_v2.item_ordered_amount_target_currency: 100
      sales_orders_v2.exchange_rate_ukurs: 75
    series_text_format:
      across_sales_and_billing_summary_xvw.order_status_with_symbols:
        align: center
      deliveries.is_blocked_with_symbols:
        align: center
      sales_orders_v2.ordered_quantity_kwmeng:
        align: right
      sales_order_item_delivery_summary_ndt.item_delivered_quantity:
        align: right
      sales_orders_v2.currency_hdr_waerk:
        align: center
      sales_orders_v2.item_ordered_amount:
        align: right
      sales_orders_v2.target_currency:
        align: center
      sales_orders_v2.item_ordered_amount_target_currency:
        align: right
      sales_orders_v2.exchange_rate_ukurs:
        align: right
    note_state: collapsed
    note_display: below
    note_text: |-
      <div style=text-align:left;font-size:11px;color:#808080;">
      Up to 200 rows displayed. To see more, select "Explore From Here" option and adjust row limit.
      </div>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      product: sales_orders_v2.material_text_maktx
      division: sales_orders_v2.division_name_vtext
      customer_name: sales_orders_v2.customer_name
      target_currency: otc_common_parameters_xvw.parameter_target_currency
      order_status: across_sales_and_billing_summary_xvw.order_status
      is_blocked: deliveries.is_blocked
      is_order_on_time: sales_order_item_delivery_summary_ndt.is_order_on_time
      is_order_delivered_in_full: sales_order_item_delivery_summary_ndt.is_order_delivered_in_full
      is_order_on_time_and_in_full: sales_order_item_delivery_summary_ndt.is_order_on_time_and_in_full
      is_order_late: sales_order_item_delivery_summary_ndt.is_order_late
      sales_document: sales_orders_v2.sales_document_vbeln
    row: 1
    col: 0
    width: 24
    height: 16