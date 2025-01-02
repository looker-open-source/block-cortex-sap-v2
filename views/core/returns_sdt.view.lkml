#########################################################{
# PURPOSE
# SQL-based derived table that provides list of Returned Orders (both Header and Line Items)
#
# REFERENCED BY
# Explore sales_orders_v2
# View across_sales_and_returns_xvw
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - Shown in sales_orders_v2 explore as part of Sales Orders or Sales Orders Items depending on level of detail
#   - Additional fields that require Sales Orders found in field-only view across_sales_and_returns_xvw
#   - ReferenceDocument_VGBEL equals SalesDocument_VBELN when PrecedingDocCategory_VGTYP = C
#   - ReferenceDocument_VGBEL equals BillingDocument when PrecedingDocCategory_VGTYP = M
#
#########################################################}

view: returns_sdt {

  view_label: "Returns"

  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT
        sv2.Client_Mandt,
        sv2.SalesDocument_VBELN as Return_SalesDocument_VBELN,
        sv2.Item_POSNR as Return_Item_POSNR,
        sv2.DocumentCategory_VBTYP as Return_DocumentCategory_VBTYP,
        sv2.CreationDate_ERDAT as Return_CreationDate_ERDAT,
        sv2.CreationTime_ERZET as Return_CreationTime_ERZET,
        sv2.CumulativeOrderQuantity_KWMENG as Return_ItemQuantity,
        sv2.NetPrice_NETPR as Return_NetPrice_NETPR,
        sv2.PrecedingDocCategory_VGTYP,
    --ReferenceDocument_VGBEL equals:
    -- SalesDocument_VBELN when PrecedingDocCategory_VGTYP = C
    -- BillingDocument when PrecedingDocCategory_VGTYP = M
        sv2.ReferenceDocument_VGBEL,
        sv2.ReferenceItem_VGPOS,
        sv2.DocumentNumberOfTheReferenceDocument_VGBEL,
        CASE sv2.PrecedingDocCategory_VGTYP
          WHEN 'C' THEN sv2.ReferenceDocument_VGBEL
          WHEN 'M' THEN b.SalesDocument_AUBEL
        END
          AS ReferenceSalesDocument_VBELN,
        CASE sv2.PrecedingDocCategory_VGTYP
          WHEN 'C' THEN sv2.ReferenceItem_VGPOS
          WHEN 'M' THEN b.SalesDocumentItem_AUPOS
        END
          AS ReferenceItem_POSNR
      FROM
        `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrders_V2` sv2
      LEFT JOIN
        `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Billing` b
      ON
        sv2.ReferenceDocument_VGBEL = b.BillingDocument_VBELN
        AND sv2.ReferenceItem_VGPOS = b.BillingItem_POSNR
        AND sv2.Client_Mandt = b.Client_MANDT
        AND b.BillingType_FKART IN ('F1',
          'F2')
        AND b.BillingDocumentIsCancelled_FKSTO IS NULL
      WHERE
        sv2.DocumentCategory_VBTYP = 'H'
        AND sv2.Client_MANDT = '@{CLIENT_ID}'
        ;;
  }

  dimension: key {
    type: string
    primary_key: yes
    sql: CONCAT(${client_mandt},${return_sales_document_vbeln},${return_item_posnr},${reference_sales_document_vbeln},${reference_item_posnr}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_Mandt ;;
  }

#########################################################
# DIMENSIONS: Return Order Attributes
#{

  dimension: return_sales_document_vbeln {
    type: string
    hidden: no
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Returns{%- endif -%}"
    label: "@{label_sap_field_name}"
    description: "Sales Document ID of Return (VBELN)"
    sql: ${TABLE}.Return_SalesDocument_VBELN ;;
  }

  dimension: return_item_posnr {
    type: string
    label: "Return Item ID@{label_append_sap_code}"
    description: "Return Item ID (POSNR)"
    sql: ${TABLE}.Return_Item_POSNR ;;
  }

  dimension: return_document_category_vbtyp {
    type: string
    sql: ${TABLE}.Return_DocumentCategory_VBTYP ;;
  }

  dimension: return_creation_date_erdat {
    hidden: no
    type: date
    datatype: date
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Returns{%- endif -%}"
    label: "Return Creation Date@{label_append_sap_code}"
    description: "Date the return order was created"
    sql: ${TABLE}.Return_CreationDate_ERDAT ;;
  }

  dimension: return_order_date_as_string {
    type: string
    label: "Return Order Date"
    sql: STRING(${TABLE}.Return_CreationDate_ERDAT) ;;
  }

  dimension: return_creation_time_erzet {
    type: string
    sql: ${TABLE}.Return_CreationTime_ERZET ;;
  }

  dimension: item_return_quantity {
    hidden: no
    type: number
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Item Quantities{%- endif -%}"
    label: "Returned Quantity"
    description: "Quantity returned"
    sql: ${TABLE}.Return_ItemQuantity ;;
  }

  dimension: return_net_price_netpr {
    type: number
    sql: ${TABLE}.return_NetPrice_NETPR ;;
  }

  dimension: preceding_doc_category_vgtyp {
    type: string
    sql: ${TABLE}.PrecedingDocCategory_VGTYP ;;
  }

  dimension: reference_document_vgbel {
    type: string
    sql: ${TABLE}.ReferenceDocument_VGBEL ;;
  }

  dimension: reference_item_vgpos {
    type: string
    sql: ${TABLE}.ReferenceItem_VGPOS ;;
  }

  dimension: document_number_of_the_reference_document_vgbel {
    type: string
    sql: ${TABLE}.DocumentNumberOfTheReferenceDocument_VGBEL ;;
  }

  dimension: reference_sales_document_vbeln {
    type: string
    sql: ${TABLE}.ReferenceSalesDocument_VBELN ;;
  }

  dimension: reference_item_posnr {
    type: string
    sql: ${TABLE}.ReferenceItem_POSNR ;;
  }

  dimension: is_return {
    hidden: no
    type: yesno
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    group_label: "{%- if _explore._name == 'sales_orders_v2' -%}Returns{%- endif -%}"
    sql: ${reference_sales_document_vbeln} IS NOT NULL ;;
  }
#} end order attribute dimensions

#########################################################
# MEASURES: Quantity
#{
  measure: total_returned_quantity {
    hidden: no
    type: sum
    view_label: "{%- if _explore._name == 'sales_orders_v2' -%}Sales Orders Items{%- endif -%}"
    sql: ${item_return_quantity} ;;
  }

#} end quantity measures

#########################################################
# SETS
#{
  set: fields_in_sales_orders {
    fields: [return_sales_document_vbeln,
            is_return,
            return_creation_date_erdat,
            return_order_date_as_string,
            item_return_quantity,
            total_returned_quantity
            ]
  }
#}
}