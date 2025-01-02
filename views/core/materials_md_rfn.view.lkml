####!!!! temporarily add rows for ES language_SPRAS to allow for testing

include: "/views/base/materials_md.view"

view: +materials_md {

  view_label: "Materials MD"
  fields_hidden_by_default: yes

#temporarily add rows for ES language_SPRAS to allow for testing
  # derived_table: {
  #   sql: select Client_MANDT
  #               ,MaterialNumber_MATNR
  #               ,m.Language_SPRAS
  #               ,MaterialText_MAKTX

  #       from
  #       (select Client_MANDT
  #               ,MaterialNumber_MATNR
  #               ,Language_SPRAS
  #               ,MaterialText_MAKTX
  #       from `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.MaterialsMD`
  #       union all
  #       select Client_MANDT
  #               ,MaterialNumber_MATNR
  #               ,'S' Language_SPRAS
  #               ,'portatil para jeugos' MaterialText_MAKTX
  #       from `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.MaterialsMD`
  #       where MaterialNumber_MATNR = 'C0000077') m
  #       join ${language_map_sdt.SQL_TABLE_NAME} l on m.Language_SPRAS = l.Language_SPRAS

  #       ;;
  # }

  dimension: key {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${client_mandt},${material_number_matnr},${language_spras} ;;
  }

  dimension: client_mandt {
    hidden: yes
    label: "@{label_sap_field_name}"
  }

  dimension: material_number_matnr {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: language_spras {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: material_text_maktx {
    hidden: no
    label: "@{label_sap_field_name}"
    # sql: COALESCE(${TABLE}.MaterialText_MAKTX,${material_number_matnr}) ;;
  }

  }