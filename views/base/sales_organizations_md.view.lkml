view: sales_organizations_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrganizationsMD` ;;

  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: co_co_currency_waers {
    type: string
    description: "Currency"
    sql: ${TABLE}.CoCoCurrency_WAERS ;;
  }
  dimension: company_butxt {
    type: string
    description: "Company Name"
    sql: ${TABLE}.Company_BUTXT ;;
  }
  dimension: company_code_bukrs {
    type: string
    description: "Company Code"
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }
  dimension: country_land1 {
    type: string
    description: "Country Key"
    sql: ${TABLE}.Country_LAND1 ;;
  }
  dimension: fiscal_yr_variant_periv {
    type: string
    description: "Fiscal Year Variant"
    sql: ${TABLE}.FiscalYrVariant_PERIV ;;
  }
  dimension: language_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.Language_SPRAS ;;
  }
  dimension: sales_org_currency_waers {
    type: string
    description: "Currency"
    sql: ${TABLE}.SalesOrgCurrency_WAERS ;;
  }
  dimension: sales_org_customer_kunnr {
    type: string
    description: "Cust.inter-co.bill."
    sql: ${TABLE}.SalesOrgCustomer_KUNNR ;;
  }
  dimension: sales_org_name_vtext {
    type: string
    description: "Name"
    sql: ${TABLE}.SalesOrgName_VTEXT ;;
  }
  dimension: sales_org_vkorg {
    type: string
    description: "Sales Organization"
    sql: ${TABLE}.SalesOrg_VKORG ;;
  }
  measure: count {
    type: count
  }
}