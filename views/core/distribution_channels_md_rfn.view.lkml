include: "/views/base/distribution_channels_md.view"

view: +distribution_channels_md {

  fields_hidden_by_default: yes
  label: "Distribution Channels"

  dimension: key {
    primary_key: yes
    hidden: yes
    sql: concat(${client_mandt},${distribution_channel_vtweg},${language_spras}) ;;
  }

  dimension: client_mandt {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: distribution_channel_vtweg {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: distribution_channel_name_vtext {
    hidden: no
    label: "@{label_sap_field_name}"
    }
  }