#########################################################{
# Income Statement template which must be EXTENDED into another dashboard
#
# defines the following elements which can be shared across Income Statement-related dashboards:
#  - Visualization properties and positions:
#       summary which appears at top of Income Statement dashboards
#       income_statement which is main table displayed
#       footnote which populates if one of the selected fiscal years or quarters and its
#.         corresponding comparison timeframe is incomplete else chart remains empty/blank
#       dashboard_navigation chart with provides two html links for With Comparisons or Without Comparisons
#
#  - filters including default values:
#       hierarchy
#       display_timeframe
#       fiscal_timeframe
#       combine_timeframes
#       comparison_type
#       target_currency
#       company_code
#       ledger_name
#       top_hierarchy_level
#
# The Elements and their properties can be EXTENDED into other dashboards and modified further as necessary
#########################################################}

- dashboard: income_statement_template
  title: Income Statement Template
  description: "Common filters and tiles used by Income Statement dashboards"
  layout: newspaper
  preferred_viewer: dashboards-next
  filters_location_top: false
  extension: required
#####################################################################################################
  filters:
  - name: hierarchy
    title: Hierarchy
    type: field_filter
    default_value: FPA1
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.glhierarchy

  - name: display_timeframe
    title: Display Timeframe
    type: field_filter
    default_value: qtr
    allow_multiple_values: false
    required: false
    ui_config:
      type: button_toggles
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.parameter_display_time_dimension

  - name: fiscal_timeframe
    title: Fiscal Timeframe
    type: field_filter
    # if using demo data default is 2023.Q4 else find current calendar quarter
    default_value: "{% if _user_attributes['cortex_sap_use_test_data']=='Yes'%}{% assign qtr = '2023.Q4'%}{%else%}{% assign q = 'now' | date: '%m' | times: 1.0 | divided_by: 3 | ceil %}{% assign qtr = 'now' | date: '%Y' | append: '.Q' | append: q %}{%endif%}{{qtr}}"
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    explore: profit_and_loss
    field: profit_and_loss.filter_fiscal_timeframe
    listens_to_filters: [display_timeframe]

  - name: combine_timeframes
    title: Combine Selected Timeframes?
    type: field_filter
    default_value: "Yes"
    allow_multiple_values: false
    required: false
    ui_config:
      type: button_toggles
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.parameter_aggregate

  - name: comparison_type
    title: Comparison Type
    type: field_filter
    default_value: yoy
    allow_multiple_values: false
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.parameter_compare_to

  - name: target_currency
    title: Target Currency
    type: field_filter
    default_value: "{{ _user_attributes['cortex_sap_default_target_currency'] }}"
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.target_currency_tcurr

  - name: company_code
    title: Company Code
    type: field_filter
    default_value: "%CENTRAL%"
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: inline
    explore: profit_and_loss
    field: profit_and_loss.company_text

  - name: ledger_name
    title: Ledger Name
    type: field_filter
    default_value: '%0L%'
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    explore: profit_and_loss
    field: universal_ledgers_md.ledger_id_name
    listens_to_filters: [hierarchy]

  - name: top_hierarchy_level
    title: Top Hierarchy Level
    type: field_filter
    default_value: '2'
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    explore: profit_and_loss
    field: profit_and_loss_hierarchy_selection_sdt.parameter_pick_start_level
#####################################################################################################
  elements:
  - name: dashboard_navigation
    explore: profit_and_loss
    type: single_value
    fields: [profit_and_loss_dashboard_navigation_ext.navigation_links]
    filters:
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_focus_page: '1'
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_style: 'plain'
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_dashboard_style: 'subtotal'
    show_single_value_title: false
    show_comparison: false
    listen:
      hierarchy: profit_and_loss_dashboard_navigation_ext.filter1
      display_timeframe: profit_and_loss_dashboard_navigation_ext.filter2
      fiscal_timeframe: profit_and_loss_dashboard_navigation_ext.filter3
      combine_timeframes: profit_and_loss_dashboard_navigation_ext.filter4
      target_currency: profit_and_loss_dashboard_navigation_ext.filter5
      company_code: profit_and_loss_dashboard_navigation_ext.filter6
      ledger_name: profit_and_loss_dashboard_navigation_ext.filter7
      top_hierarchy_level: profit_and_loss_dashboard_navigation_ext.filter8
    row: 11
    col: 0
    width: 24
    height: 1
#####################################################################################################
  - name: summary
    title: Income Statement Summary
    explore: profit_and_loss
    type: single_value
    fields: [profit_and_loss_03_selected_fiscal_periods_sdt.title_income_statement]
    filters:
      profit_and_loss.gllevel_number: '2'
      profit_and_loss_03_selected_fiscal_periods_sdt.fiscal_reporting_group: Reporting
    show_single_value_title: false
    listen:
      target_currency: profit_and_loss.target_currency_tcurr
      fiscal_timeframe: profit_and_loss.filter_fiscal_timeframe
      display_timeframe: profit_and_loss.parameter_display_time_dimension
      comparison_type: profit_and_loss.parameter_compare_to
      ledger_name: universal_ledgers_md.ledger_id_name
      company_code: profit_and_loss.company_text
      hierarchy: profit_and_loss.glhierarchy
    row: 2
    col: 0
    width: 24
    height: 3
#####################################################################################################
  - name: income_statement
    title: Income Statement
    explore: profit_and_loss
    # type: looker_grid
    fields: [profit_and_loss_hierarchy_selection_sdt.hier1_node_text,
             profit_and_loss_hierarchy_selection_sdt.hier2_node_text,
             profit_and_loss_hierarchy_selection_sdt.hier3_node_text,
             profit_and_loss_03_selected_fiscal_periods_sdt.reporting_amount,
             profit_and_loss_03_selected_fiscal_periods_sdt.comparison_amount,
             profit_and_loss_03_selected_fiscal_periods_sdt.difference_value,
             profit_and_loss_03_selected_fiscal_periods_sdt.difference_percent,
             profit_and_loss_03_selected_fiscal_periods_sdt.alignment_group_name_with_partial_indicator
            ]
    pivots: [profit_and_loss_03_selected_fiscal_periods_sdt.alignment_group_name_with_partial_indicator]
    sorts: [profit_and_loss_03_selected_fiscal_periods_sdt.alignment_group_name_with_partial_indicator,
           profit_and_loss_hierarchy_selection_sdt.hier1_node_text,
           profit_and_loss_hierarchy_selection_sdt.hier2_node_text,
           profit_and_loss_hierarchy_selection_sdt.hier3_node_text
          ]
    title_hidden: true
    listen:
      hierarchy: profit_and_loss.glhierarchy
      display_timeframe: profit_and_loss.parameter_display_time_dimension
      fiscal_timeframe: profit_and_loss.filter_fiscal_timeframe
      combine_timeframes: profit_and_loss.parameter_aggregate
      comparison_type: profit_and_loss.parameter_compare_to
      target_currency: profit_and_loss.target_currency_tcurr
      ledger_name: universal_ledgers_md.ledger_id_name
      company_code: profit_and_loss.company_text
      top_hierarchy_level: profit_and_loss_hierarchy_selection_sdt.parameter_pick_start_level
    row: 3
    col: 0
    width: 24
    height: 8
#####################################################################################################
  - name: footnote
    title: footnote
    explore: profit_and_loss
    type: single_value
    fields: [profit_and_loss_03_selected_fiscal_periods_sdt.footnote_partial_timeframe]
    show_single_value_title: false
    listen:
      target_currency: profit_and_loss.target_currency_tcurr
      fiscal_timeframe: profit_and_loss.filter_fiscal_timeframe
      display_timeframe: profit_and_loss.parameter_display_time_dimension
      comparison_type: profit_and_loss.parameter_compare_to
      ledger_name: universal_ledgers_md.ledger_id_name
      company_code: profit_and_loss.company_text
      hierarchy: profit_and_loss.glhierarchy
      combine_timeframes: profit_and_loss.parameter_aggregate
    row: 10
    col: 0
    width: 24
    height: 1
