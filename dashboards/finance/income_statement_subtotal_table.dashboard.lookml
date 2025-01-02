#########################################################{
# Income Statement financial report using Table visualization with Subtotals
#
# EXTENDS filters, dashboard_navigation, summary, income_statement
#         and footnote from income_statement_template
#
# customizations:
#   - set dashboard title and description
#   - filter comparison_type: set options to yoy and prior with yoy as default
#   - viz dashboard_navigation: set filters:
#       parameters_navigation_focus_page to '1'
#       parameter_navigation_dashboard_style to 'subtotal'
#   - viz income_statement: define parameters for looker_grid visualization type
#########################################################}

- dashboard: income_statement_subtotal_table
  title: Financial Income Statement
  description: "Shows a company's financial performance over a specific period (e.g., a month, quarter, or year) compared to either preceding timeframe or same timeframe last year. This report summarizes Revenues, Expenses and/or Net Income (Loss) at specified hierarchy level."
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
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_dashboard_style: 'subtotal'
#####################################################################################################
  - name: income_statement
    # fields, pivots, sorts and listens defined in income_statement_template
    # parameters below are specific to looker_grid table
    type: looker_grid
    subtotals: [profit_and_loss_hierarchy_selection_sdt.hier1_node_text,
                profit_and_loss_hierarchy_selection_sdt.hier2_node_text
                ]
    total: true
    size_to_fit: true
    table_theme: white
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    minimum_column_width: 95
    series_labels:
      profit_and_loss_hierarchy_selection_sdt.hier1_node_text: " "
      profit_and_loss_hierarchy_selection_sdt.hier2_node_text: " "
      profit_and_loss_hierarchy_selection_sdt.hier3_node_text: " "
      profit_and_loss_03_selected_fiscal_periods_sdt.alignment_group_name_with_partial_indicator: " "
    series_collapsed:
      profit_and_loss_hierarchy_selection_sdt.hier2_node_text: false
