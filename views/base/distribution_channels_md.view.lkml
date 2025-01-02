view: distribution_channels_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.DistributionChannelsMD` ;;

  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: distribution_channel_name_vtext {
    type: string
    description: "Name"
    sql: ${TABLE}.DistributionChannelName_VTEXT ;;
  }
  dimension: distribution_channel_vtweg {
    type: string
    description: "Distribution Channel"
    sql: ${TABLE}.DistributionChannel_VTWEG ;;
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