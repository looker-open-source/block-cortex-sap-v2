#########################################################{
# PURPOSE
# SQL-based derived table that aggregates billing quantity to the Client MANDT,
# Sales Document and Sales Document Item level
#
# REFERENCED BY
# Explore sales_orders_v2
# View across_sales_and_billing_summary_xvw
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - Fields are shown in sales_orders_v2 explore as part of Sales Orders or Sales Orders Items depending on level of detail
#   - Additional fields that require Sales Orders are found in field-only view across_sales_and_billing_summary_xvw
#
#########################################################}

view: sales_order_item_billing_summary_sdt {
  label: "Billing Summary"
  fields_hidden_by_default: yes
  derived_table: {
    sql:  SELECT
             so.Client_MANDT,
             so.SalesDocument_VBELN,
             so.Item_POSNR,
             so.CumulativeOrderQuantity_KWMENG,
             b.billing_quantity,
             so.CumulativeOrderQuantity_KWMENG = coalesce(b.billing_quantity,0) AS is_item_billed_in_full,
             MIN(so.CumulativeOrderQuantity_KWMENG =  COALESCE(b.billing_quantity,0)) over (PARTITION by so.Client_MANDT, so.SalesDocument_VBELN) AS is_order_billed_in_full
          FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrders_V2` so
          LEFT JOIN
          (SELECT
              Client_MANDT
             ,SalesDocument_AUBEL
             ,SalesDocumentItem_AUPOS
             ,SUM(ActualBilledQuantity_FKIMG) AS billing_quantity
          FROM `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Billing`
          WHERE Client_MANDT = '@{CLIENT_ID}'
          AND BillingType_FKART in ('F1','F2')
          AND BillingDocumentIsCancelled_FKSTO is NULL
          GROUP BY
              Client_MANDT
             ,SalesDocument_AUBEL
             ,SalesDocumentItem_AUPOS
            ) b
          ON so.Client_MANDT = b.Client_MANDT
          AND so.SalesDocument_VBELN = b.SalesDocument_AUBEL
          AND so.Item_POSNR = b.SalesDocumentItem_AUPOS ;;
  }

  dimension: key {
    primary_key: yes
    sql: CONCAT(${client_mandt},${sales_document_vbeln},${item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: sales_document_vbeln {
    type: string
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: item_posnr {
    type: string
    sql: ${TABLE}.Item_POSNR ;;
  }

  dimension: cumulative_order_quantity_kwmeng {
    type: number
    sql: ${TABLE}.CumulativeOrderQuantity_KWMENG ;;
  }

  dimension: billing_quantity {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Quantities{%- endif -%}"
    label: "Billed Quantity"
    description: "Quantity billed"
    sql: ${TABLE}.billing_quantity ;;
  }

  dimension: is_item_billed_in_full {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    sql: ${TABLE}.is_item_billed_in_full ;;
  }

  dimension: is_order_billed_in_full {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders{%- endif -%}"
    group_label: "Order Status"
    sql: ${TABLE}.is_order_billed_in_full ;;
  }

  measure: total_billed_quantity {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    sql: ${billing_quantity} ;;
  }


}
