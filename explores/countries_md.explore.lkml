#########################################################{
# PURPOSE
# Provides list of customers and countries found in sales_orders_v2.
# Hidden as only used as source for otc dashboard filters
# customer_name and customer_country.
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
#   - always_join to limit to only those customers and countries found for customers in sales_orders_v2
#########################################################}

include: "/views/core/countries_md_rfn.view"
include: "/views/core/sales_orders_v2_rfn.view"
include: "/views/core/customers_md_rfn.view"

explore: countries_md {
  label: "Countries"
  hidden: yes
  sql_always_where: ${client_mandt} = '@{CLIENT_ID}' AND ${language_spras} = @{user_language};;
  always_join: [sales_orders_v2]


  join: customers_md {
    type: inner
    relationship: many_to_one
    sql_on: ${countries_md.client_mandt} = ${customers_md.client_mandt} AND
            ${countries_md.country_key_land1} = ${customers_md.country_key_land1};;
    fields: [customers_md.customer_name]
  }

  join: sales_orders_v2 {
    type: inner
    relationship: many_to_many
    sql_on: ${customers_md.client_mandt} = ${sales_orders_v2.client_mandt} AND
            ${customers_md.customer_number_kunnr} = ${sales_orders_v2.sold_to_party_kunnr};;
    fields: []
  }

}
