#########################################################{
# PURPOSE
# Provides list of Orders & Items that have been processed
# without any intervention
#
# SOURCES
# Refines view one_touch_order
# References that must also be included in the same Explore:
#    sales_orders_v2
#
# REFERENCED BY
# Explore sales_orders_v2
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - This refinement view only includes fields added or edited. Full list of fields available are found in the base view.
#   - Includes fields which reference the sales_orders_v2 view.
#
#########################################################}

include: "/views/base/one_touch_order.view"


view: +one_touch_order {
  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${vbapclient_mandt},${vbapsales_document_vbeln},${vbapsales_document_item_posnr}) ;;
  }

  dimension: is_one_touch_order {
    hidden: no
    type: yesno
    sql: ${vbapsales_document_vbeln} is not null ;;
  }

  measure: one_touch_sales_order_count {
    hidden: no
    type: count_distinct
    sql: ${vbapsales_document_vbeln} ;;
    filters: [sales_orders_v2.document_category_vbtyp: "C"]
  }

  measure: one_touch_sales_order_percent {
    hidden: no
    type: number
    sql: SAFE_DIVIDE(${one_touch_sales_order_count},${sales_orders_v2.sales_order_count}) ;;
    value_format_name: percent_1
  }


}
