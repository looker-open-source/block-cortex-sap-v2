view: countries_md {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CountriesMD` ;;

  dimension: alternative_country_key_landa {
    type: string
    description: "Alternative Key"
    sql: ${TABLE}.AlternativeCountryKey_LANDA ;;
  }
  dimension: bank_account_number_length_lnbkn {
    type: string
    description: "Bank account number length"
    sql: ${TABLE}.BankAccountNumberLength_LNBKN ;;
  }
  dimension: bank_number_length_lnblz {
    type: string
    description: "Bank number length"
    sql: ${TABLE}.BankNumberLength_LNBLZ ;;
  }
  dimension: chart_of_depreciaton_for_asset_valuation_afapl {
    type: string
    description: "Chart of dep."
    sql: ${TABLE}.ChartOfDepreciatonForAssetValuation_AFAPL ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: country_currency_waers {
    type: string
    description: "Country currency"
    sql: ${TABLE}.CountryCurrency_WAERS ;;
  }
  dimension: country_iso_code_intca {
    type: string
    description: "ISO code"
    sql: ${TABLE}.CountryIsoCode_INTCA ;;
  }
  dimension: country_key_land1 {
    type: string
    description: "Country Key"
    sql: ${TABLE}.CountryKey_LAND1 ;;
  }
  dimension: country_language_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.CountryLanguage_SPRAS ;;
  }
  dimension: country_name__max50_characters___landx50 {
    type: string
    description: "Country Name"
    sql: ${TABLE}.CountryName__max50Characters___LANDX50 ;;
  }
  dimension: country_name_landx {
    type: string
    description: "Name"
    sql: ${TABLE}.CountryName_LANDX ;;
  }
  dimension: country_version_flag_xland {
    type: string
    description: "Country version"
    sql: ${TABLE}.CountryVersionFlag_XLAND ;;
  }
  dimension: currency_key_of_the_hard_currency_curha {
    type: string
    description: "Hard currency"
    sql: ${TABLE}.CurrencyKeyOfTheHardCurrency_CURHA ;;
  }
  dimension: currency_key_of_the_index_based_currency_curin {
    type: string
    description: "Index-based curr."
    sql: ${TABLE}.CurrencyKeyOfTheIndexBasedCurrency_CURIN ;;
  }
  dimension: date_format_datfm {
    type: string
    description: "Date format"
    sql: ${TABLE}.DateFormat_DATFM ;;
  }
  dimension: decimal_point_format_xdezp {
    type: string
    description: "Decimal format"
    sql: ${TABLE}.DecimalPointFormat_XDEZP ;;
  }
  dimension: duevo_nationality_landd {
    type: string
    description: "Nationality"
    sql: ${TABLE}.Duevo_Nationality_LANDD ;;
  }
  dimension: exchange_rate_type_for_translation_into_country_currency_kurst {
    type: string
    description: "Exchange rate type"
    sql: ${TABLE}.ExchangeRateTypeForTranslationIntoCountryCurrency_KURST ;;
  }
  dimension: flag_city_file_address_check_xregs {
    type: string
    description: "City file active"
    sql: ${TABLE}.Flag_CityFileAddressCheck_XREGS ;;
  }
  dimension: flag_po_box_postal_code_required_xplpf {
    type: string
    description: "PO Box postal code"
    sql: ${TABLE}.Flag_PoBoxPostalCodeRequired_XPLPF ;;
  }
  dimension: flag_print_country_name_in_foreign_addresses_xaddr {
    type: string
    description: "Print Country Name"
    sql: ${TABLE}.Flag_PrintCountryNameInForeignAddresses_XADDR ;;
  }
  dimension: flag_street_address_postal_code_required_entry_xplzs {
    type: string
    description: "Postal code required"
    sql: ${TABLE}.Flag_StreetAddressPostalCodeRequiredEntry_XPLZS ;;
  }
  dimension: flag_street_specific_postal_code__city_file___xplst {
    type: string
    description: "Street postcode"
    sql: ${TABLE}.FlagStreetSpecificPostalCode__cityFile___XPLST ;;
  }
  dimension: formatting_routine_key_for_printing_addresses_addrs {
    type: string
    description: "Address layout key"
    sql: ${TABLE}.FormattingRoutineKeyForPrintingAddresses_ADDRS ;;
  }
  dimension: indicator_base_amount_for_tax_is_net_of_discount_xmwsn {
    type: string
    description: "Tax base is net value"
    sql: ${TABLE}.Indicator_BaseAmountForTaxIsNetOfDiscount_XMWSN ;;
  }
  dimension: indicator_discount_base_amount_is_the_net_value_xskfn {
    type: string
    description: "Discount base is net value"
    sql: ${TABLE}.Indicator_DiscountBaseAmountIsTheNetValue_XSKFN ;;
  }
  dimension: indicator_display_capital_goods_indicator_xxinve {
    type: string
    description: "Capital Goods Ind."
    sql: ${TABLE}.Indicator_DisplayCapitalGoodsIndicator_XXINVE ;;
  }
  dimension: indicator_european_union_member_xegld {
    type: string
    description: "EU Member"
    sql: ${TABLE}.Indicator_EuropeanUnionMember_XEGLD ;;
  }
  dimension: indicator_post_net_book_value_for_retirement_kzrbwb {
    type: string
    description: "Post net book value"
    sql: ${TABLE}.IndicatorPostNetBookValueForRetirement_KZRBWB ;;
  }
  dimension: indicator_transfer_down_payments_from_previous_years_xanzum {
    type: string
    description: "Capitalize AuC w/o downpayment"
    sql: ${TABLE}.IndicatorTransferDownPaymentsFromPreviousYears_XANZUM ;;
  }
  dimension: indicator_use_check_module_for_bank_fields_xprbk {
    type: string
    description: "Bank data"
    sql: ${TABLE}.Indicator_UseCheckModuleForBankFields_XPRBK ;;
  }
  dimension: indicator_use_check_module_for_tax_fields_etc_xprso {
    type: string
    description: "Other data"
    sql: ${TABLE}.Indicator_UseCheckModuleForTaxFieldsEtc_XPRSO ;;
  }
  dimension: intrastat_code_intcn {
    type: string
    description: "Intrastat code"
    sql: ${TABLE}.IntrastatCode_INTCN ;;
  }
  dimension: iso_country_code3_char_intca3 {
    type: string
    description: "ISO Code 3 Characters"
    sql: ${TABLE}.IsoCountryCode3Char_INTCA3 ;;
  }
  dimension: iso_country_code_numeric3_characters_intcn3 {
    type: string
    description: "ISO Code Numeric 3-Chars."
    sql: ${TABLE}.IsoCountryCodeNumeric3Characters_INTCN3 ;;
  }
  dimension: language_spras {
    type: string
    description: "Language Key"
    sql: ${TABLE}.Language_SPRAS ;;
  }
  dimension: length_of_bank_key_lnbks {
    type: string
    description: "Length of Bank Key"
    sql: ${TABLE}.LengthOfBankKey_LNBKS ;;
  }
  dimension: maximum_low_value_asset_amount_gwgwrt {
    type: number
    description: "Max.LVA amount: for posting"
    sql: ${TABLE}.MaximumLowValueAssetAmount_GWGWRT ;;
  }
  dimension: name_of_the_bank_key_bnkey {
    type: string
    description: "Bank Key"
    sql: ${TABLE}.NameOfTheBankKey_BNKEY ;;
  }
  dimension: nationality__max50_characters___natio50 {
    type: string
    description: "Nationality (Long)"
    sql: ${TABLE}.Nationality__max50Characters___NATIO50 ;;
  }
  dimension: nationality_natio {
    type: string
    description: "Nationality"
    sql: ${TABLE}.Nationality_NATIO ;;
  }
  dimension: net_book_value_for_changeover_of_depreciation_method_umrwrt {
    type: number
    description: "Net book value for dep.change"
    sql: ${TABLE}.NetBookValueForChangeoverOfDepreciationMethod_UMRWRT ;;
  }
  dimension: payment_period_for_bill_of_exchange_wechf {
    type: string
    description: "B/exch.payment period"
    sql: ${TABLE}.PaymentPeriodForBillOfExchange_WECHF ;;
  }
  dimension: permitted_input_length_for_tax_number2_lnst2 {
    type: string
    description: "Permitted Length for Tax Number 2"
    sql: ${TABLE}.PermittedInputLengthForTaxNumber2_LNST2 ;;
  }
  dimension: permitted_input_length_for_tax_number3_lnst3 {
    type: string
    description: "Permitted Length for Tax Number 3"
    sql: ${TABLE}.PermittedInputLengthForTaxNumber3_LNST3 ;;
  }
  dimension: permitted_input_length_for_tax_number4_lnst4 {
    type: string
    description: "Permitted Length for Tax Number 4"
    sql: ${TABLE}.PermittedInputLengthForTaxNumber4_LNST4 ;;
  }
  dimension: permitted_input_length_for_tax_number5_lnst5 {
    type: string
    description: "Permitted Length for Tax Number 5"
    sql: ${TABLE}.PermittedInputLengthForTaxNumber5_LNST5 ;;
  }
  dimension: permitted_input_length_for_tax_numbre1_lnst1 {
    type: string
    description: "Permitted Length for Tax Number 1"
    sql: ${TABLE}.PermittedInputLengthForTaxNumbre1_LNST1 ;;
  }
  dimension: post_office_bank_current_account_number_length_lnpsk {
    type: string
    description: "Post office bank acct no.length"
    sql: ${TABLE}.PostOfficeBankCurrentAccountNumberLength_LNPSK ;;
  }
  dimension: postal_code_length_lnplz {
    type: string
    description: "Postal code length"
    sql: ${TABLE}.PostalCodeLength_LNPLZ ;;
  }
  dimension: procedure__pricing_kalsm {
    type: string
    description: "Procedure"
    sql: ${TABLE}.Procedure__pricing_KALSM ;;
  }
  dimension: rule_for_checking_bank_account_number_field_prbkn {
    type: string
    description: "Check rule for bank acct no."
    sql: ${TABLE}.RuleForCheckingBankAccountNumberField_PRBKN ;;
  }
  dimension: rule_for_checking_bank_key_field_prbks {
    type: string
    description: "Check rule for bank key"
    sql: ${TABLE}.RuleForCheckingBankKeyField_PRBKS ;;
  }
  dimension: rule_for_checking_bank_number_field_prblz {
    type: string
    description: "Check rule for bank number"
    sql: ${TABLE}.RuleForCheckingBankNumberField_PRBLZ ;;
  }
  dimension: rule_for_checking_postal_check_account_number_field_prpsk {
    type: string
    description: "Check rule for pst.chck acct no."
    sql: ${TABLE}.RuleForCheckingPostalCheckAccountNumberField_PRPSK ;;
  }
  dimension: rule_for_checking_tax_code1_field_prst1 {
    type: string
    description: "Check rule for tax code 1"
    sql: ${TABLE}.RuleForCheckingTaxCode1Field_PRST1 ;;
  }
  dimension: rule_for_checking_tax_code2_field_prst2 {
    type: string
    description: "Check rule for tax code 2"
    sql: ${TABLE}.RuleForCheckingTaxCode2Field_PRST2 ;;
  }
  dimension: rule_for_checking_tax_code3_field_prst3 {
    type: string
    description: "Check rule for tax code 3"
    sql: ${TABLE}.RuleForCheckingTaxCode3Field_PRST3 ;;
  }
  dimension: rule_for_checking_tax_code4_field_prst4 {
    type: string
    description: "Check rule for tax code 4"
    sql: ${TABLE}.RuleForCheckingTaxCode4Field_PRST4 ;;
  }
  dimension: rule_for_checking_tax_code5_field_prst5 {
    type: string
    description: "Check rule for tax code 5"
    sql: ${TABLE}.RuleForCheckingTaxCode5Field_PRST5 ;;
  }
  dimension: rule_for_checking_vat_registration_number_field_pruin {
    type: string
    description: "VAT registration number"
    sql: ${TABLE}.RuleForCheckingVatRegistrationNumberField_PRUIN ;;
  }
  dimension: rule_for_the_postal_code_field_check_prplz {
    type: string
    description: "Check rule for postal code"
    sql: ${TABLE}.RuleForThePostalCodeFieldCheck_PRPLZ ;;
  }
  dimension: short_name_for_foreign_trade_statistics_lkvrz {
    type: string
    description: "Trde stat.short name"
    sql: ${TABLE}.ShortNameForForeignTradeStatistics_LKVRZ ;;
  }
  dimension: standard_name_format_nmfmt {
    type: string
    description: "Standard name format"
    sql: ${TABLE}.StandardNameFormat_NMFMT ;;
  }
  dimension: super_region_per_country_sureg {
    type: string
    description: "Super region"
    sql: ${TABLE}.SuperRegionPerCountry_SUREG ;;
  }
  dimension: super_region_per_country_text_prq_spregt {
    type: string
    description: "Super region"
    sql: ${TABLE}.SuperRegionPerCountryText_PRQ_SPREGT ;;
  }
  dimension: taxes_at_individual_service_level_kzsrv {
    type: string
    description: "Taxes at ind. serv. level"
    sql: ${TABLE}.TaxesAtIndividualServiceLevel_KZSRV ;;
  }
  dimension: vat_registration_number_length_uinln {
    type: string
    description: "VAT registration no."
    sql: ${TABLE}.VatRegistrationNumberLength_UINLN ;;
  }
  dimension: vehicle_country_key_landk {
    type: string
    description: "Vehicle country key"
    sql: ${TABLE}.VehicleCountryKey_LANDK ;;
  }
  dimension: withholding_tax_certificate_numbering_concepts_ctnconcept {
    type: string
    description: "W/tax certificate numbering concepts"
    sql: ${TABLE}.WithholdingTaxCertificateNumbering_Concepts_CTNCONCEPT ;;
  }
  measure: count {
    type: count
  }
}