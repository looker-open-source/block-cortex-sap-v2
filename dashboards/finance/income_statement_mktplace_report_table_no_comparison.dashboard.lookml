#########################################################{
# Income Statement financial report using Report Table
# visualization (available for free on Looker Marketplace)
# and without any comparison to prior periods
#
# EXTENDS filters, dashboard_navigation, summary,
#         and income_statement from income_statement_template
# EXTENDS settings for marketplace report table visualization from
#         income_statement_mktplace_report_table
#
# customizations:
#   - filter comparion_type: set options and default to None
#   - viz dashboard_navigation: set filter parameter_navigation_focus_page to '2'
#   - viz income_statement: removed comparison-related fields from fields: property
#########################################################}

- dashboard: income_statement_mktplace_report_table_no_comparison
  extends: [income_statement_template, income_statement_mktplace_report_table]
#####################################################################################################
  filters:
  - name: comparison_type
    default_value: "none"
    ui_config:
      options:
       - none
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      profit_and_loss_dashboard_navigation_ext.parameter_navigation_focus_page: '2'
#####################################################################################################
  - name: income_statement
    # restate fields parameter to only include reporting amount
    fields: [profit_and_loss_hierarchy_selection_sdt.hier1_node_text,
            profit_and_loss_hierarchy_selection_sdt.hier2_node_text,
            profit_and_loss_hierarchy_selection_sdt.hier3_node_text,
            profit_and_loss_03_selected_fiscal_periods_sdt.alignment_group_name_with_partial_indicator,
            profit_and_loss_03_selected_fiscal_periods_sdt.reporting_amount]
