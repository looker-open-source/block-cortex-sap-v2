include: "/views/base/customers_md.view"

view: +customers_md {
  fields_hidden_by_default: yes
  label: "Customers"

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: concat(${client_mandt},${customer_number_kunnr},${language_spras}) ;;
  }

  dimension: client_mandt {
    hidden:  yes
    label: "@{label_sap_field_name}"
  }

  dimension: customer_number_kunnr {
    hidden: no
    label: "@{label_sap_field_name}"
  }

  dimension: language_spras {
    type: string
    hidden: no
    label: "@{label_sap_field_name}"
    sql: COALESCE(${language_key_spras},'NA') ;;
  }

  dimension: customer_name  {
    hidden: no
    label: "{% if _explore._name == 'sales_orders_v2' %}Sold to Party Name{%else%}Customer Name{%endif%}"
    description: "Customer Name (name1)"
    sql: COALESCE(${TABLE}.name1_name1,CONCAT("Customer - ",${customer_number_kunnr})) ;;
  }

  dimension: country_key_land1 {
    hidden: no
    label: "{% if _explore._name == 'sales_orders_v2' %}Sold to Party Region Key {%else%}Country Key{%endif%}"
    }
   }