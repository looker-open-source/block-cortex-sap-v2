#########################################################{
# PURPOSE
# Provides list of distribution channels and their attributes.
# Hidden as only used as source for otc dashboard filter distribution_channel.
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
#   - OPTIONAL to limit to only those distribution channels found in sales_orders_v2, uncomment the
#    always_join and join: sales_orders_v2 statements below
#########################################################}

include: "/views/core/distribution_channels_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"

explore: distribution_channels_md {
  label: "Distribution Channels"
  hidden: yes

  sql_always_where: ${language_spras} = @{user_language} AND ${client_mandt} = '@{CLIENT_ID}';;

  # always_join: [sales_orders_v2]

  # join: sales_orders_v2 {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${distribution_channels_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
  #           ${distribution_channels_md.distribution_channel_vtweg} = ${sales_orders_v2.distribution_channel_vtweg} ;;
  #   fields: []
  # }


}
