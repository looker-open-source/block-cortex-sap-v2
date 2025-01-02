#########################################################{
# Billing Details dashboard provides
# a table of invoices including details like customer, items,
# invoiced quantities and amounts.
#
# This dashboard is accessed through drills from select KPIs.
#
# Extends otc_template and modifies to:
#   label date filter as Billing Date
#   add filters to support KPI-specific drills
#   update dashboard_navigation to:
#       set parameter_navigation_subject: 'bdetails'
#       set parameter_navigation_focus_page: '5'
#
# Visualization Elements:
#   billing_table
#
#########################################################}

- dashboard: otc_billing_details
  title: Billing Details
  description: 'Provides a table of billing documents including details like customer, items, invoiced quantities and amounts.'
  extends: otc_template
#####################################################################################################
  filters:
  - name: date
    title: Billing Date

  - name: billing_document
    title: Billing Document
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: billing
    field: billing.billing_document_vbeln
    listens_to_filters: [customer_country, customer_name]

  - name: sales_document
    title: Sales Document
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: billing
    field: billing.sales_document_aubel
    listens_to_filters: [customer_country, customer_name]

  - name: is_discount
    title: Is Discounted Item (Yes/No)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: billing
    field: sales_order_pricing_sdt.is_discount

  - name: is_adjusted_price
    title: Is Price-Adjusted Item (Yes/No)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: billing
    field: sales_order_pricing_sdt.is_adjusted_price

  - name: is_intercompany_price
    title: Is Intercompany Price (Yes/No)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: ['Yes','No']
    explore: billing
    field: sales_order_pricing_sdt.is_intercompany_price
#####################################################################################################
  elements:
  - name: dashboard_navigation
    explore: billing
    filters:
      otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '2'
      otc_dashboard_navigation_xvw.parameter_navigation_subject: 'bdetails'
#####################################################################################################
  - name: billing_details
    title: Billing Details
    explore: billing
    type: looker_grid
    fields: [ billing.billing_document_vbeln,
              billing.billing_date_fkdat_date,
              billing.sold_to_party_kunag,
              billing.customer_name,
              billing.sales_document_aubel,
              billing.billing_item_posnr,
              billing.material_number_matnr,
              billing.material_text_maktx,
              billing.actual_billed_quantity_fkimg,
              billing.item_billed_amount_target_currency,
              sales_order_pricing_sdt.discount_amount_target_currency,
              sales_order_pricing_sdt.list_price_target_currency,
              sales_order_pricing_sdt.adjusted_price_target_currency,
              sales_order_pricing_sdt.variance_list_and_adjusted_price_target_currency,
              sales_order_pricing_sdt.intercompany_price_target_currency,
              sales_order_pricing_sdt.variance_list_and_intercompany_price_target_currency
              ]
    sorts: [billing.billing_document_vbeln, billing.line_number]
    limit: 500
    show_row_numbers: false
    size_to_fit: false
    table_theme: transparent
    minimum_column_width: 75
    series_column_widths:
      billing.actual_billed_quantity_fkimg: 75
      billing.item_billed_amount_target_currency: 100
      sales_order_pricing_sdt.discount_amount_target_currency: 100
      sales_order_pricing_sdt.list_price_target_currency: 100
      sales_order_pricing_sdt.adjusted_price_target_currency: 100
      sales_order_pricing_sdt.variance_list_and_adjusted_price_target_currency: 100
      sales_order_pricing_sdt.intercompany_price_target_currency: 100
      sales_order_pricing_sdt.variance_list_and_intercompany_price_target_currency: 100
    series_text_format:
      billing.item_billed_amount_target_currency:
        align: right
      billing.actual_billed_quantity_fkimg:
        align: right
      sales_order_pricing_sdt.discount_amount_target_currency:
        align: right
      sales_order_pricing_sdt.list_price_target_currency:
        align: right
      sales_order_pricing_sdt.adjusted_price_target_currency:
        align: right
      sales_order_pricing_sdt.variance_list_and_adjusted_price_target_currency:
        align: right
      sales_order_pricing_sdt.intercompany_price_target_currency:
        align: right
      sales_order_pricing_sdt.variance_list_and_intercompany_price_target_currency:
        align: right
    note_state: collapsed
    note_display: below
    note_text: |-
      <div style=text-align:left;font-size:11px;color:#808080;">
      Up to 200 rows displayed. To see more, select "Explore From Here" option and adjust row limit.
      </div>
    listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
        billing_document: billing.billing_document_vbeln
        sales_document: billing.sales_document_aubel
        is_discount: sales_order_pricing_sdt.is_discount
        is_adjusted_price: sales_order_pricing_sdt.is_adjusted_price
        is_intercompany_price: sales_order_pricing_sdt.is_intercompany_price
    row: 0
    col: 0
    width: 24
    height: 12