view: accounting_documents_receivable {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.AccountingDocumentsReceivable` ;;

  dimension: account_type_koart {
    type: string
    description: "Account Type"
    sql: ${TABLE}.AccountType_KOART ;;
  }
  dimension: accounting_document_number_belnr {
    type: string
    description: "Document Number"
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }
  dimension: accounts_receivable {
    type: number
    description: "Accounts Receivable"
    sql: ${TABLE}.AccountsReceivable ;;
  }
  dimension: bad_debt_dmbtr {
    type: number
    description: "Amt.in loc.cur."
    sql: ${TABLE}.BadDebt_DMBTR ;;
  }
  dimension: billing_document_vbeln {
    type: string
    description: "Billing Document"
    sql: ${TABLE}.BillingDocument_VBELN ;;
  }
  dimension_group: cash_discount_date1 {
    type: time
    description: "Cash Discount Date1"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CashDiscountDate1 ;;
  }
  dimension_group: cash_discount_date2 {
    type: time
    description: "Cash Discount Date2"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CashDiscountDate2 ;;
  }
  dimension: city_ort01 {
    type: string
    description: "City"
    sql: ${TABLE}.City_ORT01 ;;
  }
  dimension: cleared_after_due_date {
    type: number
    description: "Cleared After Due Date"
    sql: ${TABLE}.ClearedAfterDueDate ;;
  }
  dimension: cleared_on_or_before_due_date {
    type: number
    description: "Cleared On Or Before Due Date"
    sql: ${TABLE}.ClearedOnOrBeforeDueDate ;;
  }
  dimension: client_mandt {
    type: string
    description: "Client (Mandant)"
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: company_city {
    type: string
    description: "Company"
    sql: ${TABLE}.Company_City ;;
  }
  dimension: company_code_bukrs {
    type: string
    description: "Company Code"
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }
  dimension: company_country {
    type: string
    description: "Country Key"
    sql: ${TABLE}.Company_Country ;;
  }
  dimension: company_text_butxt {
    type: string
    description: "Company Name"
    sql: ${TABLE}.CompanyText_BUTXT ;;
  }
  dimension: country_key_land1 {
    type: string
    description: "Country Key"
    sql: ${TABLE}.CountryKey_LAND1 ;;
  }
  dimension: currency_key_waers {
    type: string
    description: "Currency"
    sql: ${TABLE}.CurrencyKey_WAERS ;;
  }
  dimension: current_period {
    type: string
    description: "Current"
    sql: ${TABLE}.Current_Period ;;
  }
  dimension: customer_number_kunnr {
    type: string
    description: "Customer"
    sql: ${TABLE}.CustomerNumber_KUNNR ;;
  }
  dimension: days_in_arrear {
    type: number
    description: "Days In Arrear"
    sql: ${TABLE}.DaysInArrear ;;
  }
  dimension_group: document_date_in_document_bldat {
    type: time
    description: "Document Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DocumentDateInDocument_BLDAT ;;
  }
  dimension: doubtful_receivables {
    type: number
    description: "Doubtful Receivables"
    sql: ${TABLE}.DoubtfulReceivables ;;
  }
  dimension: exchange_rate_type_kurst {
    type: string
    description: "Exchange Rate Type"
    sql: ${TABLE}.ExchangeRateType_KURST ;;
  }
  dimension: fiscal_year_gjahr {
    type: string
    description: "Fiscal Year"
    sql: ${TABLE}.FiscalYear_GJAHR ;;
  }
  dimension: fiscalyear_variant_periv {
    type: string
    description: "Fiscal Year Variant"
    sql: ${TABLE}.FiscalyearVariant_PERIV ;;
  }
  dimension: invoice_to_which_the_transaction_belongs_rebzg {
    type: string
    description: "Invoice reference"
    sql: ${TABLE}.InvoiceToWhichTheTransactionBelongs_REBZG ;;
  }
  dimension: local_currency_hwaer {
    type: string
    description: "Local Currency"
    sql: ${TABLE}.LocalCurrency_HWAER ;;
  }
  dimension: name1_name1 {
    type: string
    description: "Name"
    sql: ${TABLE}.NAME1_NAME1 ;;
  }
  dimension_group: net_due {
    type: time
    description: "Net Due Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NetDueDate ;;
  }
  dimension: number_of_line_item_within_accounting_document_buzei {
    type: string
    description: "Line item"
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }
  dimension: open_and_not_due {
    type: number
    description: "Open And Not Due"
    sql: ${TABLE}.OpenAndNotDue ;;
  }
  dimension: open_and_over_due {
    type: number
    description: "Open And Over Due"
    sql: ${TABLE}.OpenAndOverDue ;;
  }
  dimension: period {
    type: string
    description: "Period"
    sql: ${TABLE}.Period ;;
  }
  dimension_group: posting_date_in_the_document_budat {
    type: time
    description: "Posting Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PostingDateInTheDocument_BUDAT ;;
  }
  dimension: sales {
    type: number
    description: "Sales"
    sql: ${TABLE}.Sales ;;
  }
  dimension: written_off_amount_dmbtr {
    type: number
    description: "Amt.in loc.cur."
    sql: ${TABLE}.WrittenOffAmount_DMBTR ;;
  }
  measure: count {
    type: count
  }
}