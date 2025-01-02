#########################################################{
# PURPOSE
# Provides list of sales oragnizations and their attributes.
# Hidden as only used as source for otc dashboard filter sales_org.
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
#   - OPTIONAL to limit to only those sales organizations found in sales_orders_v2, uncomment the
#    always_join and join: sales_orders_v2 statements below
#########################################################}
include: "/views/core/sales_organizations_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: sales_organizations_md {
  label: "Sales Organizations"

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${sales_organizations_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${sales_organizations_md.sales_org_vkorg} = ${sales_orders_v2.sales_organization_vkorg} ;;
  #   fields: []
  # }


}
