view: one_touch_order {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.OneTouchOrder` ;;

  dimension: actual_billed_quantity_fkimg {
    type: number
    description: "Billed Quantity"
    sql: ${TABLE}.ActualBilledQuantity_FKIMG ;;
  }
  dimension: one_touch_order_count {
    type: number
    description: "One Touch Order Count"
    sql: ${TABLE}.OneTouchOrderCount ;;
  }
  dimension: vbapclient_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.VBAPClient_MANDT ;;
  }
  dimension: vbapsales_document_item_posnr {
    type: string
    description: "Item"
    sql: ${TABLE}.VBAPSalesDocument_Item_POSNR ;;
  }
  dimension: vbapsales_document_vbeln {
    type: string
    description: "Billing Document"
    sql: ${TABLE}.VBAPSalesDocument_VBELN ;;
  }
  dimension: vbaptotal_order_kwmeng {
    type: number
    description: "Order Quantity"
    sql: ${TABLE}.VBAPTotalOrder_KWMENG ;;
  }
  measure: count {
    type: count
  }
}