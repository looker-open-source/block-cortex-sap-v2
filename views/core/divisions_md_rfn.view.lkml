include: "/views/base/divisions_md.view"

view: +divisions_md {

  fields_hidden_by_default: yes
  label: "Divisions"

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${division_spart},${language_key_spras}) ;;
  }

  dimension: client_mandt {
    hidden: yes
    label: "Client MANDT"
  }

  dimension: division_spart {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  #rename language_key_spras to language_spras
  dimension: language_spras {
    hidden: no
    label: "@{label_sap_field_name}"
    sql: ${language_key_spras} ;;
  }

  dimension: division_name_vtext {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  }