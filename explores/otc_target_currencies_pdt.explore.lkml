#########################################################{
# PURPOSE
# Provides list of target currencies and exchange rate types to show as filter suggestions.
# Hidden as only used for filter suggestions.
#
# SOURCES
# See the "include: " statements below for specifc sources
#
# REFERENCED BY
#   LookML dashboard otc_template
#   View otc_common_parameters_xvw
##########################################################}

include: "/views/core/otc_target_currencies_pdt.view"

explore: otc_target_currencies_pdt {
  hidden: yes
  label: "OTC Target Currencies"
  description: "Distinct list of available currencies and exchange rate types used to provide filter suggestions"
}
