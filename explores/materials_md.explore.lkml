#########################################################{
# PURPOSE
# Provides list of materials found in sales_orders_v2 and their attributes.
# Hidden as only used as source for otc dashboard filter product.
#
# SOURCES
# See the "include: " statements below for specifc sources
#
# REFERENCED BY
#   LookML dashboards:
#     otc_template
#
# NOTES
#   - sql_always_where to limit to single Client MANDT based on CLIENT_ID constant set in manifest file
#   - sql_always_where to limit to single Language based on user_language constant set in manifest file
#   - always_join to limit to only those materials found for customers in sales_orders_v2
#########################################################}

include: "/views/core/materials_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: materials_md {
  label: "Materials"
  hidden: yes
  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  always_join: [sales_orders_v2]

  join: sales_orders_v2 {
    type: inner
    relationship: one_to_many
    sql_on: ${materials_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
            ${materials_md.material_number_matnr} = ${sales_orders_v2.material_number_matnr} ;;
    fields: []
  }


}
