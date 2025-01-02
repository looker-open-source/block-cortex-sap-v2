#########################################################{
# Income Statement financial report using Report Table
# visualization (available for free on Looker Marketplace)
#
# EXTENDS filters, dashboard_navigation, summary,
#         and income_statement from income_statement_template
#
# customizations:
#   - set dashboard title and description
#   - filter comparison_type: options set to yoy and prior with yoy as default
#   - viz dashboard_navigation: set filters:
#         parameter_navigation_focus_page to '1'
#         parameter_navigation_dashboard_style to 'mktplace'
#   - viz income_statement:
#         set type to marketplace_viz_report_table::report_table-marketplace
#         define parameters for report_table-marketplace visualization type
#########################################################}

- dashboard: income_statement_mktplace_report_table
  title: Financial Income Statement
  description: "Using the Report (Table) visualization available from Looker Marketplace, this report shows a company's financial performance over a specific period (e.g., a month, quarter, or year) compared to either preceding timeframe or same timeframe last year. This report summarizes Revenues, Expenses and/or Net Income (Loss) at specified hierarchy level."
  extends: income_statement_template
#####################################################################################################
  filters:
  - name: comparison_type
    ui_config:
      options:
        - yoy
        - prior
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_focus_page: '1'
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_dashboard_style: 'mktplace'
#####################################################################################################
  - name: income_statement
  # fields, pivots, sorts and listens defined in income_statement_template
  # parameters below are specific to marketplace report table
    type: marketplace_viz_report_table::report_table-marketplace
    theme: contemporary
    layout: auto
    minWidthForIndexColumns: false
    headerFontSize: 12
    bodyFontSize: 12
    showTooltip: true
    showHighlight: true
    columnOrder: {}
    rowSubtotals: true
    colSubtotals: false
    spanRows: true
    spanCols: true
    calculateOthers: true
    sortColumnsBy: pivots
    useViewName: false
    useHeadings: false
    useShortName: false
    useUnit: false
    groupVarianceColumns: false
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|profit_and_loss_hierarchy_selection_sdt.hier1_node_text: " "
    label|profit_and_loss_hierarchy_selection_sdt.hier2_node_text: " "
    label|profit_and_loss_hierarchy_selection_sdt.hier3_node_text: " "
    subtotalDepth: '1'
    style|profit_and_loss_03_selected_fiscal_periods_sdt.reporting_amount: black_red
    label|profit_and_loss_03_selected_fiscal_periods_sdt.comparison_amount:
    style|profit_and_loss_03_selected_fiscal_periods_sdt.comparison_amount: black_red
    style|profit_and_loss_03_selected_fiscal_periods_sdt.difference_value: black_red
    style|profit_and_loss_03_selected_fiscal_periods_sdt.difference_percent: black_red
