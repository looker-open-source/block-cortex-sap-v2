view: thjennifer1_cortex_ecc_reporting_currency_conversion {
  sql_table_name: `thjennifer1.CORTEX_ECC_REPORTING.CurrencyConversion` ;;

  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension_group: conv {
    type: time
    description: "Conv Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ConvDate ;;
  }
  dimension_group: end {
    type: time
    description: "End Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EndDate ;;
  }
  dimension: exchange_rate_type_kurst {
    type: string
    description: "Exchange rate type"
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }
  dimension: exchange_rate_ukurs {
    type: number
    description: "Exchange Rate"
    sql: ${TABLE}.ExchangeRate_UKURS ;;
  }
  dimension: from_currency_fcurr {
    type: string
    description: "From currency"
    sql: ${TABLE}.FromCurrency_FCURR ;;
  }
  dimension_group: start {
    type: time
    description: "Start Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.StartDate ;;
  }
  dimension: to_currency_tcurr {
    type: string
    description: "To-currency"
    sql: ${TABLE}.ToCurrency_TCURR ;;
  }
  measure: count {
    type: count
  }
}
