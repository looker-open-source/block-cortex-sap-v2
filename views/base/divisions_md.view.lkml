view: divisions_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.DivisionsMD` ;;

  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: division_name_vtext {
    type: string
    description: "Name"
    sql: ${TABLE}.DivisionName_VTEXT ;;
  }
  dimension: division_spart {
    type: string
    description: "Division"
    sql: ${TABLE}.Division_SPART ;;
  }
  dimension: language_key_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.LanguageKey_SPRAS ;;
  }
  measure: count {
    type: count
  }
}