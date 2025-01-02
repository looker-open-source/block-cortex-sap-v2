include: "/views/base/sales_organizations_md.view"

view: +sales_organizations_md {
  fields_hidden_by_default: yes
  label: "Sales Organizations"

  dimension: key {
    primary_key: yes
    sql: concat(${client_mandt},${sales_org_vkorg},${language_spras} ;;
  }

  dimension: client_mandt {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_org_vkorg {
    hidden: no
    label: "Sales Organization@{label_append_sap_code}"
  }

  dimension: language_spras {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: sales_org_name_vtext {
    hidden: no
    label: "Sales Organization Name@{label_append_sap_code}"
  }

 }