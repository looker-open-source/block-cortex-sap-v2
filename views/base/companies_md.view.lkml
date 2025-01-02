view: companies_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CompaniesMD` ;;

  dimension: chart_of_accounts_ktopl {
    type: string
    description: "Chart of Accounts"
    sql: ${TABLE}.ChartOfAccounts_KTOPL ;;
  }
  dimension: city_name_ort01 {
    type: string
    description: "City"
    sql: ${TABLE}.CityName_ORT01 ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: company_code_bukrs {
    type: string
    description: "Company Code"
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }
  dimension: company_rcomp {
    type: string
    description: "Company"
    sql: ${TABLE}.Company_RCOMP ;;
  }
  dimension: company_text_butxt {
    type: string
    description: "Company Name"
    sql: ${TABLE}.CompanyText_BUTXT ;;
  }
  dimension: country_chartof_accounts_ktop2 {
    type: string
    description: "Country Chart/Accts"
    sql: ${TABLE}.CountryChartofAccounts_KTOP2 ;;
  }
  dimension: country_land1 {
    type: string
    description: "Country Key"
    sql: ${TABLE}.Country_LAND1 ;;
  }
  dimension: credit_control_area_kkber {
    type: string
    description: "Credit control area"
    sql: ${TABLE}.CreditControlArea_KKBER ;;
  }
  dimension: currency_code_waers {
    type: string
    description: "Currency"
    sql: ${TABLE}.CurrencyCode_WAERS ;;
  }
  dimension: fiscalyear_variant_periv {
    type: string
    description: "Fiscal Year Variant"
    sql: ${TABLE}.FiscalyearVariant_PERIV ;;
  }
  dimension: funds_management_fikrs {
    type: string
    description: "FM Area"
    sql: ${TABLE}.FundsManagement_FIKRS ;;
  }
  dimension: language_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.Language_SPRAS ;;
  }
  measure: count {
    type: count
  }
}
