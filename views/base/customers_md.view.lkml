view: customers_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CustomersMD` ;;

  dimension: account_number_fiscal_address_fiskn {
    type: string
    description: "Fiscal address"
    sql: ${TABLE}.AccountNumberFiscalAddress_FISKN ;;
  }
  dimension: account_number_of_vendor_or_creditor_lifnr {
    type: string
    description: "Vendor"
    sql: ${TABLE}.AccountNumberOfVendorOrCreditor_LIFNR ;;
  }
  dimension: addr_name1 {
    type: string
    description: "Name"
    sql: ${TABLE}.Addr_NAME1 ;;
  }
  dimension: addr_name2 {
    type: string
    description: "Name 2"
    sql: ${TABLE}.Addr_NAME2 ;;
  }
  dimension: addr_name3 {
    type: string
    description: "Name 3"
    sql: ${TABLE}.Addr_NAME3 ;;
  }
  dimension: addr_name4 {
    type: string
    description: "Name 4"
    sql: ${TABLE}.Addr_NAME4 ;;
  }
  dimension: address_adrnr {
    type: string
    description: "Address"
    sql: ${TABLE}.Address_ADRNR ;;
  }
  dimension: address_group_key_business_address_services_addr_group {
    type: string
    description: "Address group"
    sql: ${TABLE}.AddressGroup_Key_BusinessAddressServices_ADDR_GROUP ;;
  }
  dimension: agency_location_code_alc {
    type: string
    description: "Agency Location Code"
    sql: ${TABLE}.AgencyLocationCode_ALC ;;
  }
  dimension: alternative_payer_allowed_xzemp {
    type: string
    description: "Alt.payer in doc?"
    sql: ${TABLE}.AlternativePayerAllowed_XZEMP ;;
  }
  dimension: alternative_payer_knrza {
    type: string
    description: "Alternative payer"
    sql: ${TABLE}.AlternativePayer_KNRZA ;;
  }
  dimension: alternative_payer_using_account_number_xknza {
    type: string
    description: "Accts for alt. payer"
    sql: ${TABLE}.AlternativePayerUsingAccountNumber_XKNZA ;;
  }
  dimension: annual_sales_umsa1 {
    type: number
    description: "Annual sales"
    sql: ${TABLE}.AnnualSales_UMSA1 ;;
  }
  dimension: annual_sales_umsat {
    type: number
    description: "Annual sales"
    sql: ${TABLE}.AnnualSales_UMSAT ;;
  }
  dimension: assignment_to_hierarchy_hzuor {
    type: string
    description: "Hierarchy assignment"
    sql: ${TABLE}.AssignmentToHierarchy_HZUOR ;;
  }
  dimension: attribute10_katr10 {
    type: string
    description: "Attribute 10"
    sql: ${TABLE}.Attribute10_KATR10 ;;
  }
  dimension: attribute1_katr1 {
    type: string
    description: "Attribute 1"
    sql: ${TABLE}.Attribute1_KATR1 ;;
  }
  dimension: attribute2_katr2 {
    type: string
    description: "Attribute 2"
    sql: ${TABLE}.Attribute2_KATR2 ;;
  }
  dimension: attribute3_katr3 {
    type: string
    description: "Attribute 3"
    sql: ${TABLE}.Attribute3_KATR3 ;;
  }
  dimension: attribute4_katr4 {
    type: string
    description: "Attribute 4"
    sql: ${TABLE}.Attribute4_KATR4 ;;
  }
  dimension: attribute5_katr5 {
    type: string
    description: "Attribute 5"
    sql: ${TABLE}.Attribute5_KATR5 ;;
  }
  dimension: attribute6_katr6 {
    type: string
    description: "Attribute 6"
    sql: ${TABLE}.Attribute6_KATR6 ;;
  }
  dimension: attribute7_katr7 {
    type: string
    description: "Attribute 7"
    sql: ${TABLE}.Attribute7_KATR7 ;;
  }
  dimension: attribute8_katr8 {
    type: string
    description: "Attribute 8"
    sql: ${TABLE}.Attribute8_KATR8 ;;
  }
  dimension: attribute9_katr9 {
    type: string
    description: "Attribute 9"
    sql: ${TABLE}.Attribute9_KATR9 ;;
  }
  dimension: authorization_group_begru {
    type: string
    description: "Authorization Group"
    sql: ${TABLE}.AuthorizationGroup_BEGRU ;;
  }
  dimension: building_number_or_code_building {
    type: string
    description: "Building Code"
    sql: ${TABLE}.Building_NumberOrCode_BUILDING ;;
  }
  dimension: business_purpose_completed_flag_cvp_xblck {
    type: string
    description: "Business Purpose Completed Flag"
    sql: ${TABLE}.BusinessPurposeCompletedFlag_CVP_XBLCK ;;
  }
  dimension: business_purpose_completed_flag_xpcpt {
    type: string
    description: "Business Purpose Completed Flag"
    sql: ${TABLE}.BusinessPurposeCompletedFlag_XPCPT ;;
  }
  dimension: central_billing_block_faksd {
    type: string
    description: "Central billing block"
    sql: ${TABLE}.CentralBillingBlock_FAKSD ;;
  }
  dimension: central_deletion_block_for_master_record_nodel {
    type: string
    description: "Central del.block"
    sql: ${TABLE}.CentralDeletionBlockForMasterRecord_NODEL ;;
  }
  dimension: central_deletion_flag_for_master_record_loevm {
    type: string
    description: "Central deletion flag"
    sql: ${TABLE}.CentralDeletionFlagForMasterRecord_LOEVM ;;
  }
  dimension: central_delivery_block_for_the_customer_lifsd {
    type: string
    description: "Central delivery block"
    sql: ${TABLE}.CentralDeliveryBlockForTheCustomer_LIFSD ;;
  }
  dimension: central_order_block_for_customer_aufsd {
    type: string
    description: "Central order block"
    sql: ${TABLE}.CentralOrderBlockForCustomer_AUFSD ;;
  }
  dimension: central_posting_block_sperr {
    type: string
    description: "Central posting block"
    sql: ${TABLE}.CentralPostingBlock_SPERR ;;
  }
  dimension: central_sales_block_cassd {
    type: string
    description: "Central sales block"
    sql: ${TABLE}.CentralSalesBlock_CASSD ;;
  }
  dimension: check_digit_for_the_international_location_number_bubkz {
    type: string
    description: "Check digit"
    sql: ${TABLE}.CheckDigitForTheInternationalLocationNumber_BUBKZ ;;
  }
  dimension: city_city1 {
    type: string
    description: "City"
    sql: ${TABLE}.City_CITY1 ;;
  }
  dimension: city_code_cityc {
    type: string
    description: "City code"
    sql: ${TABLE}.CityCode_CITYC ;;
  }
  dimension: city_code_for_citystreet_file_city_code {
    type: string
    description: "City Code"
    sql: ${TABLE}.CityCodeForCitystreetFile_CITY_CODE ;;
  }
  dimension: city_coordinates_locco {
    type: string
    description: "Location code"
    sql: ${TABLE}.CityCoordinates_LOCCO ;;
  }
  dimension: city_home_city {
    type: string
    description: "Different City"
    sql: ${TABLE}.City_HOME_CITY ;;
  }
  dimension: city_ort01 {
    type: string
    description: "City"
    sql: ${TABLE}.City_ORT01 ;;
  }
  dimension: city_po_box_code_city_file_city_code2 {
    type: string
    description: "City Code"
    sql: ${TABLE}.CityPoBoxCode_CityFile_CITY_CODE2 ;;
  }
  dimension: city_postal_code_post_code1 {
    type: string
    description: "Postal Code"
    sql: ${TABLE}.CityPostalCode_POST_CODE1 ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: cnae_cnae {
    type: string
    description: "CNAE"
    sql: ${TABLE}.Cnae_CNAE ;;
  }
  dimension: company_id_of_trading_partner_vbund {
    type: string
    description: "Trading partner"
    sql: ${TABLE}.CompanyIdOfTradingPartner_VBUND ;;
  }
  dimension: company_postal_code_post_code3 {
    type: string
    description: "Company Postal Code"
    sql: ${TABLE}.CompanyPostalCode_POST_CODE3 ;;
  }
  dimension: company_size_comsize {
    type: string
    description: "Company Size"
    sql: ${TABLE}.CompanySize_COMSIZE ;;
  }
  dimension: competitor_dear1 {
    type: string
    description: "Competitors"
    sql: ${TABLE}.Competitor_DEAR1 ;;
  }
  dimension: condition_group1_kdkg1 {
    type: string
    description: "Condition group 1"
    sql: ${TABLE}.ConditionGroup1_KDKG1 ;;
  }
  dimension: condition_group2_kdkg2 {
    type: string
    description: "Condition group 2"
    sql: ${TABLE}.ConditionGroup2_KDKG2 ;;
  }
  dimension: condition_group3_kdkg3 {
    type: string
    description: "Condition group 3"
    sql: ${TABLE}.ConditionGroup3_KDKG3 ;;
  }
  dimension: condition_group4_kdkg4 {
    type: string
    description: "Condition group 4"
    sql: ${TABLE}.ConditionGroup4_KDKG4 ;;
  }
  dimension: condition_group5_kdkg5 {
    type: string
    description: "Condition group 5"
    sql: ${TABLE}.ConditionGroup5_KDKG5 ;;
  }
  dimension: country_key_country {
    type: string
    description: "Country Key"
    sql: ${TABLE}.CountryKey_COUNTRY ;;
  }
  dimension: country_key_land1 {
    type: string
    description: "Country"
    sql: ${TABLE}.CountryKey_LAND1 ;;
  }
  dimension: county_code_counc {
    type: string
    description: "County code"
    sql: ${TABLE}.CountyCode_COUNC ;;
  }
  dimension: county_code_for_county_county_code {
    type: string
    description: "County code"
    sql: ${TABLE}.CountyCodeForCounty_COUNTY_CODE ;;
  }
  dimension: county_county {
    type: string
    description: "County"
    sql: ${TABLE}.County_COUNTY ;;
  }
  dimension: county_name_in_upper_case_for_search_help_mc_county {
    type: string
    description: "County"
    sql: ${TABLE}.CountyNameInUpperCaseForSearchHelp_MC_COUNTY ;;
  }
  dimension: created_by_ernam {
    type: string
    description: "Created by"
    sql: ${TABLE}.CreatedBy_ERNAM ;;
  }
  dimension: crt_number_crtn {
    type: string
    description: "CRT Number"
    sql: ${TABLE}.CrtNumber_CRTN ;;
  }
  dimension: currency_of_sales_figure_uwaer {
    type: string
    description: "Currency of sales"
    sql: ${TABLE}.CurrencyOfSalesFigure_UWAER ;;
  }
  dimension: customer_account_group_ktokd {
    type: string
    description: "Account group"
    sql: ${TABLE}.CustomerAccountGroup_KTOKD ;;
  }
  dimension: customer_cfop_category_cfopc {
    type: string
    description: "Cust. CFOP category"
    sql: ${TABLE}.CustomerCfopCategory_CFOPC ;;
  }
  dimension: customer_classification_kukla {
    type: string
    description: "Customer Classific."
    sql: ${TABLE}.CustomerClassification_KUKLA ;;
  }
  dimension: customer_group_for_substituicao_tributaria_calculation_xsubt {
    type: string
    description: "SubTrib group"
    sql: ${TABLE}.CustomerGroupForSubstituicaoTributariaCalculation_XSUBT ;;
  }
  dimension: customer_is_icms_exempt_xicms {
    type: string
    description: "ICMS-exempt"
    sql: ${TABLE}.CustomerIsIcmsExempt_XICMS ;;
  }
  dimension: customer_is_ipi_exempt_xxipi {
    type: string
    description: "IPI-exempt"
    sql: ${TABLE}.CustomerIsIpiExempt_XXIPI ;;
  }
  dimension: customer_number_kunnr {
    type: string
    description: "Customer"
    sql: ${TABLE}.CustomerNumber_KUNNR ;;
  }
  dimension: customer_region_regio {
    type: string
    description: "Region"
    sql: ${TABLE}.CustomerRegion_REGIO ;;
  }
  dimension: customer_type4_dear4 {
    type: string
    description: "Customer type 4"
    sql: ${TABLE}.CustomerType4_DEAR4 ;;
  }
  dimension: data_communication_line_no_datlt {
    type: string
    description: "Data line"
    sql: ${TABLE}.DataCommunicationLineNo_DATLT ;;
  }
  dimension_group: date_created_erdat {
    type: time
    description: "Created on"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateCreated_ERDAT ;;
  }
  dimension_group: date_on_which_the_changes_were_confirmed_updat {
    type: time
    description: "Confirmation date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateOnWhichTheChangesWereConfirmed_UPDAT ;;
  }
  dimension: declaration_regimen_for_piscofins_decregpc {
    type: string
    description: "Declaration Regimen for PIS/COFINS"
    sql: ${TABLE}.DeclarationRegimenForPiscofins_DECREGPC ;;
  }
  dimension: description_psoo1 {
    type: string
    description: "Description"
    sql: ${TABLE}.Description_PSOO1 ;;
  }
  dimension: description_psoo2 {
    type: string
    description: "Description"
    sql: ${TABLE}.Description_PSOO2 ;;
  }
  dimension: description_psoo3 {
    type: string
    description: "Description"
    sql: ${TABLE}.Description_PSOO3 ;;
  }
  dimension: description_psoo4 {
    type: string
    description: "Description"
    sql: ${TABLE}.Description_PSOO4 ;;
  }
  dimension: description_psoo5 {
    type: string
    description: "Description"
    sql: ${TABLE}.Description_PSOO5 ;;
  }
  dimension: different_city_for_citystreet_file_cityh_code {
    type: string
    description: "City Code"
    sql: ${TABLE}.DifferentCityForCitystreetFile_CITYH_CODE ;;
  }
  dimension: district_city2 {
    type: string
    description: "District"
    sql: ${TABLE}.District_CITY2 ;;
  }
  dimension: district_code_for_city_and_street_file_cityp_code {
    type: string
    description: "District"
    sql: ${TABLE}.DistrictCodeForCityAndStreetFile_CITYP_CODE ;;
  }
  dimension: district_ort02 {
    type: string
    description: "District"
    sql: ${TABLE}.District_ORT02 ;;
  }
  dimension: duns4_duns4 {
    type: string
    description: "DUNS+4"
    sql: ${TABLE}.Duns4_DUNS4 ;;
  }
  dimension: duns_number_duns {
    type: string
    description: "DUNS Number"
    sql: ${TABLE}.DunsNumber_DUNS ;;
  }
  dimension: express_train_station_bahne {
    type: string
    description: "Express station"
    sql: ${TABLE}.ExpressTrainStation_BAHNE ;;
  }
  dimension: fax_number_telfx {
    type: string
    description: "Fax Number"
    sql: ${TABLE}.FaxNumber_TELFX ;;
  }
  dimension: fee_schedule_fee_schedule {
    type: string
    description: "Fee Schedule"
    sql: ${TABLE}.FeeSchedule_FEE_SCHEDULE ;;
  }
  dimension: first_name_psovn {
    type: string
    description: "First Name"
    sql: ${TABLE}.FirstName_PSOVN ;;
  }
  dimension: first_telephone_no_dialling_codenumber_tel_number {
    type: string
    description: "Telephone"
    sql: ${TABLE}.FirstTelephoneNo_DiallingCodenumber_TEL_NUMBER ;;
  }
  dimension: first_telephone_no_extension_tel_extens {
    type: string
    description: "Extension"
    sql: ${TABLE}.FirstTelephoneNo_Extension_TEL_EXTENS ;;
  }
  dimension: first_telephone_number_telf1 {
    type: string
    description: "Telephone 1"
    sql: ${TABLE}.FirstTelephoneNumber_TELF1 ;;
  }
  dimension: fiscal_year_variant_periv {
    type: string
    description: "Fiscal Year Variant"
    sql: ${TABLE}.FiscalYearVariant_PERIV ;;
  }
  dimension: flag_po_box_without_number_po_box_num {
    type: string
    description: "PO Box w/o No."
    sql: ${TABLE}.Flag_PoBoxWithoutNumber_PO_BOX_NUM ;;
  }
  dimension: flag_there_are_more_address_group_assignments_flaggroups {
    type: string
    description: "Flag"
    sql: ${TABLE}.Flag_ThereAreMoreAddressGroupAssignments_FLAGGROUPS ;;
  }
  dimension: flag_this_is_apersonal_address_pers_addr {
    type: string
    description: "personal address"
    sql: ${TABLE}.Flag_ThisIsAPersonalAddress_PERS_ADDR ;;
  }
  dimension: floor_in_building_floor {
    type: string
    description: "Floor"
    sql: ${TABLE}.FloorInBuilding_FLOOR ;;
  }
  dimension: foreign_national_registration_rne {
    type: string
    description: "Foreign National Registration"
    sql: ${TABLE}.ForeignNationalRegistration_RNE ;;
  }
  dimension: form_of_address_key_title {
    type: string
    description: "Title"
    sql: ${TABLE}.FormOfAddressKey_TITLE ;;
  }
  dimension: group_key_konzs {
    type: string
    description: "Group key"
    sql: ${TABLE}.GroupKey_KONZS ;;
  }
  dimension: house_number_house_num1 {
    type: string
    description: "House Number"
    sql: ${TABLE}.HouseNumber_HOUSE_NUM1 ;;
  }
  dimension: house_number_supplement_house_num2 {
    type: string
    description: "Supplement"
    sql: ${TABLE}.HouseNumberSupplement_HOUSE_NUM2 ;;
  }
  dimension: icms_taxpayer_icmstaxpay {
    type: string
    description: "ICMS Taxpayer"
    sql: ${TABLE}.IcmsTaxpayer_ICMSTAXPAY ;;
  }
  dimension: id_for_default_sold_to_party_dear5 {
    type: string
    description: "Default sold-to pty"
    sql: ${TABLE}.IdForDefaultSoldToParty_DEAR5 ;;
  }
  dimension: id_for_military_use_milve {
    type: string
    description: "Military use"
    sql: ${TABLE}.IdForMilitaryUse_MILVE ;;
  }
  dimension: id_non_military_use_civve {
    type: string
    description: "Non-milit. use"
    sql: ${TABLE}.IdNonMilitaryUse_CIVVE ;;
  }
  dimension: indicator_consumer_dear6 {
    type: string
    description: "Consumer"
    sql: ${TABLE}.Indicator_Consumer_DEAR6 ;;
  }
  dimension: indicator_for_biochemical_warfare_ccc01 {
    type: string
    description: "Biochemical warfare"
    sql: ${TABLE}.IndicatorForBiochemicalWarfare_CCC01 ;;
  }
  dimension: indicator_for_missile_technology_ccc04 {
    type: string
    description: "Missile technology"
    sql: ${TABLE}.IndicatorForMissileTechnology_CCC04 ;;
  }
  dimension: indicator_for_national_security_ccc03 {
    type: string
    description: "National security"
    sql: ${TABLE}.IndicatorForNationalSecurity_CCC03 ;;
  }
  dimension: indicator_for_nuclear_nonproliferation_ccc02 {
    type: string
    description: "Nuclear nonprolif."
    sql: ${TABLE}.IndicatorForNuclearNonproliferation_CCC02 ;;
  }
  dimension: industry_code1_bran1 {
    type: string
    description: "Industry code 1"
    sql: ${TABLE}.IndustryCode1_BRAN1 ;;
  }
  dimension: industry_code2_bran2 {
    type: string
    description: "Industry code 2"
    sql: ${TABLE}.IndustryCode2_BRAN2 ;;
  }
  dimension: industry_code3_bran3 {
    type: string
    description: "Industry code 3"
    sql: ${TABLE}.IndustryCode3_BRAN3 ;;
  }
  dimension: industry_code4_bran4 {
    type: string
    description: "Industry code 4"
    sql: ${TABLE}.IndustryCode4_BRAN4 ;;
  }
  dimension: industry_code5_bran5 {
    type: string
    description: "Industry code 5"
    sql: ${TABLE}.IndustryCode5_BRAN5 ;;
  }
  dimension: industry_key_brsch {
    type: string
    description: "Industry"
    sql: ${TABLE}.IndustryKey_BRSCH ;;
  }
  dimension: industry_main_type_indtyp {
    type: string
    description: "Industry Main Type"
    sql: ${TABLE}.IndustryMainType_INDTYP ;;
  }
  dimension: initial_contact_ekont {
    type: string
    description: "Initial contact"
    sql: ${TABLE}.InitialContact_EKONT ;;
  }
  dimension: inspection_carried_out_by_customer_inspbydebi {
    type: string
    description: "By customer"
    sql: ${TABLE}.InspectionCarriedOutByCustomer_INSPBYDEBI ;;
  }
  dimension: inspection_for_adelivery_note_inspatdebi {
    type: string
    description: "After delivery"
    sql: ${TABLE}.InspectionForADeliveryNote_INSPATDEBI ;;
  }
  dimension: instruction_key_for_data_medium_exchange_dtaws {
    type: string
    description: "Instruction key"
    sql: ${TABLE}.InstructionKeyForDataMediumExchange_DTAWS ;;
  }
  dimension: international_location_number_bbbnr {
    type: string
    description: "Int. location no. 1"
    sql: ${TABLE}.InternationalLocationNumber_BBBNR ;;
  }
  dimension: international_location_number_bbsnr {
    type: string
    description: "Int. location no. 2"
    sql: ${TABLE}.InternationalLocationNumber_BBSNR ;;
  }
  dimension: issued_by_exp {
    type: string
    description: "Issued by"
    sql: ${TABLE}.IssuedBy_EXP ;;
  }
  dimension: language_key_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.LanguageKey_SPRAS ;;
  }
  dimension: language_langu {
    type: string
    description: "Language Key"
    sql: ${TABLE}.Language_LANGU ;;
  }
  dimension: legal_nature_legalnat {
    type: string
    description: "Legal Nature"
    sql: ${TABLE}.LegalNature_LEGALNAT ;;
  }
  dimension: legal_status_gform {
    type: string
    description: "Legal status"
    sql: ${TABLE}.LegalStatus_GFORM ;;
  }
  dimension: liable_for_vat_stkzu {
    type: string
    description: "Liable for VAT"
    sql: ${TABLE}.LiableForVat_STKZU ;;
  }
  dimension: matchcode_search_mcod1 {
    type: string
    description: "Name"
    sql: ${TABLE}.MatchcodeSearch_MCOD1 ;;
  }
  dimension: matchcode_search_mcod2 {
    type: string
    description: "Name 2"
    sql: ${TABLE}.MatchcodeSearch_MCOD2 ;;
  }
  dimension: matchcode_search_mcod3 {
    type: string
    description: "City"
    sql: ${TABLE}.MatchcodeSearch_MCOD3 ;;
  }
  dimension: name1_name1 {
    type: string
    description: "Name"
    sql: ${TABLE}.Name1_NAME1 ;;
  }
  dimension: name1_pson1 {
    type: string
    description: "Name"
    sql: ${TABLE}.Name1_PSON1 ;;
  }
  dimension: name2_name2 {
    type: string
    description: "Name 2"
    sql: ${TABLE}.Name2_NAME2 ;;
  }
  dimension: name2_pson2 {
    type: string
    description: "Name 2"
    sql: ${TABLE}.Name2_PSON2 ;;
  }
  dimension: name3_name3 {
    type: string
    description: "Name 3"
    sql: ${TABLE}.Name3_NAME3 ;;
  }
  dimension: name3_pson3 {
    type: string
    description: "Name 3"
    sql: ${TABLE}.Name3_PSON3 ;;
  }
  dimension: name4_name4 {
    type: string
    description: "Name 4"
    sql: ${TABLE}.Name4_NAME4 ;;
  }
  dimension: name_of_representative_j_1_kfrepre {
    type: string
    description: "Name of Representative"
    sql: ${TABLE}.NameOfRepresentative_J_1KFREPRE ;;
  }
  dimension: natural_person_stkzn {
    type: string
    description: "Natural Person"
    sql: ${TABLE}.NaturalPerson_STKZN ;;
  }
  dimension: nielsen_id_niels {
    type: string
    description: "Nielsen indicator"
    sql: ${TABLE}.NielsenId_NIELS ;;
  }
  dimension: one_time_account_xcpdk {
    type: string
    description: "One-time account"
    sql: ${TABLE}.OneTimeAccount_XCPDK ;;
  }
  dimension: payment_block_sperz {
    type: string
    description: "Payment block"
    sql: ${TABLE}.PaymentBlock_SPERZ ;;
  }
  dimension: payment_office_pmt_office {
    type: string
    description: "Payment Office"
    sql: ${TABLE}.PaymentOffice_PMT_OFFICE ;;
  }
  dimension: plant_werks {
    type: string
    description: "Plant"
    sql: ${TABLE}.Plant_WERKS ;;
  }
  dimension: po_box_address_undeliverable_flag_dont_use_p {
    type: string
    description: "Undeliverable"
    sql: ${TABLE}.PoBoxAddressUndeliverableFlag_DONT_USE_P ;;
  }
  dimension: po_box_city_pfort {
    type: string
    description: "P.O. Box city"
    sql: ${TABLE}.PoBoxCity_PFORT ;;
  }
  dimension: po_box_city_po_box_loc {
    type: string
    description: "PO Box City"
    sql: ${TABLE}.PoBoxCity_PO_BOX_LOC ;;
  }
  dimension: po_box_country_po_box_cty {
    type: string
    description: "PO box country"
    sql: ${TABLE}.PoBoxCountry_PO_BOX_CTY ;;
  }
  dimension: po_box_pfach {
    type: string
    description: "PO Box"
    sql: ${TABLE}.PoBox_PFACH ;;
  }
  dimension: po_box_po_box {
    type: string
    description: "PO Box"
    sql: ${TABLE}.PoBox_PO_BOX ;;
  }
  dimension: po_box_postal_code_post_code2 {
    type: string
    description: "PO Box Postal Code"
    sql: ${TABLE}.PoBoxPostalCode_POST_CODE2 ;;
  }
  dimension: pobox_postal_code_pstl2 {
    type: string
    description: "P.O. Box Postal Code"
    sql: ${TABLE}.POBoxPostalCode_PSTL2 ;;
  }
  dimension: postal_code_pstlz {
    type: string
    description: "Postal Code"
    sql: ${TABLE}.PostalCode_PSTLZ ;;
  }
  dimension: processor_group_psofg {
    type: string
    description: "Processor group"
    sql: ${TABLE}.ProcessorGroup_PSOFG ;;
  }
  dimension: reference_account_group_ktocd {
    type: string
    description: "Reference acct group"
    sql: ${TABLE}.ReferenceAccountGroup_KTOCD ;;
  }
  dimension: region__region {
    type: string
    description: "Region"
    sql: ${TABLE}.Region__REGION ;;
  }
  dimension: region_for_po_box_po_box_reg {
    type: string
    description: "PO Box Region"
    sql: ${TABLE}.RegionForPoBox_PO_BOX_REG ;;
  }
  dimension: regional_market_rpmkr {
    type: string
    description: "Regional market"
    sql: ${TABLE}.RegionalMarket_RPMKR ;;
  }
  dimension: regional_structure_grouping_regiogroup {
    type: string
    description: "Structure Group"
    sql: ${TABLE}.RegionalStructureGrouping_REGIOGROUP ;;
  }
  dimension: report_key_for_data_medium_exchange_dtams {
    type: string
    description: "DME indicator"
    sql: ${TABLE}.ReportKeyForDataMediumExchange_DTAMS ;;
  }
  dimension_group: rg_issuing_date_rgdate {
    type: time
    description: "RG Issuing Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RgIssuingDate_RGDATE ;;
  }
  dimension: rg_number_rg {
    type: string
    description: "RG Number"
    sql: ${TABLE}.RgNumber_RG ;;
  }
  dimension: ric_number_ric {
    type: string
    description: "RIC Number"
    sql: ${TABLE}.RicNumber_RIC ;;
  }
  dimension: rlabeling_customerplant_group_etikg {
    type: string
    description: "Lab.customer group"
    sql: ${TABLE}.RLabeling_CustomerplantGroup_ETIKG ;;
  }
  dimension_group: rne_issuing_date_rnedate {
    type: time
    description: "RNE Issuing Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RneIssuingDate_RNEDATE ;;
  }
  dimension: room_or_appartment_number_roomnumber {
    type: string
    description: "Room Number"
    sql: ${TABLE}.RoomOrAppartmentNumber_ROOMNUMBER ;;
  }
  dimension: sales_partner_dear2 {
    type: string
    description: "Sales partners"
    sql: ${TABLE}.SalesPartner_DEAR2 ;;
  }
  dimension: sales_prospect_dear3 {
    type: string
    description: "Prospect"
    sql: ${TABLE}.SalesProspect_DEAR3 ;;
  }
  dimension: search_term1_sort1 {
    type: string
    description: "Search Term 1"
    sql: ${TABLE}.SearchTerm1_SORT1 ;;
  }
  dimension: search_term2_sort2 {
    type: string
    description: "Search Term 2"
    sql: ${TABLE}.SearchTerm2_SORT2 ;;
  }
  dimension: second_telephone_number_telf2 {
    type: string
    description: "Telephone 2"
    sql: ${TABLE}.SecondTelephoneNumber_TELF2 ;;
  }
  dimension: sort_field_sortl {
    type: string
    description: "Search term"
    sql: ${TABLE}.SortField_SORTL ;;
  }
  dimension: state_uf {
    type: string
    description: "State"
    sql: ${TABLE}.State_UF ;;
  }
  dimension: status_of_change_authorization_confs {
    type: string
    description: "Confirmation status"
    sql: ${TABLE}.StatusOfChangeAuthorization_CONFS ;;
  }
  dimension: status_of_data_transfer_into_subsequent_release_duefl {
    type: string
    description: "Status of Data Transfer to Next Release"
    sql: ${TABLE}.StatusOfDataTransferIntoSubsequentRelease_DUEFL ;;
  }
  dimension: street2_str_suppl1 {
    type: string
    description: "Street 2"
    sql: ${TABLE}.Street2_STR_SUPPL1 ;;
  }
  dimension: street3_str_suppl2 {
    type: string
    description: "Street 3"
    sql: ${TABLE}.Street3_STR_SUPPL2 ;;
  }
  dimension: street4_str_suppl3 {
    type: string
    description: "Street 4"
    sql: ${TABLE}.Street4_STR_SUPPL3 ;;
  }
  dimension: street5_location {
    type: string
    description: "Street 5"
    sql: ${TABLE}.Street5_LOCATION ;;
  }
  dimension: street_address_undeliverable_flag_dont_use_s {
    type: string
    description: "Undeliverable"
    sql: ${TABLE}.StreetAddressUndeliverableFlag_DONT_USE_S ;;
  }
  dimension: street_and_number_stras {
    type: string
    description: "Street"
    sql: ${TABLE}.StreetAndNumber_STRAS ;;
  }
  dimension: street_number_for_citystreet_file_streetcode {
    type: string
    description: "Street Code"
    sql: ${TABLE}.StreetNumberForCitystreetFile_STREETCODE ;;
  }
  dimension: street_street {
    type: string
    description: "Street"
    sql: ${TABLE}.Street_STREET ;;
  }
  dimension: subject_to_equalization_tax_stkza {
    type: string
    description: "Sales equalizatn tax"
    sql: ${TABLE}.SubjectToEqualizationTax_STKZA ;;
  }
  dimension: subledger_acct_preprocessing_procedure_psois {
    type: string
    description: "SLAPrepr.Proced"
    sql: ${TABLE}.SubledgerAcctPreprocessingProcedure_PSOIS ;;
  }
  dimension: suframa_code_suframa {
    type: string
    description: "Suframa Code"
    sql: ${TABLE}.SuframaCode_SUFRAMA ;;
  }
  dimension: tax_declaration_type_tdt {
    type: string
    description: "Tax Declaration Type"
    sql: ${TABLE}.TaxDeclarationType_TDT ;;
  }
  dimension: tax_jurisdiction_txjcd {
    type: string
    description: "Tax Jurisdiction"
    sql: ${TABLE}.TaxJurisdiction_TXJCD ;;
  }
  dimension: tax_law_icms_txlw1 {
    type: string
    description: "ICMS law"
    sql: ${TABLE}.TaxLaw_Icms_TXLW1 ;;
  }
  dimension: tax_law_ipi_txlw2 {
    type: string
    description: "IPI law"
    sql: ${TABLE}.TaxLaw_Ipi_TXLW2 ;;
  }
  dimension: tax_number1_stcd1 {
    type: string
    description: "Tax Number 1"
    sql: ${TABLE}.TaxNumber1_STCD1 ;;
  }
  dimension: tax_number2_stcd2 {
    type: string
    description: "Tax Number 2"
    sql: ${TABLE}.TaxNumber2_STCD2 ;;
  }
  dimension: tax_number3_stcd3 {
    type: string
    description: "Tax Number 3"
    sql: ${TABLE}.TaxNumber3_STCD3 ;;
  }
  dimension: tax_number4_stcd4 {
    type: string
    description: "Tax Number 4"
    sql: ${TABLE}.TaxNumber4_STCD4 ;;
  }
  dimension: tax_number5_stcd5 {
    type: string
    description: "Tax Number 5"
    sql: ${TABLE}.TaxNumber5_STCD5 ;;
  }
  dimension: tax_number_type_stcdt {
    type: string
    description: "Tax number type"
    sql: ${TABLE}.TaxNumberType_STCDT ;;
  }
  dimension: tax_type_fityp {
    type: string
    description: "Tax type"
    sql: ${TABLE}.TaxType_FITYP ;;
  }
  dimension: telebox_number_telbx {
    type: string
    description: "Telebox number"
    sql: ${TABLE}.TeleboxNumber_TELBX ;;
  }
  dimension: teletex_number_teltx {
    type: string
    description: "Teletex number"
    sql: ${TABLE}.TeletexNumber_TELTX ;;
  }
  dimension: telex_number_telx1 {
    type: string
    description: "Telex number"
    sql: ${TABLE}.TelexNumber_TELX1 ;;
  }
  dimension: time_of_last_change_confirmation_uptim {
    type: string
    description: "Confirmation time"
    sql: ${TABLE}.TimeOfLastChangeConfirmation_UPTIM ;;
  }
  dimension: title_anred {
    type: string
    description: "Title"
    sql: ${TABLE}.Title_ANRED ;;
  }
  dimension: title_psotl {
    type: string
    description: "Title"
    sql: ${TABLE}.Title_PSOTL ;;
  }
  dimension: township_code_for_township_township_code {
    type: string
    description: "Township code"
    sql: ${TABLE}.TownshipCodeForTownship_TOWNSHIP_CODE ;;
  }
  dimension: township_name_in_upper_case_for_search_help_mc_township {
    type: string
    description: "Township"
    sql: ${TABLE}.TownshipNameInUpperCaseForSearchHelp_MC_TOWNSHIP ;;
  }
  dimension: township_township {
    type: string
    description: "Township"
    sql: ${TABLE}.Township_TOWNSHIP ;;
  }
  dimension: train_station_bahns {
    type: string
    description: "Train station"
    sql: ${TABLE}.TrainStation_BAHNS ;;
  }
  dimension: transportation_zone_lzone {
    type: string
    description: "Transportation Zone"
    sql: ${TABLE}.TransportationZone_LZONE ;;
  }
  dimension: transportation_zone_to_or_from_which_the_goods_are_delivered_transpzone {
    type: string
    description: "Transportation Zone"
    sql: ${TABLE}.TransportationZoneToOrFromWhichTheGoodsAreDelivered_TRANSPZONE ;;
  }
  dimension: type_of_business_j_1_kftbus {
    type: string
    description: "Type of Business"
    sql: ${TABLE}.TypeOfBusiness_J_1KFTBUS ;;
  }
  dimension: type_of_industry_j_1_kftind {
    type: string
    description: "Type of Industry"
    sql: ${TABLE}.TypeOfIndustry_J_1KFTIND ;;
  }
  dimension: uniform_resource_locator_knurl {
    type: string
    description: "URL"
    sql: ${TABLE}.UniformResourceLocator_KNURL ;;
  }
  dimension: unloading_points_exist_exabl {
    type: string
    description: "Unloading points"
    sql: ${TABLE}.UnloadingPointsExist_EXABL ;;
  }
  dimension: usage_indicator_abrvw {
    type: string
    description: "Usage"
    sql: ${TABLE}.UsageIndicator_ABRVW ;;
  }
  dimension_group: valid_from_date_date_from {
    type: time
    description: "from"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ValidFromDate_DATE_FROM ;;
  }
  dimension_group: valid_to_date_date_to {
    type: time
    description: "To"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ValidToDate_DATE_TO ;;
  }
  dimension: vat_registration_number_stceg {
    type: string
    description: "VAT Registration No."
    sql: ${TABLE}.VatRegistrationNumber_STCEG ;;
  }
  dimension: version_id_for_international_addresses_nation {
    type: string
    description: "Address Version"
    sql: ${TABLE}.VersionIdForInternationalAddresses_NATION ;;
  }
  dimension: working_time_calendar_knazk {
    type: string
    description: "Working times"
    sql: ${TABLE}.WorkingTimeCalendar_KNAZK ;;
  }
  dimension: year_for_which_sales_are_given_umjah {
    type: string
    description: "Sales year"
    sql: ${TABLE}.YearForWhichSalesAreGiven_UMJAH ;;
  }
  dimension: year_for_which_the_number_of_employees_is_given_jmjah {
    type: string
    description: "Year no. given for"
    sql: ${TABLE}.YearForWhichTheNumberOfEmployeesIsGiven_JMJAH ;;
  }
  dimension: yearly_number_of_employees_jmzah {
    type: string
    description: "Employee"
    sql: ${TABLE}.YearlyNumberOfEmployees_JMZAH ;;
  }
  measure: count {
    type: count
  }
}