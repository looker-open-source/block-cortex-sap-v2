view: billing {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.Billing` ;;

  dimension: accounting_document_number_belnr {
    type: string
    description: "Document Number"
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }
  dimension: accrual_billing_type_fkart {
    type: string
    description: "Billing Type"
    sql: ${TABLE}.AccrualBillingType_FKART ;;
  }
  dimension: actual_billed_quantity_fkimg {
    type: number
    description: "Billed Quantity"
    sql: ${TABLE}.ActualBilledQuantity_FKIMG ;;
  }
  dimension: batch_number_charg {
    type: string
    description: "Batch"
    sql: ${TABLE}.BatchNumber_CHARG ;;
  }
  dimension: billing_category_fktyp {
    type: string
    description: "Billing category"
    sql: ${TABLE}.BillingCategory_FKTYP ;;
  }
  dimension_group: billing_date_fkdat {
    type: time
    description: "Billing Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BillingDate_FKDAT ;;
  }
  dimension: billing_document_is_cancelled_fksto {
    type: string
    description: "Cancelled"
    sql: ${TABLE}.BillingDocumentIsCancelled_FKSTO ;;
  }
  dimension: billing_document_vbeln {
    type: string
    description: "Billing Document"
    sql: ${TABLE}.BillingDocument_VBELN ;;
  }
  dimension: billing_item_posnr {
    type: string
    description: "Item"
    sql: ${TABLE}.BillingItem_POSNR ;;
  }
  dimension: billing_type_fkart {
    type: string
    description: "Billing Type"
    sql: ${TABLE}.BillingType_FKART ;;
  }
  dimension: bomexplosion_number_sernr {
    type: string
    description: "BOM explosion number"
    sql: ${TABLE}.BOMExplosionNumber_SERNR ;;
  }
  dimension: business_area_gsber {
    type: string
    description: "Business Area"
    sql: ${TABLE}.BusinessArea_GSBER ;;
  }
  dimension: city_code_cityc {
    type: string
    description: "City code"
    sql: ${TABLE}.CityCode_CITYC ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: company_code_bukrs {
    type: string
    description: "Company Code"
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }
  dimension: condition_item_number_kposn {
    type: string
    description: "Item"
    sql: ${TABLE}.ConditionItemNumber_KPOSN ;;
  }
  dimension: controlling_area_kokrs {
    type: string
    description: "Controlling Area"
    sql: ${TABLE}.ControllingArea_KOKRS ;;
  }
  dimension: cost_center_kostl {
    type: string
    description: "Cost Center"
    sql: ${TABLE}.CostCenter_KOSTL ;;
  }
  dimension: country_code_counc {
    type: string
    description: "County code"
    sql: ${TABLE}.CountryCode_COUNC ;;
  }
  dimension: country_of_sales_tax_idnumber_stceg_l {
    type: string
    description: "Country sls.tax no."
    sql: ${TABLE}.CountryOfSalesTaxIDNumber_STCEG_L ;;
  }
  dimension: customer_group1_kvgr1 {
    type: string
    description: "Customer group 1"
    sql: ${TABLE}.CustomerGroup1_KVGR1 ;;
  }
  dimension: customer_group2_kvgr2 {
    type: string
    description: "Customer group 2"
    sql: ${TABLE}.CustomerGroup2_KVGR2 ;;
  }
  dimension: customer_group3_kvgr3 {
    type: string
    description: "Customer group 3"
    sql: ${TABLE}.CustomerGroup3_KVGR3 ;;
  }
  dimension: customer_group4_kvgr4 {
    type: string
    description: "Customer group 4"
    sql: ${TABLE}.CustomerGroup4_KVGR4 ;;
  }
  dimension: customer_group5_kvgr5 {
    type: string
    description: "Customer group 5"
    sql: ${TABLE}.CustomerGroup5_KVGR5 ;;
  }
  dimension: customer_group_kdgrp {
    type: string
    description: "Customer group"
    sql: ${TABLE}.CustomerGroup_KDGRP ;;
  }
  dimension: customer_price_group_konda {
    type: string
    description: "Price group"
    sql: ${TABLE}.CustomerPriceGroup_KONDA ;;
  }
  dimension: day_of_billing_date_fkdat {
    type: number
    description: "Billing Date"
    sql: ${TABLE}.DayOfBillingDate_FKDAT ;;
  }
  dimension: destination_country_land1 {
    type: string
    description: "Destination Country"
    sql: ${TABLE}.DestinationCountry_LAND1 ;;
  }
  dimension: distribution_channel_vtweg {
    type: string
    description: "Distribution Channel"
    sql: ${TABLE}.DistributionChannel_VTWEG ;;
  }
  dimension: division_spart {
    type: string
    description: "Division"
    sql: ${TABLE}.Division_SPART ;;
  }
  dimension: document_category_of_preceding_sddocument_vgtyp {
    type: string
    description: "Preceding doc.categ."
    sql: ${TABLE}.DocumentCategoryOfPrecedingSDDocument_VGTYP ;;
  }
  dimension: document_number_of_the_reference_document_vgbel {
    type: string
    description: "Reference Document"
    sql: ${TABLE}.DocumentNumberOfTheReferenceDocument_VGBEL ;;
  }
  dimension: dunning_block_mansp {
    type: string
    description: "Dunning Block"
    sql: ${TABLE}.DunningBlock_MANSP ;;
  }
  dimension: dunning_key_mschl {
    type: string
    description: "Dunning Key"
    sql: ${TABLE}.DunningKey_MSCHL ;;
  }
  dimension: fiscal_year_gjahr {
    type: string
    description: "Fiscal Year"
    sql: ${TABLE}.FiscalYear_GJAHR ;;
  }
  dimension: gross_weight_brgew {
    type: number
    description: "Gross weight"
    sql: ${TABLE}.GrossWeight_BRGEW ;;
  }
  dimension: incoterms_part1_inco1 {
    type: string
    description: "Incoterms"
    sql: ${TABLE}.IncotermsPart1_INCO1 ;;
  }
  dimension: incoterms_part2_inco2 {
    type: string
    description: "Incoterms (Part 2)"
    sql: ${TABLE}.IncotermsPart2_INCO2 ;;
  }
  dimension: international_article_number_ean11 {
    type: string
    description: "EAN/UPC"
    sql: ${TABLE}.InternationalArticleNumber_EAN11 ;;
  }
  dimension: item_number_of_the_reference_item_vgpos {
    type: string
    description: "Reference Item"
    sql: ${TABLE}.ItemNumberOfTheReferenceItem_VGPOS ;;
  }
  dimension: item_type_posar {
    type: string
    description: "Item type"
    sql: ${TABLE}.ItemType_POSAR ;;
  }
  dimension_group: last_change_date_aedat {
    type: time
    description: "Changed On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LastChangeDate_AEDAT ;;
  }
  dimension: material_group1_mvgr1 {
    type: string
    description: "Material group 1"
    sql: ${TABLE}.MaterialGroup1_MVGR1 ;;
  }
  dimension: material_group2_mvgr2 {
    type: string
    description: "Material group 2"
    sql: ${TABLE}.MaterialGroup2_MVGR2 ;;
  }
  dimension: material_group3_mvgr3 {
    type: string
    description: "Material group 3"
    sql: ${TABLE}.MaterialGroup3_MVGR3 ;;
  }
  dimension: material_group4_mvgr4 {
    type: string
    description: "Material group 4"
    sql: ${TABLE}.MaterialGroup4_MVGR4 ;;
  }
  dimension: material_group5_mvgr5 {
    type: string
    description: "Material group 5"
    sql: ${TABLE}.MaterialGroup5_MVGR5 ;;
  }
  dimension: material_group_matkl {
    type: string
    description: "Material Group"
    sql: ${TABLE}.MaterialGroup_MATKL ;;
  }
  dimension: material_number_matnr {
    type: string
    description: "Material"
    sql: ${TABLE}.MaterialNumber_MATNR ;;
  }
  dimension: material_price_group_kondm {
    type: string
    description: "Material pricing grp"
    sql: ${TABLE}.MaterialPriceGroup_KONDM ;;
  }
  dimension: month_of_billing_date_fkdat {
    type: number
    description: "Billing Date"
    sql: ${TABLE}.MonthOfBillingDate_FKDAT ;;
  }
  dimension: month_order_count {
    type: number
    description: "Month Order Count"
    sql: ${TABLE}.MonthOrderCount ;;
  }
  dimension: net_value_netwr {
    type: number
    description: "Net Value"
    sql: ${TABLE}.NetValue_NETWR ;;
  }
  dimension: net_weight_ntgew {
    type: number
    description: "Net weight"
    sql: ${TABLE}.NetWeight_NTGEW ;;
  }
  dimension: number_of_the_document_condition_knumv {
    type: string
    description: "Doc. condition no."
    sql: ${TABLE}.NumberOfTheDocumentCondition_KNUMV ;;
  }
  dimension: origin_of_sales_tax_idnumber_stceg_h {
    type: string
    description: "Origin sls.tax no."
    sql: ${TABLE}.OriginOfSalesTaxIDNumber_STCEG_H ;;
  }
  dimension: payer_kunrg {
    type: string
    description: "Payer"
    sql: ${TABLE}.Payer_KUNRG ;;
  }
  dimension: payment_method_zlsch {
    type: string
    description: "Payment Method"
    sql: ${TABLE}.PaymentMethod_ZLSCH ;;
  }
  dimension: plant_werks {
    type: string
    description: "Plant"
    sql: ${TABLE}.Plant_WERKS ;;
  }
  dimension: posting_period_poper {
    type: string
    description: "Posting Period"
    sql: ${TABLE}.PostingPeriod_POPER ;;
  }
  dimension: price_list_type_pltyp {
    type: string
    description: "Price List"
    sql: ${TABLE}.PriceListType_PLTYP ;;
  }
  dimension: pricing_reference_material_pmatn {
    type: string
    description: "Pricing Ref. Matl"
    sql: ${TABLE}.PricingReferenceMaterial_PMATN ;;
  }
  dimension: product_hierarchy_prodh {
    type: string
    description: "Product Hierarchy"
    sql: ${TABLE}.ProductHierarchy_PRODH ;;
  }
  dimension: profit_center_prctr {
    type: string
    description: "Profit Center"
    sql: ${TABLE}.ProfitCenter_PRCTR ;;
  }
  dimension: rebate {
    type: number
    description: "Rebate"
    sql: ${TABLE}.Rebate ;;
  }
  dimension_group: record_creation_date_erdat {
    type: time
    description: "Created On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RecordCreationDate_ERDAT ;;
  }
  dimension: reference_document_number_xblnr {
    type: string
    description: "Reference"
    sql: ${TABLE}.ReferenceDocumentNumber_XBLNR ;;
  }
  dimension: region_regio {
    type: string
    description: "Region"
    sql: ${TABLE}.Region_REGIO ;;
  }
  dimension: sales_district_bzirk {
    type: string
    description: "Sales district"
    sql: ${TABLE}.SalesDistrict_BZIRK ;;
  }
  dimension: sales_document_aubel {
    type: string
    description: "Sales Document"
    sql: ${TABLE}.SalesDocument_AUBEL ;;
  }
  dimension: sales_document_item_aupos {
    type: string
    description: "Sales Document Item"
    sql: ${TABLE}.SalesDocumentItem_AUPOS ;;
  }
  dimension: sales_document_item_category_pstyv {
    type: string
    description: "Item Category"
    sql: ${TABLE}.SalesDocumentItemCategory_PSTYV ;;
  }
  dimension: sales_group_vkgrp {
    type: string
    description: "Sales Group"
    sql: ${TABLE}.SalesGroup_VKGRP ;;
  }
  dimension: sales_office_vkbur {
    type: string
    description: "Sales Office"
    sql: ${TABLE}.SalesOffice_VKBUR ;;
  }
  dimension: sales_organization_vkorg {
    type: string
    description: "Sales Organization"
    sql: ${TABLE}.SalesOrganization_VKORG ;;
  }
  dimension: sd_document_currency_waerk {
    type: string
    description: "Document Currency"
    sql: ${TABLE}.SdDocumentCurrency_WAERK ;;
  }
  dimension: sddocument_category_vbtyp {
    type: string
    description: "SD document categ."
    sql: ${TABLE}.SDDocumentCategory_VBTYP ;;
  }
  dimension: shipping_conditions_vsbed {
    type: string
    description: "Shipping Conditions"
    sql: ${TABLE}.ShippingConditions_VSBED ;;
  }
  dimension: shipping_point_receiving_point_vstel {
    type: string
    description: "Shipping Point/Receiving Pt"
    sql: ${TABLE}.ShippingPointReceivingPoint_VSTEL ;;
  }
  dimension: sold_to_party_kunag {
    type: string
    description: "Sold-To Party"
    sql: ${TABLE}.SoldToParty_KUNAG ;;
  }
  dimension: status_for_transfer_to_accounting_rfbsk {
    type: string
    description: "Posting Status"
    sql: ${TABLE}.StatusForTransferToAccounting_RFBSK ;;
  }
  dimension: storage_location_lgort {
    type: string
    description: "Storage Location"
    sql: ${TABLE}.StorageLocation_LGORT ;;
  }
  dimension: tax_amount_mwsbk {
    type: number
    description: "Tax amount"
    sql: ${TABLE}.TaxAmount_MWSBK ;;
  }
  dimension: tax_amount_pos_mwsbp {
    type: number
    description: "Tax amount"
    sql: ${TABLE}.TaxAmountPos_MWSBP ;;
  }
  dimension: tax_classification1_for_customer_taxk1 {
    type: string
    description: "TaxClass1-Cust."
    sql: ${TABLE}.TaxClassification1ForCustomer_TAXK1 ;;
  }
  dimension: tax_classification2_for_customer_taxk2 {
    type: string
    description: "TaxClass2-Cust."
    sql: ${TABLE}.TaxClassification2ForCustomer_TAXK2 ;;
  }
  dimension: tax_classification3_for_customer_taxk3 {
    type: string
    description: "TaxClass3-Cust."
    sql: ${TABLE}.TaxClassification3ForCustomer_TAXK3 ;;
  }
  dimension: tax_classification4_for_customer_taxk4 {
    type: string
    description: "TaxClass4-Cust."
    sql: ${TABLE}.TaxClassification4ForCustomer_TAXK4 ;;
  }
  dimension: tax_classification5_for_customer_taxk5 {
    type: string
    description: "TaxClass5-Cust."
    sql: ${TABLE}.TaxClassification5ForCustomer_TAXK5 ;;
  }
  dimension: tax_departure_country_landtx {
    type: string
    description: "Tax depart. country"
    sql: ${TABLE}.TaxDepartureCountry_LANDTX ;;
  }
  dimension: tax_jurisdiction_txjcd {
    type: string
    description: "Tax Jurisdiction"
    sql: ${TABLE}.TaxJurisdiction_TXJCD ;;
  }
  dimension: volume_volum {
    type: number
    description: "Volume"
    sql: ${TABLE}.Volume_VOLUM ;;
  }
  dimension: week_of_billing_date_fkdat {
    type: number
    description: "Billing Date"
    sql: ${TABLE}.WeekOfBillingDate_FKDAT ;;
  }
  dimension: week_order_count {
    type: number
    description: "Week Order Count"
    sql: ${TABLE}.WeekOrderCount ;;
  }
  dimension: year_of_billing_date_fkdat {
    type: number
    description: "Billing Date"
    sql: ${TABLE}.YearOfBillingDate_FKDAT ;;
  }
  dimension: year_order_count {
    type: number
    description: "Year Order Count"
    sql: ${TABLE}.YearOrderCount ;;
  }
  measure: count {
    type: count
  }
}