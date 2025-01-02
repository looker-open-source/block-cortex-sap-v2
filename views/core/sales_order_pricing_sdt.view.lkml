#########################################################{
# PURPOSE
# SQL-based derived table that replaces the SalesOrderPricing view
# found in the Reporting Layer in order to correct for IntercompanyPrice
# logic
#
# Generates Adjusted, List and Intercompany Prices and Discount Amount
#
# REFERENCED BY
# Explore billing
#
# NOTES
#   - Fields are hidden by default so must change "hidden" property to "no" to include field in an Explore.
#   - Fields are shown in Billing Explore as part of Billing Items
#
#########################################################}

# Replaces view SalesOrderPricing found in reporting later to correct IntercompanyPrice logic
view: sales_order_pricing_sdt {

  fields_hidden_by_default: yes

  derived_table: {
    sql: SELECT
            Client_MANDT,
            NumberOfTheDocumentCondition_KNUMV,
            ConditionItemNumber_KPOSN,
            SUM(
            IF
              ( CalculationTypeForCondition_KRECH = 'C'
                AND ConditionClass_KOAID = 'B'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS ListPrice,
            SUM(
            IF
              ( CalculationTypeForCondition_KRECH = 'C'
                AND ConditionClass_KOAID = 'B'
                AND ConditionType_KSCHL = 'PB00'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS AdjustedPrice,
            SUM(
            IF
              ( ConditionForInterCompanyBilling_KFKIV = 'X'
                AND ConditionClass_KOAID = 'B'
                AND ConditionIsInactive_KINAK IS NULL
                AND CalculationTypeForCondition_KRECH <> 'C'
                AND StepNumber_STUNR = max_intercompany_stunr, ConditionValue_KWERT, NULL) ) AS IntercompanyPrice,
            SUM(
            IF
              ( ConditionClass_KOAID = 'A'
                AND ConditionIsInactive_KINAK IS NULL, ConditionValue_KWERT, NULL) ) AS DiscountAmount
        FROM (
          SELECT
            Client_MANDT,
            NumberOfTheDocumentCondition_KNUMV,
            ConditionItemNumber_KPOSN,
            StepNumber_STUNR,
            CalculationTypeForCondition_KRECH,
            ConditionForInterCompanyBilling_KFKIV,
            ConditionClass_KOAID,
            ConditionIsInactive_KINAK,
            ConditionType_KSCHL,
            ConditionValue_KWERT,
            MAX(CASE
                WHEN ConditionForInterCompanyBilling_KFKIV = 'X' AND ConditionClass_KOAID = 'B' AND ConditionIsInactive_KINAK IS NULL THEN StepNumber_STUNR
            END
              ) OVER (PARTITION BY Client_MANDT, NumberOfTheDocumentCondition_KNUMV, ConditionItemNumber_KPOSN) AS max_intercompany_stunr
          FROM
            `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.PricingConditions`
          WHERE Client_MANDT = '@{CLIENT_ID}'
          ) AS pc
    GROUP BY
      Client_MANDT,
      NumberOfTheDocumentCondition_KNUMV,
      ConditionItemNumber_KPOSN
       ;;
    }

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${number_of_the_document_condition_knumv},${condition_item_number_kposn}) ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: number_of_the_document_condition_knumv {
    type: string
    label: "Document Condition Number@{label_append_sap_code}"
    description: "Number of the document condition (KNUMV)"
    sql: ${TABLE}.NumberOfTheDocumentCondition_KNUMV ;;
  }

  dimension: condition_item_number_kposn {
    type: string
    label: "@{label_sap_field_name}"
    description: "Condition item number (KPOSN)"
    sql: ${TABLE}.ConditionItemNumber_KPOSN ;;
  }

#########################################################
# DIMENSIONS: Currency Conversion
#{
# Requires currency_conversion_sdt to be joined in same Explore


  dimension: target_currency {
    hidden: yes
    label: "Currency (Target)"
    description:  "Code indicating the target currency into which the source currency is converted"
    sql: {% parameter otc_common_parameters_xvw.parameter_target_currency %} ;;
  }

  dimension: exchange_rate_ukurs {
    hidden: yes
    label: "@{label_sap_field_name}"
    sql: ${currency_conversion_sdt.exchange_rate_ukurs} ;;
  }

#}

  dimension: list_price {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "List Price (Source Currency)"
    description: "Standard price at which product is typically sold (Source Currency)"
    sql: ${TABLE}.ListPrice ;;
    value_format_name: decimal_2
  }

  dimension: list_price_target_currency {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Standard price at which product is typically sold (Target Currency)"
    sql: ${list_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: adjusted_price {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "Adjusted Price (Source Currency)"
    description: "Price after applying discounts, rebates and/or promotions (Local Currency)"
    sql: ${TABLE}.AdjustedPrice ;;
    value_format_name: decimal_2
  }

  dimension: is_adjusted_price {
    hidden: no
    type: yesno
    group_label: "Item Prices & Discounts"
    sql: ${adjusted_price} <> 0 ;;
  }

  dimension: adjusted_price_target_currency {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Price after applying discounts, rebates and/or promotions (Target Currency)"
    sql: ${adjusted_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: variance_list_and_adjusted_price_target_currency {
    hidden: yes
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: CASE WHEN ${adjusted_price} <> 0 THEN
            ${list_price_target_currency} - ${adjusted_price_target_currency}
         END;;
    value_format_name: decimal_2
  }

  dimension: intercompany_price {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "Intercompany Price (Source Currency)"
    description: "Price at which goods are transferred between different company codes (Source Currency)"
    sql: ${TABLE}.IntercompanyPrice ;;
    value_format_name: decimal_2
  }

  dimension: is_intercompany_price {
    hidden: no
    type: yesno
    group_label: "Item Prices & Discounts"
    sql: ${intercompany_price} <> 0 ;;
  }

  dimension: intercompany_price_target_currency {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Price at which goods are transferred between different company codes (Target Currency)"
    sql: ${intercompany_price} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: variance_list_and_intercompany_price_target_currency {
    hidden: yes
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: CASE WHEN ${intercompany_price} <> 0 THEN
            ${list_price_target_currency} - ${intercompany_price_target_currency}
         END;;
    value_format_name: decimal_2
  }

  dimension: discount_amount {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "Discount Amount (Source Currency)"
    description: "Discount amount taken off of list price (Source Currency)"
    sql: ${TABLE}.DiscountAmount ;;
    value_format_name: decimal_2
  }

  dimension: discount_amount_target_currency {
    hidden: no
    type: number
    group_label: "Item Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Discount amount taken off of list price (Target Currency)"
    sql: ${discount_amount} * ${exchange_rate_ukurs} ;;
    value_format_name: decimal_2
  }

  dimension: is_discount {
    type: yesno
    group_label: "Item Prices & Discounts"
    sql: ${discount_amount} <> 0 ;;
  }

  measure: average_list_price_target_currency {
    hidden: no
    type: average
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${list_price_target_currency} ;;
    value_format_name: decimal_0
#--> returns table of invoice lines where price is adjusted
    link: {
      label: "Show Adjusted Price details"
      url: "
      {% if average_adjusted_price_target_currency._is_selected %}
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'billing.sold_to_party_kunag, billing.customer_name, billing.billing_document_vbeln, billing.sales_document_aubel, billing.billing_date_fkdat, billing.material_number_matnr, billing.material_text_maktx, billing.actual_billed_quantity_fkimg, billing.item_billed_amount_target_currency, sales_order_pricing_sdt.list_price_target_currency, sales_order_pricing_sdt.adjusted_price_target_currency, sales_order_pricing_sdt.difference_list_and_adjusted_price_target_currency' %}
      {% assign default_filters = 'sales_order_pricing_sdt.adjusted_price_target_currency%3e0' %}
      {% assign sorts = 'sales_order_pricing_sdt.absolute_difference_list_and_adjusted_price_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      {% endif %}
      "
    }
#--> returns table of invoice lines where price is adjusted
    link: {
      label: "Show Intercompany Price details"
      url: "
      {% if average_intercompany_price_target_currency._is_selected %}
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'billing.sold_to_party_kunag, billing.customer_name, billing.billing_document_vbeln, billing.sales_document_aubel, billing.billing_date_fkdat, billing.material_number_matnr, billing.material_text_maktx, billing.actual_billed_quantity_fkimg, billing.item_billed_amount_target_currency, sales_order_pricing_sdt.list_price_target_currency, sales_order_pricing_sdt.intercompany_price_target_currency, sales_order_pricing_sdt.difference_list_and_intercompany_price_target_currency' %}
      {% assign default_filters = 'sales_order_pricing_sdt.intercompany_price%3e0' %}
      {% assign sorts = 'sales_order_pricing_sdt.absolute_difference_list_and_intercompany_price_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      {% endif %}
      "
    }
  }

  measure: average_adjusted_price_target_currency {
    hidden: no
    type: average
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${adjusted_price_target_currency} ;;
    value_format_name: decimal_0
#--> returns table of invoice lines where price is adjusted
    link: {
      label: "Show Adjusted Price details"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'billing.sold_to_party_kunag, billing.customer_name, billing.billing_document_vbeln, billing.sales_document_aubel, billing.billing_date_fkdat, billing.material_number_matnr, billing.material_text_maktx, billing.actual_billed_quantity_fkimg, billing.item_billed_amount_target_currency, sales_order_pricing_sdt.list_price_target_currency, sales_order_pricing_sdt.adjusted_price_target_currency, sales_order_pricing_sdt.difference_list_and_adjusted_price_target_currency' %}
      {% assign default_filters = 'sales_order_pricing_sdt.adjusted_price_target_currency%3e0' %}
      {% assign sorts = 'sales_order_pricing_sdt.absolute_difference_list_and_adjusted_price_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#--> opens Billing Details dashboard filtered to lines where price is adjusted
    link: {
      label: "Billing Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = true %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_billing_details}' %}
      {% assign default_filters='is_adjusted_price=Yes'%}
      @{link_map_otc_target_dash_id_billing_details}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: difference_list_and_adjusted_price_target_currency {
    hidden: no
    type: number
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Difference between average list price and average adjusted price in target currency"
    sql: ${average_list_price_target_currency} - ${average_adjusted_price_target_currency};;
    value_format_name: decimal_2
  }

  measure: absolute_difference_list_and_adjusted_price_target_currency {
    hidden: yes
    type: number
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Absolute value of difference between average list price and average adjusted price"
    sql: ABS(${difference_list_and_adjusted_price_target_currency});;
    value_format_name: decimal_2
  }

  measure: average_intercompany_price_target_currency {
    hidden: no
    type: average
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    sql: ${intercompany_price_target_currency} ;;
    value_format_name: decimal_0
#--> returns table of invoice lines where price is adjusted
    link: {
      label: "Show Intercompany Price details"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign drill_fields = 'billing.sold_to_party_kunag, billing.customer_name, billing.billing_document_vbeln, billing.sales_document_aubel, billing.billing_date_fkdat, billing.material_number_matnr, billing.material_text_maktx, billing.actual_billed_quantity_fkimg, billing.item_billed_amount_target_currency, sales_order_pricing_sdt.list_price_target_currency, sales_order_pricing_sdt.intercompany_price_target_currency, sales_order_pricing_sdt.difference_list_and_intercompany_price_target_currency' %}
      {% assign default_filters = 'sales_order_pricing_sdt.intercompany_price%3e0' %}
      {% assign sorts = 'sales_order_pricing_sdt.absolute_difference_list_and_intercompany_price_target_currency+desc' %}
      @{link_vis_table}
      @{link_build_explore_url}
      "
    }
#--> opens Billing Details dashboard filtered to lines where price is adjusted
    link: {
      label: "Billing Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = true %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_billing_details}' %}
      {% assign default_filters='is_intercompany_price=Yes'%}
      @{link_map_otc_target_dash_id_billing_details}
      @{link_build_dashboard_url}
      "
    }
  }

  measure: difference_list_and_intercompany_price_target_currency {
    hidden: no
    type: number
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Difference between average list price and average intercompany price in target currency"
    sql: ${average_list_price_target_currency} - ${average_intercompany_price_target_currency};;
    value_format_name: decimal_2
  }

  measure: absolute_difference_list_and_intercompany_price_target_currency {
    hidden: yes
    type: number
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Absolute value of difference between average list price and average intercompany price"
    sql: ABS(${difference_list_and_intercompany_price_target_currency});;
    value_format_name: decimal_2
  }

  measure: total_discount_amount_target_currency {
    hidden: no
    type: sum
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of Condition Value (KWERT) when Condition Class (KOAID) = 'A'. Value reported as a positive value"
    sql: ${discount_amount_target_currency} * -1 ;;
    value_format_name: decimal_2
  }

  measure: total_discount_amount_target_currency_formatted {
    hidden: no
    type: number
    group_label: "Prices & Discounts"
    label: "@{label_currency_defaults}{%- assign add_formatted = true  -%}@{label_currency_field_name}@{label_currency_if_selected}"
    description: "Sum of Condition Value (KWERT) when Condition Class (KOAID) = 'A'. Value reported as a positive value and formatted for large numbers"
    sql: ${total_discount_amount_target_currency} ;;
    value_format_name: format_large_numbers_d1
    link: {
      label: "Billing Details"
      icon_url: "/favicon.ico"
      url: "
      @{link_build_variable_defaults}
      {% assign link = link_generator._link %}
      {% assign use_qualified_filter_names = true %}
      {% assign source_to_destination_filters_mapping = '@{link_map_otc_billing_to_billing_details}' %}
      {% assign default_filters='is_discount=Yes'%}
      @{link_map_otc_target_dash_id_billing_details}
      @{link_build_dashboard_url}
      "
    }
  }

#########################################################
# MEASURES: Helper
#{
# Hidden measures used to support url link generation
  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }
#} end helper measures

  }