view: sales_orders_v2 {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.SalesOrders_V2` ;;

  dimension: account_assignment_category_knttp {
    type: string
    description: "Acct Assignment Cat."
    sql: ${TABLE}.AccountAssignmentCategory_KNTTP ;;
  }
  dimension: account_assignment_group_for_this_material_ktgrm {
    type: string
    description: "Acct assignment grp"
    sql: ${TABLE}.AccountAssignmentGroupForThisMaterial_KTGRM ;;
  }
  dimension: agreement_knuma {
    type: string
    description: "Agreement"
    sql: ${TABLE}.Agreement_KNUMA ;;
  }
  dimension_group: agreement_valid_from_guebg {
    type: time
    description: "Valid-from date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AgreementValidFrom_GUEBG ;;
  }
  dimension_group: agreement_valid_to_gueen {
    type: time
    description: "Valid-to date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AgreementValidTo_GUEEN ;;
  }
  dimension: allocation_indicator_vpzuo {
    type: string
    description: "Allocation indicat."
    sql: ${TABLE}.AllocationIndicator_VPZUO ;;
  }
  dimension: allowed_deviation_absfz {
    type: number
    description: "Absolute deviation"
    sql: ${TABLE}.AllowedDeviation_ABSFZ ;;
  }
  dimension: allowed_deviation_percent_kbver {
    type: number
    description: "Deviation in percent"
    sql: ${TABLE}.AllowedDeviationPercent_KBVER ;;
  }
  dimension: alternative_for_item_grpos {
    type: string
    description: "Alternative to item"
    sql: ${TABLE}.AlternativeForItem_GRPOS ;;
  }
  dimension: alternative_tax_classification_taxk1 {
    type: string
    description: "Alt.tax classific."
    sql: ${TABLE}.AlternativeTaxClassification_TAXK1 ;;
  }
  dimension: approval_block_msr_approv_block {
    type: string
    description: "Approval"
    sql: ${TABLE}.ApprovalBlock_MSR_APPROV_BLOCK ;;
  }
  dimension: assignment_number_zuonr {
    type: string
    description: "Assignment"
    sql: ${TABLE}.AssignmentNumber_ZUONR ;;
  }
  dimension: assortment_module_skopf {
    type: string
    description: "Module"
    sql: ${TABLE}.AssortmentModule_SKOPF ;;
  }
  dimension: base_target_conversion_factor_umziz {
    type: number
    description: "Conversion factor"
    sql: ${TABLE}.BaseTargetConversionFactor_UMZIZ ;;
  }
  dimension: base_unit_of_measure_for_product_group_prbme {
    type: string
    description: "Product group unit"
    sql: ${TABLE}.BaseUnitOfMeasureForProductGroup_PRBME ;;
  }
  dimension: base_unit_of_measure_meins {
    type: string
    description: "Base Unit of Measure"
    sql: ${TABLE}.BaseUnitOfMeasure_MEINS ;;
  }
  dimension: batch_management_indicator_xchar {
    type: string
    description: "Batch management"
    sql: ${TABLE}.BatchManagementIndicator_XCHAR ;;
  }
  dimension: batch_management_requirement_indicator_xchpf {
    type: string
    description: "Batch management"
    sql: ${TABLE}.BatchManagementRequirementIndicator_XCHPF ;;
  }
  dimension: batch_number_charg {
    type: string
    description: "Batch"
    sql: ${TABLE}.BatchNumber_CHARG ;;
  }
  dimension: batch_split_allowed_chspl {
    type: string
    description: "Batch split allowed"
    sql: ${TABLE}.BatchSplitAllowed_CHSPL ;;
  }
  dimension: billing_block_faksk {
    type: string
    description: "Billing block"
    sql: ${TABLE}.BillingBlock_FAKSK ;;
  }
  dimension: billing_block_for_item_faksp {
    type: string
    description: "Billing block"
    sql: ${TABLE}.BillingBlockForItem_FAKSP ;;
  }
  dimension: bom_stlnr {
    type: string
    description: "Bill of material"
    sql: ${TABLE}.BOM_STLNR ;;
  }
  dimension: bomcategory_stlty {
    type: string
    description: "BOM category"
    sql: ${TABLE}.BOMCategory_STLTY ;;
  }
  dimension_group: bomdate_stdat {
    type: time
    description: "BOM key date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BOMDate_STDAT ;;
  }
  dimension: bomexplosion_number_sernr {
    type: string
    description: "BOM explosion number"
    sql: ${TABLE}.BOMExplosionNumber_SERNR ;;
  }
  dimension: bomitem_level_uepos {
    type: string
    description: "Higher-level item"
    sql: ${TABLE}.BOMItemLevel_UEPOS ;;
  }
  dimension: bomitem_node_number_stlkn {
    type: string
    description: "Item node"
    sql: ${TABLE}.BOMItemNodeNumber_STLKN ;;
  }
  dimension: bomitem_number_sposn {
    type: string
    description: "Item Number"
    sql: ${TABLE}.BOMItemNumber_SPOSN ;;
  }
  dimension: bomorigin_stkey {
    type: string
    description: "BOM origin"
    sql: ${TABLE}.BOMOrigin_STKEY ;;
  }
  dimension: business_area_gsber {
    type: string
    description: "Business Area"
    sql: ${TABLE}.BusinessArea_GSBER ;;
  }
  dimension: business_area_hdr_gsber {
    type: string
    description: "Business Area"
    sql: ${TABLE}.BusinessAreaHdr_GSBER ;;
  }
  dimension: business_transaction_type_for_foreign_trade_exart {
    type: string
    description: "Bus.transaction type"
    sql: ${TABLE}.BusinessTransactionTypeForForeignTrade_EXART ;;
  }
  dimension: cash_discount_indicator_sktof {
    type: string
    description: "Cash discount"
    sql: ${TABLE}.CashDiscountIndicator_SKTOF ;;
  }
  dimension_group: changed_on_aedat {
    type: time
    description: "Changed On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ChangedOn_AEDAT ;;
  }
  dimension: checking_group_for_availability_check_mtvfp {
    type: string
    description: "Availability check"
    sql: ${TABLE}.CheckingGroupForAvailabilityCheck_MTVFP ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: collective_number_submi {
    type: string
    description: "Collective number"
    sql: ${TABLE}.CollectiveNumber_SUBMI ;;
  }
  dimension: commission_group_provg {
    type: string
    description: "Commission group"
    sql: ${TABLE}.CommissionGroup_PROVG ;;
  }
  dimension: company_code_to_be_billed_bukrs_vf {
    type: string
    description: "CCode to be billed"
    sql: ${TABLE}.CompanyCodeToBeBilled_BUKRS_VF ;;
  }
  dimension: complete_delivery_flag_autlf {
    type: string
    description: "Complete delivery"
    sql: ${TABLE}.CompleteDeliveryFlag_AUTLF ;;
  }
  dimension: completion_rule_for_quotation_erlre {
    type: string
    description: "Completion rule"
    sql: ${TABLE}.CompletionRuleForQuotation_ERLRE ;;
  }
  dimension: component_quantity_kmpmg {
    type: number
    description: "Component quantity"
    sql: ${TABLE}.ComponentQuantity_KMPMG ;;
  }
  dimension: condition_number_knumv {
    type: string
    description: "Doc. condition no."
    sql: ${TABLE}.ConditionNumber_KNUMV ;;
  }
  dimension: condition_pricing_unit_kpein {
    type: number
    description: "Pricing unit"
    sql: ${TABLE}.ConditionPricingUnit_KPEIN ;;
  }
  dimension: condition_record_number_nrab_knumh {
    type: string
    description: "No.cond.rec. batch"
    sql: ${TABLE}.ConditionRecordNumber_NRAB_KNUMH ;;
  }
  dimension: condition_unit_kmein {
    type: string
    description: "Unit of measure"
    sql: ${TABLE}.ConditionUnit_KMEIN ;;
  }
  dimension: condition_update_koupd {
    type: string
    description: "Condition update"
    sql: ${TABLE}.ConditionUpdate_KOUPD ;;
  }
  dimension: configuration_cuobj {
    type: string
    description: "Configuration"
    sql: ${TABLE}.Configuration_CUOBJ ;;
  }
  dimension: consumption_posting_kzvbr {
    type: string
    description: "Consumption"
    sql: ${TABLE}.ConsumptionPosting_KZVBR ;;
  }
  dimension: controlling_area_kokrs {
    type: string
    description: "Controlling Area"
    sql: ${TABLE}.ControllingArea_KOKRS ;;
  }
  dimension: conversion_factor_quantities_umref {
    type: number
    description: "Cnversion"
    sql: ${TABLE}.ConversionFactorQuantities_UMREF ;;
  }
  dimension: conversion_factor_umzin {
    type: number
    description: "Conversion factor"
    sql: ${TABLE}.ConversionFactor_UMZIN ;;
  }
  dimension: cost_center_hdr_kostl {
    type: string
    description: "Cost Center"
    sql: ${TABLE}.CostCenterHdr_KOSTL ;;
  }
  dimension: cost_center_kostl {
    type: string
    description: "Cost Center"
    sql: ${TABLE}.CostCenter_KOSTL ;;
  }
  dimension: cost_ctr_business_area_gskst {
    type: string
    description: "Business area"
    sql: ${TABLE}.CostCtrBusinessArea_GSKST ;;
  }
  dimension: cost_estimate_number_kalnr {
    type: string
    description: "Cost Estimate Number"
    sql: ${TABLE}.CostEstimateNumber_KALNR ;;
  }
  dimension: cost_in_document_currency_wavwr {
    type: number
    description: "Cost"
    sql: ${TABLE}.CostInDocumentCurrency_WAVWR ;;
  }
  dimension: costing_sheet_kalsm_k {
    type: string
    description: "Costing Sheet"
    sql: ${TABLE}.CostingSheet_KALSM_K ;;
  }
  dimension: costing_variant_kalvar {
    type: string
    description: "Costing Variant"
    sql: ${TABLE}.CostingVariant_KALVAR ;;
  }
  dimension: costing_variant_klvar {
    type: string
    description: "Costing Variant"
    sql: ${TABLE}.CostingVariant_KLVAR ;;
  }
  dimension: created_by_ernam {
    type: string
    description: "Created By"
    sql: ${TABLE}.CreatedBy_ERNAM ;;
  }
  dimension_group: creation_date_erdat {
    type: time
    description: "Created On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CreationDate_ERDAT ;;
  }
  dimension: creation_time_erzet {
    type: string
    description: "Time"
    sql: ${TABLE}.CreationTime_ERZET ;;
  }
  dimension: credit_block_cmtfg {
    type: string
    description: "Partial release"
    sql: ${TABLE}.CreditBlock_CMTFG ;;
  }
  dimension: credit_control_area_kkber {
    type: string
    description: "Credit control area"
    sql: ${TABLE}.CreditControlArea_KKBER ;;
  }
  dimension: credit_representative_group_for_credit_management_sbgrp {
    type: string
    description: "Credit rep.group"
    sql: ${TABLE}.CreditRepresentativeGroupForCreditManagement_SBGRP ;;
  }
  dimension: cumulative_confirmed_quantity_in_base_uo_m_klmeng {
    type: number
    description: "Cumul.confirmed qty"
    sql: ${TABLE}.CumulativeConfirmedQuantityInBASeUoM_KLMENG ;;
  }
  dimension: cumulative_confirmed_quantity_kbmeng {
    type: number
    description: "Cumul.confirmed qty"
    sql: ${TABLE}.CumulativeConfirmedQuantity_KBMENG ;;
  }
  dimension: cumulative_order_quantity_kwmeng {
    type: number
    description: "Order Quantity"
    sql: ${TABLE}.CumulativeOrderQuantity_KWMENG ;;
  }
  dimension: cumulative_target_delivery_qty_lsmeng {
    type: number
    description: "Required deliv. qty"
    sql: ${TABLE}.CumulativeTargetDeliveryQty_LSMENG ;;
  }
  dimension: currency_hdr_waerk {
    type: string
    description: "Document Currency"
    sql: ${TABLE}.CurrencyHdr_WAERK ;;
  }
  dimension: currency_key_of_credit_control_area_cmwae {
    type: string
    description: "Currency"
    sql: ${TABLE}.CurrencyKeyOfCreditControlArea_CMWAE ;;
  }
  dimension: currency_waerk {
    type: string
    description: "Document Currency"
    sql: ${TABLE}.Currency_WAERK ;;
  }
  dimension: customer_credit_group_grupp {
    type: string
    description: "Cust.cred.group"
    sql: ${TABLE}.CustomerCreditGroup_GRUPP ;;
  }
  dimension: customer_credit_limit_ref_knkli {
    type: string
    description: "Credit account"
    sql: ${TABLE}.CustomerCreditLimitRef_KNKLI ;;
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
  dimension: customer_has_not_posted_goods_receipt_nachl {
    type: string
    description: "No GR posted by cst."
    sql: ${TABLE}.CustomerHasNotPostedGoodsReceipt_NACHL ;;
  }
  dimension: customer_material_number_kdmat {
    type: string
    description: "Customer Material"
    sql: ${TABLE}.CustomerMaterialNumber_KDMAT ;;
  }
  dimension_group: customer_purchase_order_date_bstdk {
    type: time
    description: "Purchase Order Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CustomerPurchaseOrderDate_BSTDK ;;
  }
  dimension: customer_purchase_order_number_bstnk {
    type: string
    description: "Purchase order no."
    sql: ${TABLE}.CustomerPurchaseOrderNumber_BSTNK ;;
  }
  dimension: customer_purchase_order_type_bsark {
    type: string
    description: "Purchase order type"
    sql: ${TABLE}.CustomerPurchaseOrderType_BSARK ;;
  }
  dimension: dangerous_goods_flag_cont_dg {
    type: string
    description: "Contains DG"
    sql: ${TABLE}.DangerousGoodsFlag_CONT_DG ;;
  }
  dimension: dangerous_goods_management_profile_proli {
    type: string
    description: "DG mgmt profile"
    sql: ${TABLE}.DangerousGoodsManagementProfile_PROLI ;;
  }
  dimension_group: date_of_next_credit_check_of_document_cmnup {
    type: time
    description: "Next check"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateOfNextCreditCheckOfDocument_CMNUP ;;
  }
  dimension: day_of_requested_delivery_date_vdatu {
    type: number
    description: "Requested deliv.date"
    sql: ${TABLE}.DayOfRequestedDeliveryDate_VDATU ;;
  }
  dimension: day_of_sales_order_creation_date_erdat {
    type: number
    description: "Created On"
    sql: ${TABLE}.DayOfSalesOrderCreationDate_ERDAT ;;
  }
  dimension: days_by_which_the_quantity_can_be_shifted_kever {
    type: number
    description: "Deviation days"
    sql: ${TABLE}.DaysByWhichTheQuantityCanBeShifted_KEVER ;;
  }
  dimension: delivery_block_lifsk {
    type: string
    description: "Delivery block"
    sql: ${TABLE}.DeliveryBlock_LIFSK ;;
  }
  dimension: delivery_date_and_quantity_fixed_fixmg {
    type: string
    description: "Fixed date and qty"
    sql: ${TABLE}.DeliveryDateAndQuantityFixed_FIXMG ;;
  }
  dimension: delivery_group_grkor {
    type: string
    description: "Delivery group"
    sql: ${TABLE}.DeliveryGroup_GRKOR ;;
  }
  dimension: delivery_priority_lprio {
    type: string
    description: "Delivery Priority"
    sql: ${TABLE}.DeliveryPriority_LPRIO ;;
  }
  dimension: denominator_qty_umvkn {
    type: number
    description: "Denominator"
    sql: ${TABLE}.DenominatorQty_UMVKN ;;
  }
  dimension: distribution_channel_vtweg {
    type: string
    description: "Distribution Channel"
    sql: ${TABLE}.DistributionChannel_VTWEG ;;
  }
  dimension: division_hdr_spart {
    type: string
    description: "Division"
    sql: ${TABLE}.DivisionHdr_SPART ;;
  }
  dimension: division_spart {
    type: string
    description: "Division"
    sql: ${TABLE}.Division_SPART ;;
  }
  dimension: document_category_vbtyp {
    type: string
    description: "SD document categ."
    sql: ${TABLE}.DocumentCategory_VBTYP ;;
  }
  dimension_group: document_date_audat {
    type: time
    description: "Document Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DocumentDate_AUDAT ;;
  }
  dimension: document_indicator_vbklt {
    type: string
    description: "Indicator"
    sql: ${TABLE}.DocumentIndicator_VBKLT ;;
  }
  dimension: document_number_of_the_reference_document_vgbel {
    type: string
    description: "Reference Document"
    sql: ${TABLE}.DocumentNumberOfTheReferenceDocument_VGBEL ;;
  }
  dimension: exchange_rate_for_statistics_stcur {
    type: number
    description: "Exchange rate stats."
    sql: ${TABLE}.ExchangeRateForStatistics_STCUR ;;
  }
  dimension: exchange_rate_type_kurst {
    type: string
    description: "Exchange Rate Type"
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }
  dimension: fixed_shipping_processing_time_in_days_vbeaf {
    type: number
    description: "Fixed process. time"
    sql: ${TABLE}.FixedShippingProcessingTimeInDays_VBEAF ;;
  }
  dimension: form_of_billing_for_co_rkfkf {
    type: string
    description: "Billing meth. CO/PPC"
    sql: ${TABLE}.FormOfBillingForCO_RKFKF ;;
  }
  dimension: form_of_payment_guarantee_abfor {
    type: string
    description: "Paymt guarantee form"
    sql: ${TABLE}.FormOfPaymentGuarantee_ABFOR ;;
  }
  dimension: free_goods_delivery_control_lstanr {
    type: string
    description: "Free goods delivery control"
    sql: ${TABLE}.FreeGoodsDeliveryControl_LSTANR ;;
  }
  dimension: functional_area_fkber {
    type: string
    description: "Functional Area"
    sql: ${TABLE}.FunctionalArea_FKBER ;;
  }
  dimension: fund_fonds {
    type: string
    description: "Fund"
    sql: ${TABLE}.Fund_FONDS ;;
  }
  dimension: funds_center_fistl {
    type: string
    description: "Funds Center"
    sql: ${TABLE}.FundsCenter_FISTL ;;
  }
  dimension: gross_weight_of_item_brgew {
    type: number
    description: "Gross weight"
    sql: ${TABLE}.GrossWeightOfItem_BRGEW ;;
  }
  dimension: guaranteed_factor_abges {
    type: number
    description: "Guaranteed"
    sql: ${TABLE}.GuaranteedFactor_ABGES ;;
  }
  dimension_group: hand_over_date_at_the_hand_over_location_handoverdate {
    type: time
    description: "Handover Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.HandOverDateAtTheHandOverLocation_HANDOVERDATE ;;
  }
  dimension: hand_over_time_at_the_hand_over_location_handovertime {
    type: string
    description: "Handover Time"
    sql: ${TABLE}.HandOverTimeAtTheHandOverLocation_HANDOVERTIME ;;
  }
  dimension: hierarchy_type_for_pricing_hityp_pr {
    type: string
    description: "HierarchyTypePricing"
    sql: ${TABLE}.HierarchyTypeForPricing_HITYP_PR ;;
  }
  dimension: import_export_flag_prefe {
    type: string
    description: "Eligible for pref."
    sql: ${TABLE}.ImportExportFlag_PREFE ;;
  }
  dimension: incentive_id_fiscal_incentive_id {
    type: string
    description: "Incentive ID"
    sql: ${TABLE}.IncentiveID_FISCAL_INCENTIVE_ID ;;
  }
  dimension: inconsistent_configuration_stman {
    type: string
    description: "Inconsistent confign"
    sql: ${TABLE}.InconsistentConfiguration_STMAN ;;
  }
  dimension: internal_class_number_clint {
    type: string
    description: "Internal class no."
    sql: ${TABLE}.InternalClassNumber_CLINT ;;
  }
  dimension: internal_counter_stpoz {
    type: string
    description: "Counter"
    sql: ${TABLE}.InternalCounter_STPOZ ;;
  }
  dimension: internal_object_number_of_the_batch_classification_cuobj_ch {
    type: string
    description: "Internal object no."
    sql: ${TABLE}.InternalObjectNumberOfTheBatchClassification_CUOBJ_CH ;;
  }
  dimension: international_article_number_ean11 {
    type: string
    description: "EAN/UPC"
    sql: ${TABLE}.InternationalArticleNumber_EAN11 ;;
  }
  dimension: international_unique_key_handle {
    type: string
    description: "Int.ID"
    sql: ${TABLE}.InternationalUniqueKey_HANDLE ;;
  }
  dimension: item_category_pstyv {
    type: string
    description: "Item Category"
    sql: ${TABLE}.ItemCategory_PSTYV ;;
  }
  dimension: item_credit_price_cmpre {
    type: number
    description: "Credit price"
    sql: ${TABLE}.ItemCreditPrice_CMPRE ;;
  }
  dimension: item_credit_price_cmpre_flt {
    type: number
    description: "Credit price"
    sql: ${TABLE}.ItemCreditPrice_CMPRE_FLT ;;
  }
  dimension: item_number_of_the_underlying_purchase_order_posex {
    type: string
    description: "Purchase Order Item"
    sql: ${TABLE}.ItemNumberOfTheUnderlyingPurchaseOrder_POSEX ;;
  }
  dimension: item_posnr {
    type: string
    description: "Sales Document Item"
    sql: ${TABLE}.Item_POSNR ;;
  }
  dimension: item_type_posar {
    type: string
    description: "Item type"
    sql: ${TABLE}.ItemType_POSAR ;;
  }
  dimension: kanban_kannr {
    type: string
    description: "Sequence number"
    sql: ${TABLE}.KANBAN_KANNR ;;
  }
  dimension_group: last_changed_on_aedat {
    type: time
    description: "Changed On"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LastChangedOn_AEDAT ;;
  }
  dimension_group: last_customer_contact_date_mahdt {
    type: time
    description: "Last contact date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LastCustomerContactDate_MAHDT ;;
  }
  dimension: leading_uo_m_kzfme {
    type: string
    description: "Leading UoM"
    sql: ${TABLE}.LeadingUoM_KZFME ;;
  }
  dimension: location_for_aphysical_hand_over_of_goods_handoverloc {
    type: string
    description: "Handover Location"
    sql: ${TABLE}.LocationForAPhysicalHandOverOfGoods_HANDOVERLOC ;;
  }
  dimension: managing_location_stockloc {
    type: string
    description: "Location"
    sql: ${TABLE}.ManagingLocation_STOCKLOC ;;
  }
  dimension: manual_tax_code_re_ason_manual_tc_reason {
    type: string
    description: "Manual Tax Code Reason"
    sql: ${TABLE}.ManualTaxCodeReASon_MANUAL_TC_REASON ;;
  }
  dimension: master_contract_number_vbeln_grp {
    type: string
    description: "Master contract"
    sql: ${TABLE}.MasterContractNumber_VBELN_GRP ;;
  }
  dimension: material_entered_matwa {
    type: string
    description: "Material entered"
    sql: ${TABLE}.MaterialEntered_MATWA ;;
  }
  dimension: material_freight_group_mfrgr {
    type: string
    description: "Material freight grp"
    sql: ${TABLE}.MaterialFreightGroup_MFRGR ;;
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
  dimension: material_group_hierarchy1_wgru1 {
    type: string
    description: "Material group 1"
    sql: ${TABLE}.MaterialGroupHierarchy1_WGRU1 ;;
  }
  dimension: material_group_hierarchy2_wgru2 {
    type: string
    description: "Material group 2"
    sql: ${TABLE}.MaterialGroupHierarchy2_WGRU2 ;;
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
  dimension: material_pricing_group_kondm {
    type: string
    description: "Material pricing grp"
    sql: ${TABLE}.MaterialPricingGroup_KONDM ;;
  }
  dimension: material_pricing_group_ukonm {
    type: string
    description: "MnItem MatPricingGrp"
    sql: ${TABLE}.MaterialPricingGroup_UKONM ;;
  }
  dimension: maximum_partial_deliveries_antlf {
    type: number
    description: "Max.Part.Deliveries"
    sql: ${TABLE}.MaximumPartialDeliveries_ANTLF ;;
  }
  dimension: minimum_delivery_quantity_in_delivery_note_processing_lfmng {
    type: number
    description: "Minimum delivery qty"
    sql: ${TABLE}.MinimumDeliveryQuantityInDeliveryNoteProcessing_LFMNG ;;
  }
  dimension: month_of_requested_delivery_date_vdatu {
    type: number
    description: "Requested deliv.date"
    sql: ${TABLE}.MonthOfRequestedDeliveryDate_VDATU ;;
  }
  dimension: month_of_sales_order_creation_date_erdat {
    type: number
    description: "Created On"
    sql: ${TABLE}.MonthOfSalesOrderCreationDate_ERDAT ;;
  }
  dimension: mrparea_berid {
    type: string
    description: "MRP Area"
    sql: ${TABLE}.MRPArea_BERID ;;
  }
  dimension: mrpfor_delivery_schedule_types_abdis {
    type: string
    description: "MRP for DlvSchType"
    sql: ${TABLE}.MRPForDeliveryScheduleTypes_ABDIS ;;
  }
  dimension: name_of_orderer_bname {
    type: string
    description: "Name"
    sql: ${TABLE}.NameOfOrderer_BNAME ;;
  }
  dimension: net_price_netpr {
    type: number
    description: "Net price"
    sql: ${TABLE}.NetPrice_NETPR ;;
  }
  dimension: net_price_netwr {
    type: number
    description: "Net value"
    sql: ${TABLE}.NetPrice_NETWR ;;
  }
  dimension: net_value_of_the_sales_order_in_document_currency_netwr {
    type: number
    description: "Net value"
    sql: ${TABLE}.NetValueOfTheSalesOrderInDocumentCurrency_NETWR ;;
  }
  dimension: net_weight_of_item_ntgew {
    type: number
    description: "Net weight"
    sql: ${TABLE}.NetWeightOfItem_NTGEW ;;
  }
  dimension_group: next_date_cmngv {
    type: time
    description: "Next date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NextDate_CMNGV ;;
  }
  dimension: not_afiscal_special_case_for_cfopdetermination_spcsto {
    type: string
    description: "NF CFOP Special Case"
    sql: ${TABLE}.NotAFiscalSpecialCaseForCFOPDetermination_SPCSTO ;;
  }
  dimension: notification_no_qmnum {
    type: string
    description: "Notification"
    sql: ${TABLE}.NotificationNo_QMNUM ;;
  }
  dimension: number_of_condition_record_knumh {
    type: string
    description: "No.cond.rec. batch"
    sql: ${TABLE}.NumberOfConditionRecord_KNUMH ;;
  }
  dimension: number_of_contacts_from_the_customer_mahza {
    type: number
    description: "Number of contacts"
    sql: ${TABLE}.NumberOfContactsFromTheCustomer_MAHZA ;;
  }
  dimension: number_of_serial_numbers_anzsn {
    type: number
    description: "No.serial numbers"
    sql: ${TABLE}.NumberOfSerialNumbers_ANZSN ;;
  }
  dimension: numerator_qty_umvkz {
    type: number
    description: "Numerator"
    sql: ${TABLE}.NumeratorQty_UMVKZ ;;
  }
  dimension: object_number_at_header_level_objnr {
    type: string
    description: "Object no.header"
    sql: ${TABLE}.ObjectNumberAtHeaderLevel_OBJNR ;;
  }
  dimension: object_number_at_item_level_objnr {
    type: string
    description: "Object no.header"
    sql: ${TABLE}.ObjectNumberAtItemLevel_OBJNR ;;
  }
  dimension: order_number_aufnr {
    type: string
    description: "Order"
    sql: ${TABLE}.OrderNumber_AUFNR ;;
  }
  dimension: order_number_hdr_aufnr {
    type: string
    description: "Order"
    sql: ${TABLE}.OrderNumberHdr_AUFNR ;;
  }
  dimension: order_probability_of_the_item_awahr {
    type: string
    description: "Probability"
    sql: ${TABLE}.OrderProbabilityOfTheItem_AWAHR ;;
  }
  dimension: original_system_vbkla {
    type: string
    description: "Original system"
    sql: ${TABLE}.OriginalSystem_VBKLA ;;
  }
  dimension: originating_document_vbelv {
    type: string
    description: "Originating Document"
    sql: ${TABLE}.OriginatingDocument_VBELV ;;
  }
  dimension: originating_item_posnv {
    type: string
    description: "Item"
    sql: ${TABLE}.OriginatingItem_POSNV ;;
  }
  dimension: over_delivery_tolerance_limit_uebto {
    type: number
    description: "Overdeliv. Tolerance"
    sql: ${TABLE}.OverDeliveryToleranceLimit_UEBTO ;;
  }
  dimension: over_head_key_zschl_k {
    type: string
    description: "Overhead key"
    sql: ${TABLE}.OverHeadKey_ZSCHL_K ;;
  }
  dimension: packaging_materials_magrv {
    type: string
    description: "Matl Grp Pack.Matls"
    sql: ${TABLE}.PackagingMaterials_MAGRV ;;
  }
  dimension: parameter_variant_techs {
    type: string
    description: "Standard Variant"
    sql: ${TABLE}.ParameterVariant_TECHS ;;
  }
  dimension: partial_delivery_at_item_level_kztlf {
    type: string
    description: "Part.Dlv./Item"
    sql: ${TABLE}.PartialDeliveryAtItemLevel_KZTLF ;;
  }
  dimension: planning_material_vpmat {
    type: string
    description: "Planning material"
    sql: ${TABLE}.PlanningMaterial_VPMAT ;;
  }
  dimension: planning_plant_vpwrk {
    type: string
    description: "Planning plant"
    sql: ${TABLE}.PlanningPlant_VPWRK ;;
  }
  dimension: planning_release_regulation_plavo {
    type: string
    description: "PlanDelSchedInstruct"
    sql: ${TABLE}.PlanningReleaseRegulation_PLAVO ;;
  }
  dimension: plant_werks {
    type: string
    description: "Plant"
    sql: ${TABLE}.Plant_WERKS ;;
  }
  dimension: pre_doc_category_vgtyp {
    type: string
    description: "Preceding doc.categ."
    sql: ${TABLE}.PreDocCategory_VGTYP ;;
  }
  dimension: preceding_doc_category_vgtyp {
    type: string
    description: "Preceding doc.categ."
    sql: ${TABLE}.PrecedingDocCategory_VGTYP ;;
  }
  dimension: preceding_document_has_resulted_from_reference_vgref {
    type: string
    description: "Preceding document resulted from ref."
    sql: ${TABLE}.PrecedingDocumentHasResultedFromReference_VGREF ;;
  }
  dimension: pricing_is_ok_prsok {
    type: string
    description: "Pricing"
    sql: ${TABLE}.PricingIsOK_PRSOK ;;
  }
  dimension: pricing_procedure_kalsm {
    type: string
    description: "Pricing procedure"
    sql: ${TABLE}.PricingProcedure_KALSM ;;
  }
  dimension: pricing_reference_material_pmatn {
    type: string
    description: "Pricing Ref. Matl"
    sql: ${TABLE}.PricingReferenceMaterial_PMATN ;;
  }
  dimension: pricing_reference_material_upmat {
    type: string
    description: "MnItm PrcRefMatl"
    sql: ${TABLE}.PricingReferenceMaterial_UPMAT ;;
  }
  dimension: product_allocation_kosch {
    type: string
    description: "Product allocation"
    sql: ${TABLE}.ProductAllocation_KOSCH ;;
  }
  dimension: product_hierarchy_prodh {
    type: string
    description: "Product Hierarchy"
    sql: ${TABLE}.ProductHierarchy_PRODH ;;
  }
  dimension: profit_center_for_billing_pctrf {
    type: string
    description: "Profit Center Billing"
    sql: ${TABLE}.ProfitCenterForBilling_PCTRF ;;
  }
  dimension: profit_center_prctr {
    type: string
    description: "Profit Center"
    sql: ${TABLE}.ProfitCenter_PRCTR ;;
  }
  dimension: profitability_segment_number_paobjnr {
    type: string
    description: "Profitab. Segmt No."
    sql: ${TABLE}.ProfitabilitySegmentNumber_PAOBJNR ;;
  }
  dimension: promotion_knuma_pi {
    type: string
    description: "Promotion"
    sql: ${TABLE}.Promotion_KNUMA_PI ;;
  }
  dimension: proposed_billing_type_fkara {
    type: string
    description: "Order-rel.bill.type"
    sql: ${TABLE}.ProposedBillingType_FKARA ;;
  }
  dimension: proposed_date_type_vprgr {
    type: string
    description: "Prop.date type"
    sql: ${TABLE}.ProposedDateType_VPRGR ;;
  }
  dimension: purchase_order_number_supplement_bstzd {
    type: string
    description: "Supplement"
    sql: ${TABLE}.PurchaseOrderNumberSupplement_BSTZD ;;
  }
  dimension: quantity_is_fixed_fmeng {
    type: string
    description: "Quantity is fixed"
    sql: ${TABLE}.QuantityIsFixed_FMENG ;;
  }
  dimension: quarter_of_requested_delivery_date_vdatu {
    type: number
    description: "Requested deliv.date"
    sql: ${TABLE}.QuarterOfRequestedDeliveryDate_VDATU ;;
  }
  dimension: quarter_of_sales_order_creation_date_erdat {
    type: number
    description: "Created On"
    sql: ${TABLE}.QuarterOfSalesOrderCreationDate_ERDAT ;;
  }
  dimension_group: quotation_date_from_angdt {
    type: time
    description: "Quotation valid from"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.QuotationDateFrom_ANGDT ;;
  }
  dimension_group: quotation_date_to_bnddt {
    type: time
    description: "Quotation valid to"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.QuotationDateTo_BNDDT ;;
  }
  dimension: reason_augru {
    type: string
    description: "Order reason"
    sql: ${TABLE}.Reason_AUGRU ;;
  }
  dimension: reason_for_material_substitution_sugrd {
    type: string
    description: "Substitution Reason"
    sql: ${TABLE}.ReasonForMaterialSubstitution_SUGRD ;;
  }
  dimension_group: reconciliation_date_abdat {
    type: time
    description: "Reconciliation date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ReconciliationDate_ABDAT ;;
  }
  dimension: reference_document_number_xblnr {
    type: string
    description: "Reference"
    sql: ${TABLE}.ReferenceDocumentNumber_XBLNR ;;
  }
  dimension: reference_document_vgbel {
    type: string
    description: "Reference Document"
    sql: ${TABLE}.ReferenceDocument_VGBEL ;;
  }
  dimension: reference_indicator_voref {
    type: string
    description: "Complete reference"
    sql: ${TABLE}.ReferenceIndicator_VOREF ;;
  }
  dimension: reference_item_vgpos {
    type: string
    description: "Reference Item"
    sql: ${TABLE}.ReferenceItem_VGPOS ;;
  }
  dimension: rejection_reason_abgru {
    type: string
    description: "Reason for rejection"
    sql: ${TABLE}.RejectionReason_ABGRU ;;
  }
  dimension_group: rele_ase_date_of_the_document_determined_by_credit_management_cmfre {
    type: time
    description: "Release date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ReleASeDateOfTheDocumentDeterminedByCreditManagement_CMFRE ;;
  }
  dimension: released_credit_value_of_the_document_amtbl {
    type: number
    description: "Rel. credit value"
    sql: ${TABLE}.ReleasedCreditValueOfTheDocument_AMTBL ;;
  }
  dimension: relevant_for_billing_fkrel {
    type: string
    description: "Relevant for Billing"
    sql: ${TABLE}.RelevantForBilling_FKREL ;;
  }
  dimension: relevant_for_credit_cmpnt {
    type: string
    description: "Credit funct. active"
    sql: ${TABLE}.RelevantForCredit_CMPNT ;;
  }
  dimension: relevant_for_delivery_lfrel {
    type: string
    description: "Itm relev.for deliv."
    sql: ${TABLE}.RelevantForDelivery_LFREL ;;
  }
  dimension: repair_processing_vkgru {
    type: string
    description: "Repair: Classification of Items"
    sql: ${TABLE}.RepairProcessing_VKGRU ;;
  }
  dimension: replacement_part_atpkz {
    type: string
    description: "Replacement part"
    sql: ${TABLE}.ReplacementPart_ATPKZ ;;
  }
  dimension_group: requested_delivery_date_vdatu {
    type: time
    description: "Requested deliv.date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RequestedDeliveryDate_VDATU ;;
  }
  dimension: requirements_type_bedae {
    type: string
    description: "Requirements type"
    sql: ${TABLE}.RequirementsType_BEDAE ;;
  }
  dimension: results_analysis_key_abgrs {
    type: string
    description: "Results analysis key"
    sql: ${TABLE}.ResultsAnalysisKey_ABGRS ;;
  }
  dimension: return_reason_msr_ret_reason {
    type: string
    description: "Return Reason"
    sql: ${TABLE}.ReturnReason_MSR_RET_REASON ;;
  }
  dimension: returns_item_shkzg {
    type: string
    description: "Returns"
    sql: ${TABLE}.ReturnsItem_SHKZG ;;
  }
  dimension: returns_refund_code_msr_refund_code {
    type: string
    description: "Refund Code"
    sql: ${TABLE}.ReturnsRefundCode_MSR_REFUND_CODE ;;
  }
  dimension: risk_category_ctlpc {
    type: string
    description: "Risk category"
    sql: ${TABLE}.RiskCategory_CTLPC ;;
  }
  dimension: risk_relevancy_in_sales_trmrisk_relevant {
    type: string
    description: "Risk Relevancy"
    sql: ${TABLE}.RiskRelevancyInSales_TRMRISK_RELEVANT ;;
  }
  dimension: rounding_quantity_for_delivery_ablfz {
    type: number
    description: "Rounding qty"
    sql: ${TABLE}.RoundingQuantityForDelivery_ABLFZ ;;
  }
  dimension: route_route {
    type: string
    description: "Route"
    sql: ${TABLE}.Route_ROUTE ;;
  }
  dimension: sales_deal_knuma_ag {
    type: string
    description: "Sales deal"
    sql: ${TABLE}.SalesDeal_KNUMA_AG ;;
  }
  dimension: sales_document_type_auart {
    type: string
    description: "Sales Document Type"
    sql: ${TABLE}.SalesDocumentType_AUART ;;
  }
  dimension: sales_document_vbeln {
    type: string
    description: "Sales Document"
    sql: ${TABLE}.SalesDocument_VBELN ;;
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
  dimension: sales_order_value_line_item_source_currency {
    type: number
    description: "Sales Order Value Line Item Source Currency"
    sql: ${TABLE}.SalesOrderValueLineItemSourceCurrency ;;
  }
  dimension: sales_organization_vkorg {
    type: string
    description: "Sales Organization"
    sql: ${TABLE}.SalesOrganization_VKORG ;;
  }
  dimension: sales_probability_awahr {
    type: string
    description: "Probability"
    sql: ${TABLE}.SalesProbability_AWAHR ;;
  }
  dimension: sales_unit_vrkme {
    type: string
    description: "Sales Unit"
    sql: ${TABLE}.SalesUnit_VRKME ;;
  }
  dimension: scale_quantity_smeng {
    type: number
    description: "Scale quantity"
    sql: ${TABLE}.ScaleQuantity_SMENG ;;
  }
  dimension: search_term_for_product_proposal_ktext {
    type: string
    description: "Description"
    sql: ${TABLE}.SearchTermForProductProposal_KTEXT ;;
  }
  dimension: separate_valuation_bwtex {
    type: string
    description: "Separate valuation"
    sql: ${TABLE}.SeparateValuation_BWTEX ;;
  }
  dimension: serial_number_profile_serail {
    type: string
    description: "Serial no. profile"
    sql: ${TABLE}.SerialNumberProfile_SERAIL ;;
  }
  dimension: shipping_conditions_vsbed {
    type: string
    description: "Shipping Conditions"
    sql: ${TABLE}.ShippingConditions_VSBED ;;
  }
  dimension: shipping_receiving_point_vstel {
    type: string
    description: "Shipping Point/Receiving Pt"
    sql: ${TABLE}.ShippingReceivingPoint_VSTEL ;;
  }
  dimension: short_text_arktx {
    type: string
    description: "Description"
    sql: ${TABLE}.ShortText_ARKTX ;;
  }
  dimension: sold_to_party_kunnr {
    type: string
    description: "Sold-To Party"
    sql: ${TABLE}.SoldToParty_KUNNR ;;
  }
  dimension: special_stock_indicator_sobkz {
    type: string
    description: "Special Stock"
    sql: ${TABLE}.SpecialStockIndicator_SOBKZ ;;
  }
  dimension: statistic_scurrency_stwae {
    type: string
    description: "Statistics currency"
    sql: ${TABLE}.StatisticScurrency_STWAE ;;
  }
  dimension: statistical_values_kowrr {
    type: string
    description: "Statistical value"
    sql: ${TABLE}.StatisticalValues_KOWRR ;;
  }
  dimension_group: statistics_date_stadat {
    type: time
    description: "Statistics date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.StatisticsDate_STADAT ;;
  }
  dimension: status_expected_price_cepok {
    type: string
    description: "Expected price"
    sql: ${TABLE}.StatusExpectedPrice_CEPOK ;;
  }
  dimension: status_manual_price_change_mprok {
    type: string
    description: "Manual price"
    sql: ${TABLE}.StatusManualPriceChange_MPROK ;;
  }
  dimension: storage_location_lgort {
    type: string
    description: "Storage Location"
    sql: ${TABLE}.StorageLocation_LGORT ;;
  }
  dimension: sub_total1_from_pricing_procedure_for_condition_kzwi1 {
    type: number
    description: "Subtotal 1"
    sql: ${TABLE}.SubTotal1FromPricingProcedureForCondition_KZWI1 ;;
  }
  dimension: sub_total2_from_pricing_procedure_for_condition_kzwi2 {
    type: number
    description: "Subtotal 2"
    sql: ${TABLE}.SubTotal2FromPricingProcedureForCondition_KZWI2 ;;
  }
  dimension: sub_total3_from_pricing_procedure_for_condition_kzwi3 {
    type: number
    description: "Subtotal 3"
    sql: ${TABLE}.SubTotal3FromPricingProcedureForCondition_KZWI3 ;;
  }
  dimension: sub_total4_from_pricing_procedure_for_condition_kzwi4 {
    type: number
    description: "Subtotal 4"
    sql: ${TABLE}.SubTotal4FromPricingProcedureForCondition_KZWI4 ;;
  }
  dimension: sub_total5_from_pricing_procedure_for_condition_kzwi5 {
    type: number
    description: "Subtotal 5"
    sql: ${TABLE}.SubTotal5FromPricingProcedureForCondition_KZWI5 ;;
  }
  dimension: sub_total6_from_pricing_procedure_for_condition_kzwi6 {
    type: number
    description: "Subtotal 6"
    sql: ${TABLE}.SubTotal6FromPricingProcedureForCondition_KZWI6 ;;
  }
  dimension: summing_up_of_requirements_sumbd {
    type: string
    description: "Requirements totals"
    sql: ${TABLE}.SummingUpOfRequirements_SUMBD ;;
  }
  dimension: target_quantity_uo_m_zieme {
    type: string
    description: "Target quantity UoM"
    sql: ${TABLE}.TargetQuantityUoM_ZIEME ;;
  }
  dimension: target_quantity_uo_m_zmeng {
    type: number
    description: "Target quantity"
    sql: ${TABLE}.TargetQuantityUoM_ZMENG ;;
  }
  dimension: target_value_zwert {
    type: number
    description: "OA Target Value"
    sql: ${TABLE}.TargetValue_ZWERT ;;
  }
  dimension: tax_amount_in_document_currency_mwsbp {
    type: number
    description: "Tax amount"
    sql: ${TABLE}.TaxAmountInDocumentCurrency_MWSBP ;;
  }
  dimension: tax_classification1_taxm1 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification1_TAXM1 ;;
  }
  dimension: tax_classification2_taxk2 {
    type: string
    description: "TaxClass2-Cust."
    sql: ${TABLE}.TaxClassification2_TAXK2 ;;
  }
  dimension: tax_classification2_taxm2 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification2_TAXM2 ;;
  }
  dimension: tax_classification3_taxk3 {
    type: string
    description: "TaxClass3-Cust."
    sql: ${TABLE}.TaxClassification3_TAXK3 ;;
  }
  dimension: tax_classification3_taxm3 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification3_TAXM3 ;;
  }
  dimension: tax_classification4_taxk4 {
    type: string
    description: "TaxClass4-Cust."
    sql: ${TABLE}.TaxClassification4_TAXK4 ;;
  }
  dimension: tax_classification4_taxm4 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification4_TAXM4 ;;
  }
  dimension: tax_classification5_taxk5 {
    type: string
    description: "TaxClass5-Cust."
    sql: ${TABLE}.TaxClassification5_TAXK5 ;;
  }
  dimension: tax_classification5_taxm5 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification5_TAXM5 ;;
  }
  dimension: tax_classification6_taxk6 {
    type: string
    description: "TaxClass6-Cust."
    sql: ${TABLE}.TaxClassification6_TAXK6 ;;
  }
  dimension: tax_classification6_taxm6 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification6_TAXM6 ;;
  }
  dimension: tax_classification7_taxk7 {
    type: string
    description: "TaxClass7-Cust."
    sql: ${TABLE}.TaxClassification7_TAXK7 ;;
  }
  dimension: tax_classification7_taxm7 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification7_TAXM7 ;;
  }
  dimension: tax_classification8_taxk8 {
    type: string
    description: "TaxClass8-Cust."
    sql: ${TABLE}.TaxClassification8_TAXK8 ;;
  }
  dimension: tax_classification8_taxm8 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification8_TAXM8 ;;
  }
  dimension: tax_classification9_taxk9 {
    type: string
    description: "TaxClass9-Cust."
    sql: ${TABLE}.TaxClassification9_TAXK9 ;;
  }
  dimension: tax_classification9_taxm9 {
    type: string
    description: "Tax classification"
    sql: ${TABLE}.TaxClassification9_TAXM9 ;;
  }
  dimension: tax_code_automatically_determined_tc_aut_det {
    type: string
    description: "Tax Code Automatically Determined"
    sql: ${TABLE}.TaxCodeAutomaticallyDetermined_TC_AUT_DET ;;
  }
  dimension: tax_departure_country_landtx {
    type: string
    description: "Tax depart. country"
    sql: ${TABLE}.TaxDepartureCountry_LANDTX ;;
  }
  dimension: tax_destination_country_stceg_l {
    type: string
    description: "Tax dest. country"
    sql: ${TABLE}.TaxDestinationCountry_STCEG_L ;;
  }
  dimension: tax_incentive_type_fiscal_incentive {
    type: string
    description: "Tax Incentive Type"
    sql: ${TABLE}.TaxIncentiveType_FISCAL_INCENTIVE ;;
  }
  dimension: telephone_number_telf1 {
    type: string
    description: "Telephone"
    sql: ${TABLE}.TelephoneNumber_TELF1 ;;
  }
  dimension: transaction_group_trvog {
    type: string
    description: "Transaction group"
    sql: ${TABLE}.TransactionGroup_TRVOG ;;
  }
  dimension: type_of_first_inventory_sloctype {
    type: string
    description: "Location Type"
    sql: ${TABLE}.TypeOfFirstInventory_SLOCTYPE ;;
  }
  dimension: under_delivery_tolerance_limit_untto {
    type: number
    description: "Underdel. Tolerance"
    sql: ${TABLE}.UnderDeliveryToleranceLimit_UNTTO ;;
  }
  dimension: unlimited_over_delivery_allowed_uebtk {
    type: string
    description: "Unlimited tolerance"
    sql: ${TABLE}.UnlimitedOverDeliveryAllowed_UEBTK ;;
  }
  dimension: update_group_for_statistics_stafo {
    type: string
    description: "Update group (stats)"
    sql: ${TABLE}.UpdateGroupForStatistics_STAFO ;;
  }
  dimension: update_group_for_statistics_update_stafo {
    type: string
    description: "Update group (stats)"
    sql: ${TABLE}.UpdateGroupForStatisticsUpdate_STAFO ;;
  }
  dimension: update_indicator_upflu {
    type: string
    description: "Update document flow"
    sql: ${TABLE}.UpdateIndicator_UPFLU ;;
  }
  dimension: usage_indicator_abrvw {
    type: string
    description: "Usage"
    sql: ${TABLE}.UsageIndicator_ABRVW ;;
  }
  dimension: usage_indicator_vkaus {
    type: string
    description: "Usage"
    sql: ${TABLE}.UsageIndicator_VKAUS ;;
  }
  dimension: utctime_stamp_l_upd_tmstmp {
    type: number
    description: "Time Stamp"
    sql: ${TABLE}.UTCTimeStampL_UPD_TMSTMP ;;
  }
  dimension: valuation_type_bwtar {
    type: string
    description: "Valuation Type"
    sql: ${TABLE}.ValuationType_BWTAR ;;
  }
  dimension: valuationof_special_stock_kzbws {
    type: string
    description: "Spec. stk valuation"
    sql: ${TABLE}.ValuationofSpecialStock_KZBWS ;;
  }
  dimension: value_contract_item_wktps {
    type: string
    description: "Value contract item"
    sql: ${TABLE}.ValueContractItem_WKTPS ;;
  }
  dimension: value_contract_no_wktnr {
    type: string
    description: "Value contract no."
    sql: ${TABLE}.ValueContractNo_WKTNR ;;
  }
  dimension: variable_shipping_processing_time_in_days_vbeav {
    type: number
    description: "Var. processing time"
    sql: ${TABLE}.VariableShippingProcessingTimeInDays_VBEAV ;;
  }
  dimension: volume_of_the_item_volum {
    type: number
    description: "Volume"
    sql: ${TABLE}.VolumeOfTheItem_VOLUM ;;
  }
  dimension: volume_rebate_group_bonus {
    type: string
    description: "Volume rebate group"
    sql: ${TABLE}.VolumeRebateGroup_BONUS ;;
  }
  dimension: volume_unit_voleh {
    type: string
    description: "Volume Unit"
    sql: ${TABLE}.VolumeUnit_VOLEH ;;
  }
  dimension_group: warranty_date_gwldt {
    type: time
    description: "Warranty"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WarrantyDate_GWLDT ;;
  }
  dimension: wbselement_hdr_ps_psp_pnr {
    type: string
    description: "WBS Element"
    sql: ${TABLE}.WBSElementHdr_PS_PSP_PNR ;;
  }
  dimension: wbselement_ps_psp_pnr {
    type: string
    description: "WBS Element"
    sql: ${TABLE}.WBSElement_PS_PSP_PNR ;;
  }
  dimension: week_of_requested_delivery_date_vdatu {
    type: number
    description: "Requested deliv.date"
    sql: ${TABLE}.WeekOfRequestedDeliveryDate_VDATU ;;
  }
  dimension: week_of_sales_order_creation_date_erdat {
    type: number
    description: "Created On"
    sql: ${TABLE}.WeekOfSalesOrderCreationDate_ERDAT ;;
  }
  dimension: weight_unit_gewei {
    type: string
    description: "Weight Unit"
    sql: ${TABLE}.WeightUnit_GEWEI ;;
  }
  dimension: year_of_requested_delivery_date_vdatu {
    type: number
    description: "Requested deliv.date"
    sql: ${TABLE}.YearOfRequestedDeliveryDate_VDATU ;;
  }
  dimension: year_of_sales_order_creation_date_erdat {
    type: number
    description: "Created On"
    sql: ${TABLE}.YearOfSalesOrderCreationDate_ERDAT ;;
  }
  dimension: your_reference_ihrez {
    type: string
    description: "Your Reference"
    sql: ${TABLE}.YourReference_IHREZ ;;
  }
  measure: count {
    type: count
    drill_fields: [name_of_orderer_bname]
  }
}