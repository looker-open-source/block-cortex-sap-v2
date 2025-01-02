#########################################################{
# Balance Sheet financial report using Report Table visualization (available for free on Looker Marketplace)
# extends filters and title summary from balance_sheet_template
# customizations:
#   - Balance Sheet table based on marketplace_viz_report_table::report_table-marketplace
#########################################################}

- dashboard: balance_sheet_mktplace_report_table
  title: Financial Balance Sheet
  description: "Reports Fiscal Period Cumulative Amount in Target Currency for Levels 3 and 4 of the selected hierarchy, chart of accounts, company, fiscal period and comparison period (if any). Requires Report Table visualization to be downloaded from Looker Marketplace."
  extends: balance_sheet_template
#####################################################################################################
  elements:
  - name: balance_sheet
    title: Balance Sheet
    explore: balance_sheet
    type: marketplace_viz_report_table::report_table-marketplace
    fields: [balance_sheet.fiscal_year_period,
             balance_sheet_hierarchy_selection_sdt.hier1_node_text,
             balance_sheet_hierarchy_selection_sdt.hier2_node_text,
             balance_sheet_hierarchy_selection_sdt.hier3_node_text,
             balance_sheet.total_cumulative_amount_in_target_currency
             ]
    sorts: [balance_sheet.fiscal_year_period desc,
            balance_sheet_hierarchy_selection_sdt.hier1_node_text,
            balance_sheet_hierarchy_selection_sdt.hier2_node_text,
            balance_sheet_hierarchy_selection_sdt.hier3_node_text]
    pivots: [balance_sheet.fiscal_year_period]
    filters:
      balance_sheet_fiscal_periods_selected_sdt.fiscal_period_group: "-NULL"
    total: true
    series_labels: {}
    show_view_names: false
    theme: contemporary
    customTheme: ''
    layout: auto
    minWidthForIndexColumns: true
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
    groupVarianceColumns: true
    genericLabelForSubtotals: false
    indexColumn: false
    transposeTable: false
    label|balance_sheet_hierarchy_selection_sdt.hier1_node_text: " "
    label|balance_sheet_hierarchy_selection_sdt.hier2_node_text: " "
    label|balance_sheet_hierarchy_selection_sdt.hier3_node_text: " "
    subtotalDepth: '1'
    label|balance_sheet.total_cumulative_amount_in_target_currency: Amount
    style|balance_sheet.total_cumulative_amount_in_target_currency: black_red
    reportIn|balance_sheet.total_cumulative_amount_in_target_currency: '1'
    comparison|balance_sheet.total_cumulative_amount_in_target_currency: balance_sheet.fiscal_year_period
    switch|balance_sheet.total_cumulative_amount_in_target_currency: false
    var_num|balance_sheet.total_cumulative_amount_in_target_currency: true
    var_pct|balance_sheet.total_cumulative_amount_in_target_currency: true
    title_hidden: true
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
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
    row: 2
    col: 0
    width: 24
    height: 13