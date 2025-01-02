#########################################################{
# PURPOSE
# SQL-based Derived Table (SDT) which selects a subset of CurrencyConversion
# where ToCurrency_TCURR matches the value in parameter_target_currency
# and ExchangeRateType_KURST matches the value in parameter_exchange_rate_type
#
# Must be joined to an Explore that includes the view:
#   otc_common_parameters_xvw
#
# SOURCE
#   `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CurrencyConversion`
#
# REFERENCED BY
#   Explores & Views:
#     sales_orders_v2
#     billing
#
#########################################################}

view: currency_conversion_sdt {
  label: "Currency Conversion"
  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT  Client_MANDT
                ,ConvDate
                ,StartDate
                ,EndDate
                ,ExchangeRateType_KURST
                ,ExchangeRate_UKURS
                ,FromCurrency_FCURR
                ,ToCurrency_TCURR
      FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CurrencyConversion`
      WHERE Client_MANDT = '@{CLIENT_ID}'
      AND ExchangeRateType_KURST = {% parameter otc_common_parameters_xvw.parameter_exchange_rate_type %}
      AND ToCurrency_TCURR = {% parameter otc_common_parameters_xvw.parameter_target_currency %}
    ;;
  }

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${exchange_rate_type_kurst},${from_currency_fcurr}, ${to_currency_tcurr},${conv_date} ;;
  }

  dimension: client_mandt {
    label: "Client MANDT"
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: conv_date {
    label: "Conversion Date"
    type: date
    sql: ${TABLE}.ConvDate ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.StartDate ;;
  }

  dimension: end_date {
    type: date
    sql: ${TABLE}.EndDate ;;
  }

  dimension: exchange_rate_type_kurst {
    hidden: no
    label: "Exchange Rate Type KURST"
    type: string
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }

  dimension: from_currency_fcurr {
    hidden: no
    label: "Local Currency FCURR"
    type: string
    sql: ${TABLE}.FromCurrency_FCURR ;;
  }

  dimension: to_currency_tcurr {
    hidden: no
    label: "Target Currency TCURR"
    type: string
    sql: ${TABLE}.ToCurrency_TCURR ;;
  }

  dimension: exchange_rate_ukurs {
    hidden: no
    label: "Exchange Rate UKURS"
    type: number
    sql: ${TABLE}.ExchangeRate_UKURS ;;
  }


}
