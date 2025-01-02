#########################################################{
# PURPOSE
# SQL-based derived table that aggregates a list of sold to, bill to and ship to customers
# for an order (because an order can be associated with multiple customers)
#
# REFERENCED BY
# Explore sales_orders_v2
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - Fields are shown in sales_orders_v2 explore as part of Sales Orders
#########################################################}

view: sales_order_partner_function_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql:
      SELECT
        *
      FROM (
        SELECT
          t.client_MANDT,
          t.SalesDocument_VBELN,
          '000000' as Item_POSNR,
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
          WHERE pf.Client_MANDT = '@{CLIENT_ID}'
          GROUP BY
            pf.client_MANDT,
            pf.SalesDocument_VBELN,
            pf.PartnerFunction_PARVW
            ) t ) c PIVOT(MAX(customer_names) customer_names FOR PartnerFunction_Label IN ('sold_to',
            'bill_to',
            'ship_to'))
      ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    sql: concat(${client_mandt},${sales_document_vbeln}) ;;
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
    group_label: "Customer Lists"
    label: "Sold To Customer Names"
    description: "List of all sold to customer names associated with order"
    sql: ${TABLE}.customer_names_sold_to ;;
  }

  dimension: customer_names_bill_to {
    hidden: no
    type: string
    group_label: "Customer Lists"
    label: "Bill To Customer Names"
    description: "List of all bill to customer names associated with order"
    sql: ${TABLE}.customer_names_bill_to ;;
  }

  dimension: customer_names_ship_to {
    hidden: no
    type: string
    group_label: "Customer Lists"
    label: "Ship To Customer Names"
    description: "List of all ship to customer names associated with order"
    sql: ${TABLE}.customer_names_ship_to ;;
  }


}
