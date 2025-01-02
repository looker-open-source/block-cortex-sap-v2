#########################################################{
# Balance Sheet financial report using Subtotals but without Comparison to year ago, prior or custom fiscal periods
# extends filters and title summary from balance_sheet_template
# also extends Balance Sheet Table visualization from balance_sheet_subtotal3_table
# customizations:
#   - Comparison Type filter options set to none
#   - Custom Comparison Period default value and options set to none
#   - Removed comparison-related fields from Balance Sheet table
#########################################################}

- dashboard: balance_sheet_subtotal_table_no_comparison
  title: Financial Balance Sheet
  description: "Using standard table with subtotals, reports Fiscal Period Cumulative Amount in Target Currency for the selected hierarchy, chart of accounts, company, and fiscal period."
  extends: [balance_sheet_template, balance_sheet_subtotal_table]
#####################################################################################################
  filters:
  - name: comparison_type
    default_value: none
    ui_config:
      # remove all options for comparisons
      options:
        - none

  - name: custom_comparison_period
    default_value: 'None'
    ui_config:
      options:
        - None
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      balance_sheet_dashboard_navigation_ext.parameter_navigation_focus_page: '2'
#####################################################################################################
  - name: balance_sheet
    explore: balance_sheet
    type: looker_grid
    fields: [balance_sheet_hierarchy_selection_sdt.hier1_node_text,
             balance_sheet_hierarchy_selection_sdt.hier2_node_text,
             balance_sheet_hierarchy_selection_sdt.hier3_node_text,
             balance_sheet_fiscal_periods_selected_sdt.reporting_period_amount_in_target_currency]
    size_to_fit: false
