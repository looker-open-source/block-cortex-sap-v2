#########################################################{
# PURPOSE
# SQL-based persistent derived table (PDT) that finds the distinct list of
# ExchangeRateType_KURST, ToCurrency_TCURR values found in CurrencyConversion.
# Used to provide suggestions parameter_target_currency and
# parameter_exchange_rate_type.
#
# REFERENCED BY
# Explore otc_target_currencies_pdt
#
# NOTES
#   - recommend setting a data trigger based on how often the TCURR value is expected to change
#   - datagroup trigger set initially as Monthly on First day of month. To use a different trigger:
#     1. define datagroup in datagroups.lkml file found in components folder
#     2. replace datagroup_trigger: value below with name of datagroup
#########################################################}


view: otc_target_currencies_pdt {
    derived_table: {
      datagroup_trigger: monthly_on_day_1

      sql: SELECT DISTINCT ExchangeRateType_KURST, ToCurrency_TCURR
           FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CurrencyConversion` ;;
    }

  dimension: exchange_rate_type_kurst {
    type: string
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }

  dimension: to_currency_tcurr {
    type: string
    sql: ${TABLE}.ToCurrency_TCURR ;;
  }

  }
