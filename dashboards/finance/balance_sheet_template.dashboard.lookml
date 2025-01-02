#########################################################{
# Balance Sheet template which must be EXTENDED into another dashboard
#
# defines the following elements which can be shared across Balance Sheet-related dashboards:
#  - Summary Title visualization which appears at top of Balance Sheet dashboards
#  - Filters including default values:
#       fiscal_period
#       comparison_type
#       custom_comparison_period
#       target_currency
#       hierarchy
#       chart_of_accounts
#       company_code
#       ledger_name
#       top_hierarchy_level
#
# The Elements and their properties can be EXTENDED into other dashboards and modified further as necessary
#########################################################}

- dashboard: balance_sheet_template
  title: Balance Sheet Template
  description: "Template of filters and other shared elements between Balance Sheet dashboards. Must be extended into another dashboard."
  layout: newspaper
  preferred_viewer: dashboards-next
  filters_location_top: false
  extension: required
#####################################################################################################
  filters:
  - name: fiscal_period
    title: Fiscal Period
    type: field_filter
    # assumes as 12 month fiscal period that aligns with calendar. Will find last complete month and select period with same value
    default_value: "{% if _user_attributes['cortex_sap_use_test_data']=='Yes'%}{% assign ym = '2023.011'%}{%else%}{% assign intervalDays = 31 %}{% assign intervalSeconds = intervalDays | times: 86400 %}{% assign daysMinus31 = 'now' | date: '%s' | minus: intervalSeconds %}{% assign m = daysMinus31 | date: '%m' | prepend: '00' | slice: -3,3 %}{% assign ym = daysMinus31 | date: '%Y' | append: '.' | append: m %}{%endif%}{{ym}}"
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.parameter_fiscal_period

  - name: comparison_type
    title: Comparison Type
    type: field_filter
    default_value: yoy
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.parameter_comparison_type

  - name: custom_comparison_period
    title: Custom Comparison Period
    type: field_filter
    default_value: ''
    allow_multiple_values: false
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.parameter_custom_comparison_period

  - name: target_currency
    title: Target Currency
    type: field_filter
    default_value: "{{ _user_attributes['cortex_sap_default_target_currency'] }}"
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.target_currency_tcurr

  - name: hierarchy
    title: Hierarchy
    type: field_filter
    default_value: FPA1
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.hierarchy_name

  - name: chart_of_accounts
    title: Chart of Accounts
    type: field_filter
    default_value: 'CA01'
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet.chart_of_accounts

  - name: company_code
    title: Company Code
    type: field_filter
    default_value: "%CENTRAL%"
    allow_multiple_values: false
    required: false
    ui_config:
      type: tag_list
      display: inline
    explore: balance_sheet
    field: balance_sheet.company_text

  - name: ledger_name
    title: Ledger Name
    type: field_filter
    default_value: "%0L%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: inline
    explore: balance_sheet
    field: universal_ledgers_md.ledger_id_name

  - name: top_hierarchy_level
    title: Top Hierarchy Level
    type: field_filter
    default_value: '2'
    allow_multiple_values: false
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    explore: balance_sheet
    field: balance_sheet_hierarchy_selection_sdt.parameter_pick_start_level
#####################################################################################################
  elements:
  - name: summary
    title: Summary Title
    explore: balance_sheet
    type: single_value
    fields: [balance_sheet.title_balance_sheet]
    filters:
    balance_sheet.level_number: '3,4'
    balance_sheet_fiscal_periods_selected_sdt.fiscal_period_group: 'Reporting'
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    listen:
      fiscal_period: balance_sheet.parameter_fiscal_period
      target_currency: balance_sheet.target_currency_tcurr
      hierarchy: balance_sheet.hierarchy_name
      chart_of_accounts: balance_sheet.chart_of_accounts
      company_code: balance_sheet.company_text
      ledger_name: universal_ledgers_md.ledger_id_name
    row: 0
    col: 0
    width: 24
    height: 3
