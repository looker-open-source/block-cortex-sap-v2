#########################################################{
# Balance Sheet financial report using Subtotals
# extends filters and title summary from balance_sheet_template
# customizations:
#   - Comparison Type filter options set to only yoy, prior or custom (none removed as option)
#   - Balance Sheet table based on looker_grid visualization type using derived amounts for
#     reporting and comparison periods including derived differences (amount and %)
#########################################################}

- dashboard: balance_sheet_subtotal_table
  title: Financial Balance Sheet
  description: Using standard table with subtotals, reports Fiscal Period Cumulative
    Amount in Target Currency for the selected hierarchy, chart
    of accounts, company, fiscal period and comparison period (if any).
  extends: balance_sheet_template
#####################################################################################################
  filters:
  - name: comparison_type
    ui_config:
      # remove none option to avoid display issues with comparison and variance columns
      options:
        - yoy
        - prior
        - custom
#####################################################################################################
  elements:
  - name: dashboard_navigation
    explore: balance_sheet
    type: single_value
    fields: [balance_sheet_dashboard_navigation_ext.navigation_links]
    filters:
      balance_sheet_dashboard_navigation_ext.parameter_navigation_focus_page: '1'
      balance_sheet_dashboard_navigation_ext.parameter_navigation_style: 'plain'
    show_single_value_title: false
    show_comparison: false
    listen:
      fiscal_period: balance_sheet_dashboard_navigation_ext.filter1
      target_currency: balance_sheet_dashboard_navigation_ext.filter2
      hierarchy: balance_sheet_dashboard_navigation_ext.filter3
      chart_of_accounts: balance_sheet_dashboard_navigation_ext.filter4
      company_code: balance_sheet_dashboard_navigation_ext.filter5
      ledger_name: balance_sheet_dashboard_navigation_ext.filter6
      top_hierarchy_level: balance_sheet_dashboard_navigation_ext.filter7
    row: 11
    col: 0
    width: 24
    height: 1
#####################################################################################################
  - name: balance_sheet
    title: Balance Sheet
    explore: balance_sheet
    type: looker_grid
    fields: [balance_sheet_hierarchy_selection_sdt.hier1_node_text,
             balance_sheet_hierarchy_selection_sdt.hier2_node_text,
             balance_sheet_hierarchy_selection_sdt.hier3_node_text,
             balance_sheet_fiscal_periods_selected_sdt.reporting_period_amount_in_target_currency,
             balance_sheet_fiscal_periods_selected_sdt.comparison_period_amount_in_target_currency,
             balance_sheet_fiscal_periods_selected_sdt.difference_value,
             balance_sheet_fiscal_periods_selected_sdt.difference_percent
             ]
    sorts: [balance_sheet_hierarchy_selection_sdt.hier1_node_text,
            balance_sheet_hierarchy_selection_sdt.hier2_node_text,
            balance_sheet_hierarchy_selection_sdt.hier3_node_text]
    subtotals: [balance_sheet_hierarchy_selection_sdt.hier1_node_text,
                balance_sheet_hierarchy_selection_sdt.hier2_node_text]
    title_hidden: true
    total: true
    truncate_text: false
    truncate_header: false
    size_to_fit: false
    table_theme: white
    header_text_alignment: right
    header_font_size: '12'
    rows_font_size: '12'
    minimum_column_width: 95
    series_labels:
      balance_sheet_hierarchy_selection_sdt.hier1_node_text: ' '
      balance_sheet_hierarchy_selection_sdt.hier2_node_text: ' '
      balance_sheet_hierarchy_selection_sdt.hier3_node_text: ' '
    series_collapsed:
      balance_sheet_hierarchy_selection_sdt.hier1_node_text: false
      balance_sheet_hierarchy_selection_sdt.hier2_node_text: false
    listen:
      fiscal_period: balance_sheet.parameter_fiscal_period
      comparison_type: balance_sheet.parameter_comparison_type
      custom_comparison_period: balance_sheet.parameter_custom_comparison_period
      target_currency: balance_sheet.target_currency_tcurr
      hierarchy: balance_sheet.hierarchy_name
      chart_of_accounts: balance_sheet.chart_of_accounts
      company_code: balance_sheet.company_text
      ledger_name: universal_ledgers_md.ledger_id_name
      top_hierarchy_level: balance_sheet_hierarchy_selection_sdt.parameter_pick_start_level
    row: 3
    col: 0
    width: 24
    height: 8