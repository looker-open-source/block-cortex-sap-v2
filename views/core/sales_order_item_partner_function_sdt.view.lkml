#########################################################{
# PURPOSE
# SQL-based derived table that aggregates a list of sold to, bill to and ship to customers
# for an order and line item (because an order item can be associated with multiple customers)
#
# REFERENCED BY
# None
#
#########################################################}

view: sales_order_item_partner_function_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql:
      SELECT
        *
      FROM (
        SELECT
          t.client_MANDT,
          t.SalesDocument_VBELN,
          t.Item_POSNR,
          CASE t.PartnerFunction_PARVW
            WHEN 'AG' THEN 'sold_to'
            WHEN 'RE' THEN 'bill_to'
            WHEN 'WE' THEN 'ship_to'
        END
          AS PartnerFunction_Label,
          ARRAY_TO_STRING(array_customer_name, ", ") AS customer_names
        FROM (
          SELECT
            pf.client_MANDT,
            pf.SalesDocument_VBELN,
            pf.Item_POSNR,
            pf.PartnerFunction_PARVW,
            ARRAY_AGG(DISTINCT pf.Customer_KUNNR) AS array_customer_kunnr,
            ARRAY_AGG(DISTINCT COALESCE(c.name1_name1,pf.Customer_KUNNR)) AS array_customer_name
          FROM
            `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrderPartnerFunction` pf
          JOIN
            `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CustomersMD` c
          ON
            pf.Client_MANDT = c.client_MANDT
            AND pf.Customer_KUNNR = c.CustomerNumber_KUNNR
          GROUP BY
            pf.client_MANDT,
            pf.SalesDocument_VBELN,
            pf.Item_POSNR,
            PartnerFunction_PARVW ) t ) c PIVOT(MAX(customer_names) customer_names FOR PartnerFunction_Label IN ('sold_to',
            'bill_to',
            'ship_to'))
      ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    sql: concat(${client_mandt},${sales_document_vbeln},${item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.client_MANDT ;;
  }

  dimension: sales_document_vbeln {
    type: string
    sql: ${TABLE}.SalesDocument_VBELN ;;
  }

  dimension: item_posnr {
    type: string
    sql: ${TABLE}.Item_POSNR ;;
  }

  dimension: customer_names_sold_to {
    hidden: no
    type: string
    label: "Sold To Customer Names"
    sql: COALESCE(${TABLE}.customer_names_sold_to,${sales_order_partner_function_sdt.customer_names_sold_to}) ;;
  }

  dimension: customer_names_bill_to {
    hidden: no
    type: string
    label: "Bill To Customer Names"
    sql: COALESCE(${TABLE}.customer_names_bill_to,${sales_order_partner_function_sdt.customer_names_bill_to}) ;;
  }

  dimension: customer_names_ship_to {
    hidden: no
    type: string
    label: "Ship To Customer Names"
    sql: COALESCE(${TABLE}.customer_names_ship_to,${sales_order_partner_function_sdt.customer_names_ship_to}) ;;
  }


}
