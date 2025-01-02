include: "/views/base/companies_md.view"

view: +companies_md {

  fields_hidden_by_default: yes

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${client_mandt},${company_code_bukrs},${language_spras}) ;;
  }

  dimension: language_spras {
    label: "Language_SPRAS"
    sql: COALESCE(${TABLE}.Language_SPRAS,"NA") ;;
  }

  dimension: company_code_bukrs {
    label: "Company Code BUKRS"
  }

  dimension: company_code_text {
    hidden: no
    label: "Company Code"
    sql: ${company_text_butxt} ;;
  }

   }
