#########################################################{
# PURPOSE
# Provides consistent definitions and labels for parameters used in OTC-related Explores.
#   parameter_target_currency
#   parameter_language
#   parameter_category_set_name (hidden)
#
# REFERENCED BY
#   Explores:
#     sales_orders
#     sales_orders_daily_agg
#     sales_invoices
#     sales_invoices_daily_agg
#     sales_payments
#     sales_payments_daily_agg
#     sales_applied_receivables
#     sales_applied_receivables_daily_agg
#
# NOTE
#   - parameter_category_set_name is hidden and does not
#     appear in any Explores. Instead category_set_name value is filtered to
#     match user attribute 'cortex_oracle_ebs_category_set_name'
#
#     To enable users to switch values using this parameter:
#       1. Unhide the parameter.
#       2. Set the default value of parameter to the desired option.
#       3. Replace references to the user attribute value with the parameter value.
#           e.g., replace _user_attributes['cortex_oracle_ebs_category_set_name'] with
#           otc_common_parameters_xvw.parameter_category_set_name._parameter_value
#
#########################################################}

view: otc_common_parameters_xvw {
  label: "@{label_view_for_filters}"

  parameter: parameter_target_currency {
    hidden: no
    type: string
    label: "Target Currency"
    description: "When converting amounts, choose the desired currency"
    suggest_explore: otc_target_currencies_pdt
    suggest_dimension: otc_target_currencies_pdt.to_currency_tcurr
    default_value: "USD"
  }

  parameter: parameter_exchange_rate_type {
    hidden: no
    label: "Target Currency Exchange Rate Type"
    suggest_explore: otc_target_currencies_pdt
    suggest_dimension: otc_target_currencies_pdt.exchange_rate_type_kurst
    default_value: "M"
  }

  # filter: filter_date {
  #   hidden: no
  #   view_label: "@{label_view_for_filters}"
  #   type: date
  #   # for tables partitioned by date capture start and end dates and apply as a templated filter
  #   # in the Explore's sql_always_where statement or SQL-based derived table
  # }


}
