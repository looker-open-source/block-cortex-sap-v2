#########################################################{
# Billing dashboard provides an overview of
# invoice volume and amounts including monthly trends.
# Highlights customers with greatest pricing adjustments
# and products with greatest intercompany pricing adjustments.
#
# Extends otc_template and modifies to:
#   label date filter as Billing Date
#   update dashboard_navigation to:
#       set parameter_navigation_focus_page: '4'
#
# Visualization Elements:
#   invoice_count - single-value viz
#   invoice_amount - single-value viz
#   discount_amount - single-value viz
#   tax_amount - single-value viz
#   invoices_by_month - area & line chart
#   customer_price_adjustments - column
#   product_intercompany_prices - column
#########################################################}

- dashboard: otc_billing_and_pricing
  title: Billing and Pricing
  description: "Overview of invoice volume and amounts including monthly trends. Highlights customers with highest discounts (average discount amount and percentages)."
  extends: otc_template
#####################################################################################################
  filters:
    - name: date
      title: Billing Date
#####################################################################################################
  elements:
    - name: dashboard_navigation
      explore: billing
      filters:
        otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '1'
        otc_dashboard_navigation_xvw.parameter_navigation_subject: 'billing'
#####################################################################################################
    - name: invoice_count
      title: Total Invoice Count
      explore: billing
      type: single_value
      fields: [ billing.invoice_count_formatted,
                billing.total_billed_amount_target_currency_formatted,
                sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                billing.total_tax_amount_target_currency_formatted]
      hidden_fields: [billing.total_billed_amount_target_currency_formatted,
                      sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                      billing.total_tax_amount_target_currency_formatted]
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      note_state: collapsed
      note_display: hover
      note_text: "Total count of invoices."
      row: 2
      col: 0
      width: 6
      height: 2
#####################################################################################################
    - name: invoice_amount
      title: Total Invoice Amount
      explore: billing
      type: single_value
      fields: [ billing.invoice_count_formatted,
                billing.total_billed_amount_target_currency_formatted,
                sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                billing.total_tax_amount_target_currency_formatted]
      hidden_fields: [billing.invoice_count_formatted,
                      sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                      billing.total_tax_amount_target_currency_formatted]
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      note_state: collapsed
      note_display: hover
      note_text: "Total amount of invoices."
      row: 2
      col: 6
      width: 6
      height: 2
#####################################################################################################
    - name: discount_amount
      title: Total Discount Amount
      explore: billing
      type: single_value
      fields: [ billing.invoice_count_formatted,
                billing.total_billed_amount_target_currency_formatted,
                sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                billing.total_tax_amount_target_currency_formatted]
      hidden_fields: [billing.invoice_count_formatted,
                      billing.total_billed_amount_target_currency_formatted,
                      billing.total_tax_amount_target_currency_formatted]
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      note_state: collapsed
      note_display: hover
      note_text: |-
        Total discount amount of invoices.
        </br></br>Sum of pricing condition values when pricing condition class = 'A'. Reported as a positive value.
      row: 2
      col: 12
      width: 6
      height: 2
#####################################################################################################
    - name: tax_amount
      title: Total Tax Amount
      explore: billing
      type: single_value
      fields: [ billing.invoice_count_formatted,
                billing.total_billed_amount_target_currency_formatted,
                sales_order_pricing_sdt.total_discount_amount_target_currency_formatted,
                billing.total_tax_amount_target_currency_formatted]
      hidden_fields: [billing.invoice_count_formatted,
                      billing.total_billed_amount_target_currency_formatted,
                      sales_order_pricing_sdt.total_discount_amount_target_currency_formatted]
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      note_state: collapsed
      note_display: hover
      note_text: "Total tax amount of invoices."
      row: 2
      col: 18
      width: 6
      height: 2
#####################################################################################################
    - name: invoices_by_month
      title: Invoice Volumes by Month
      explore: billing
      type: looker_line
      fields: [billing.billing_date_fkdat_month,
              billing.invoice_count,
              billing.total_billed_amount_target_currency_formatted]
      sorts: [billing.billing_date_fkdat_month desc]
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_x_axis_label: false
      show_x_axis_ticks: true
      show_null_points: false
      discontinuous_nulls: true
      legend_position: center
      point_style: circle_outline
      y_axes: [{label: '', orientation: left,
                series: [{axisId: billing.invoice_count,
                              id: billing.invoice_count,
                            name: Invoice Count}], showLabels: true, showValues: true, },
          {label: '', orientation: right,
            series: [{axisId: billing.total_billed_amount_target_currency_formatted,
                          id: billing.total_billed_amount_target_currency_formatted,
                        name: Total Invoice Amount}], showLabels: true, showValues: true,}]
      series_types:
        billing.invoice_count: area
      series_colors:
        billing.total_billed_amount_target_currency_formatted: "#808080"
        billing.invoice_count: "#2596BE"

      advanced_vis_config: |-
        {
          chart: {},
          series: [{
            name: "Invoice Count",
            lineWidth: 5,
            marker: {
              enabled: false
            },
          }, ],
          tooltip: {
            backgroundColor: '#FFFFFF',
            shadow: true,
            format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>{/each}',
            footerFormat: '</table>',
            useHTML: true,
            shared: true,
            crosshairs: true,
          },
        }
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      note_state: collapsed
      note_display: hover
      note_text: "Invoice total counts and amounts by month."
      row: 6
      col: 0
      width: 24
      height: 7
#####################################################################################################
    - name: customer_price_adjustments
      title: Customers with Greatest Price Adjustments
      explore: billing
      # type: looker_line
      type: looker_column
      fields: [billing.sold_to_party_kunag,
               billing.customer_name,
               sales_order_pricing_sdt.average_list_price_target_currency,
               sales_order_pricing_sdt.average_adjusted_price_target_currency,
               sales_order_pricing_sdt.absolute_difference_list_and_adjusted_price_target_currency]
      hidden_fields: [billing.sold_to_party_kunag,
                      sales_order_pricing_sdt.absolute_difference_list_and_adjusted_price_target_currency]
      filters:
        sales_order_pricing_sdt.adjusted_price: NOT NULL
      sorts: [sales_order_pricing_sdt.absolute_difference_list_and_adjusted_price_target_currency desc]
      limit: 500
      column_limit: 50
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: false
      x_axis_label_rotation: 0
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      legend_position: center
      point_style: circle
      show_value_labels: true
      show_null_points: false
      interpolation: step
      color_application:
        collection_id: legacy
        palette_id: looker_classic
        options:
          steps: 5
          reverse: false
      y_axes: [{label: 'Avg List Prices when Adjustment', orientation: left,
                series: [{axisId: sales_order_pricing_sdt.average_list_price_target_currency,
                              id: sales_order_pricing_sdt.average_list_price_target_currency,
                            name: Average List Price when Adjustment},
                        {axisId: sales_order_pricing_sdt.average_adjusted_price_target_currency,
                              id: sales_order_pricing_sdt.average_adjusted_price_target_currency,
                            name: Average Adjusted Price when Adjustment}],
                            showLabels: false, showValues: false, },
                # {label: 'Discount percentages', orientation: right,
                #     series: [{axisId: sales_invoices__lines.average_percent_discount_when_taken_formatted,
                #                   id: sales_invoices__lines.average_percent_discount_when_taken_formatted,
                #                 name: Average % Discount},
                #             {axisId: sales_invoices__lines.discount_invoice_line_percent_formatted,
                #                 id: sales_invoices__lines.discount_invoice_line_percent_formatted,
                #               name: Frequency of Discounts}],
                #   showLabels: true, showValues: true, minValue: 0, }
                  ]
      limit_displayed_rows: true
      limit_displayed_rows_values:
        show_hide: show
        first_last: first
        num_rows: '5'
      series_types:
        sales_order_pricing_sdt.average_list_price_target_currency: column
        sales_order_pricing_sdt.average_adjusted_price_target_currency: column
      series_labels:
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: "Average Discount %"
        # sales_invoices__lines.discount_invoice_line_percent_formatted: "Discount Frequency (% of Invoice Lines)"
        # sales_order_pricing_sdt.average_list_price_target_currency: "Average Unit List Price"
        # sales_invoices__lines.average_gross_unit_selling_price_when_discount_target_currency: "Average Gross Unit Selling Price"
      series_colors:
        sales_order_pricing_sdt.average_list_price_target_currency: "#76B5C5"
        sales_order_pricing_sdt.average_adjusted_price_target_currency: "#E28743"
        # sales_invoices__lines.discount_invoice_line_percent_formatted: "#192D54"
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: "#873E23"
      # series_point_styles:
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: triangle
      # advanced_vis_config: |-
      #   {
      #     series: [
      #       {
      #         id: 'sales_invoices__lines.average_percent_discount_when_taken_formatted',
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.1f}%</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #         dataLabels: {
      #           format: '{y:.1f}%',
      #           color: '#873E23',
      #           allowOverlap: false,
      #         },
      #       },
      #       {
      #         id: 'sales_invoices__lines.discount_invoice_line_percent_formatted',
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.1f}%</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #         dataLabels: {
      #           format: '{y:.1f}%',
      #           color: '#192D54',
      #           allowOverlap: false,
      #         },
      #         type: 'line',
      #         dashStyle: "dash",
      #       },
      #       {
      #         id: 'sales_invoices__lines.average_unit_list_price_when_discount_target_currency',
      #         dataLabels: {
      #           enabled: false,
      #         },
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #       },
      #       {
      #         id: 'sales_invoices__lines.average_unit_selling_price_when_discount_target_currency',
      #         dataLabels: {
      #           enabled: false,
      #         },
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #       },
      #     ],
      #     tooltip: {
      #       backgroundColor: '#FFFFFF',
      #       formatter: null,
      #       shared: true,
      #       crosshairs: true,
      #       shadow: true,
      #     },
      #   }
      # advanced_vis_config: |-
      #   {
      #     tooltip: {
      #       backgroundColor: '#FFFFFF',
      #       shadow: true,
      #       format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:#74A09F;">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:#74A09F;" >{point.y:,.0f}</td></tr>{/each}',
      #         footerFormat: '</table>',
      #         useHTML: true,
      #         shared: true,
      #       },
      #     }
      advanced_vis_config: |-
        {
          chart: {
            spacingBottom: 20,
          },
          legend: {
            verticalAlign: 'top',
          },
          xAxis: {
            crosshair: true,
            labels: {
              angle: 0,
              style: {
                cursor: 'pointer',
                fontSize: '11px',
                color: 'inherit',
                textOverflow: 'none',
              },
            },
          },
          tooltip: {
            format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}</td></tr>{/each}',
              footerFormat: '</table>',
              shared: true,
              crosshairs: true,
              shadow: true,
              borderColor: '#CCCCCC',
              backgroundColor: '#FFFFFF',
            },
          }
      note_state: collapsed
      note_display: hover
      note_text: |-
        <div style="text-align: left;">
        Customers are ranked in descending order by average adjustment amount across invoice lines.
        </br></br>Average List Price and Average Adjusted Price across invoice lines with an adjustment are shown as columns.
        </br>
        </div>
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      row: 16
      col: 0
      width: 24
      height: 7
#####################################################################################################
    - name: product_intercompany_prices
      title: Products with Greatest Intercompany Pricing Adjustments
      explore: billing
      # type: looker_line
      type: looker_column
      fields: [billing.material_number_matnr,
               billing.material_text_maktx,
               sales_order_pricing_sdt.average_list_price_target_currency,
               sales_order_pricing_sdt.average_intercompany_price_target_currency,
               sales_order_pricing_sdt.absolute_difference_list_and_intercompany_price_target_currency]
      hidden_fields: [billing.material_number_matnr,
                      sales_order_pricing_sdt.absolute_difference_list_and_intercompany_price_target_currency]
      filters:
        sales_order_pricing_sdt.intercompany_price: NOT NULL
      sorts: [sales_order_pricing_sdt.absolute_difference_list_and_intercompany_price_target_currency desc]
      limit: 500
      column_limit: 50
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: false
      show_y_axis_ticks: true
      show_x_axis_label: false
      x_axis_label_rotation: 0
      show_x_axis_ticks: true
      y_axis_scale_mode: linear
      legend_position: center
      point_style: circle
      show_value_labels: true
      show_null_points: false
      interpolation: step
      y_axes: [{label: 'Avg Prices when Intercompany Adjustment', orientation: left,
                series: [{axisId: sales_order_pricing_sdt.average_list_price_target_currency,
                              id: sales_order_pricing_sdt.average_list_price_target_currency,
                            name: Average List Price when intercompany},
                        {axisId: sales_order_pricing_sdt.average_intercompany_price_target_currency,
                              id: sales_order_pricing_sdt.average_intercompany_price_target_currency,
                            name: Average Intercompany Price when intercompany}],
                            showLabels: false, showValues: false,},
                # {label: 'Discount percentages', orientation: right,
                #     series: [{axisId: sales_invoices__lines.average_percent_discount_when_taken_formatted,
                #                   id: sales_invoices__lines.average_percent_discount_when_taken_formatted,
                #                 name: Average % Discount},
                #             {axisId: sales_invoices__lines.discount_invoice_line_percent_formatted,
                #                 id: sales_invoices__lines.discount_invoice_line_percent_formatted,
                #               name: Frequency of Discounts}],
                #   showLabels: true, showValues: true, minValue: 0, }
                  ]
      limit_displayed_rows: true
      limit_displayed_rows_values:
        show_hide: show
        first_last: first
        num_rows: '5'
      series_types:
        sales_order_pricing_sdt.average_list_price_target_currency: column
        sales_order_pricing_sdt.average_intercompany_price_target_currency: column
      series_labels:
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: "Average Discount %"
        # sales_invoices__lines.discount_invoice_line_percent_formatted: "Discount Frequency (% of Invoice Lines)"
        # sales_order_pricing_sdt.average_list_price_target_currency: "Average Unit List Price"
        # sales_invoices__lines.average_gross_unit_selling_price_when_discount_target_currency: "Average Gross Unit Selling Price"
      series_colors:
        sales_order_pricing_sdt.average_list_price_target_currency: "#76B5C5"
        sales_order_pricing_sdt.average_intercompany_price_target_currency: "#45818E"
        # sales_invoices__lines.discount_invoice_line_percent_formatted: "#192D54"
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: "#873E23"
      # series_point_styles:
        # sales_invoices__lines.average_percent_discount_when_taken_formatted: triangle
      # advanced_vis_config: |-
      #   {
      #     series: [
      #       {
      #         id: 'sales_invoices__lines.average_percent_discount_when_taken_formatted',
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.1f}%</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #         dataLabels: {
      #           format: '{y:.1f}%',
      #           color: '#873E23',
      #           allowOverlap: false,
      #         },
      #       },
      #       {
      #         id: 'sales_invoices__lines.discount_invoice_line_percent_formatted',
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.1f}%</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #         dataLabels: {
      #           format: '{y:.1f}%',
      #           color: '#192D54',
      #           allowOverlap: false,
      #         },
      #         type: 'line',
      #         dashStyle: "dash",
      #       },
      #       {
      #         id: 'sales_invoices__lines.average_unit_list_price_when_discount_target_currency',
      #         dataLabels: {
      #           enabled: false,
      #         },
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #       },
      #       {
      #         id: 'sales_invoices__lines.average_unit_selling_price_when_discount_target_currency',
      #         dataLabels: {
      #           enabled: false,
      #         },
      #         tooltip: {
      #           headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
      #           pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>',
      #           footerFormat: '</table>',
      #           shared: true,
      #         },
      #       },
      #     ],
      #     tooltip: {
      #       backgroundColor: '#FFFFFF',
      #       formatter: null,
      #       shared: true,
      #       crosshairs: true,
      #       shadow: true,
      #     },
      #   }
      # advanced_vis_config: |-
      #   {
      #     tooltip: {
      #       backgroundColor: '#FFFFFF',
      #       shadow: true,
      #       format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:#74A09F;">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:#74A09F;" >{point.y:,.0f}</td></tr>{/each}',
      #         footerFormat: '</table>',
      #         useHTML: true,
      #         shared: true,
      #       },
      #     }
      advanced_vis_config: |-
        {
          chart: {
            spacingBottom: 20,
          },
          legend: {
            verticalAlign: 'top',
          },
          xAxis: {
            crosshair: true,
            labels: {
              angle: 0,
              style: {
                cursor: 'pointer',
                fontSize: '11px',
                color: 'inherit',
                textOverflow: 'none',
              },
            },
          },
          tooltip: {
            format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}</td></tr>{/each}',
              footerFormat: '</table>',
              shared: true,
              crosshairs: true,
              shadow: true,
              borderColor: '#CCCCCC',
              backgroundColor: '#FFFFFF',
            },

          }
      note_state: collapsed
      note_display: hover
      note_text: |-
        <div style="text-align: left;">
        Products are ranked in descending order by absolute difference between average list price and average intercompany price across invoice lines.
        </br></br>Average List Price and Average Intercompany Price across invoice lines with an intercompany transfer are shown as columns.
        </br>
        </div>
      listen:
        date: billing.billing_date_fkdat_date
        customer_country: countries_md.country_name_landx
        customer_name: billing.customer_name
        sales_org: sales_organizations_md.sales_org_name_vtext
        distribution_channel: distribution_channels_md.distribution_channel_name_vtext
        division: billing.division_name_vtext
        product: billing.material_text_maktx
        target_currency: otc_common_parameters_xvw.parameter_target_currency
      row: 16
      col: 0
      width: 24
      height: 7