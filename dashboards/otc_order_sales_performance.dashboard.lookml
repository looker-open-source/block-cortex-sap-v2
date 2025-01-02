#########################################################{
# Order Sales Performance dashboard provides insights into
# top sales performers including items, divisions, customers,
# sales organizations, and distribution channels.
#
# Extends otc_template_orders and modifies to:
#   add filter product_level
#   update dashboard_navigation to set parameter_navigation_focus_page: '2'
#
# Visualization Elements:
#   top_products_by_sales - bar chart
#   top_products_by_avg_sales - bar chart
#   top_customers_by_sales - bar chart
#   top_customers_by_avg_sales - bar chart
#   top_sales_organizations_by_sales - bar chart
#   sales_by_distribution - donut chart (looker_pie)
#########################################################}

- dashboard: otc_order_sales_performance
  title: Sales Performance
  description: "Gain insights into top sales performers including items, divisions, customers, sales organizations, and distribution channels."
  extends: otc_template
#####################################################################################################
  filters:
  - name: product_level
    title: Product Level to Display
    type: field_filter
    default_value: "Item"
    allow_multiple_values: false
    required: false
    ui_config:
      type: button_toggles
      display: inline
    explore: sales_orders_v2
    field: sales_orders_v2.parameter_display_product_level
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '2'
#####################################################################################################
  - name: top_products_by_sales
    title: Top Products by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.selected_product_dimension_id,
             sales_orders_v2.selected_product_dimension_description,
             sales_orders_v2.total_sales_amount_target_currency_formatted,
            # sales_orders_v2.percent_of_total_sales_amount_target_currency
             ]
    sorts: [sales_orders_v2.total_sales_amount_target_currency_formatted desc]
    hidden_fields: [sales_orders_v2.selected_product_dimension_id]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    show_value_labels: true
    series_colors:
      sales_orders_v2.total_sales_amount_target_currency_formatted: "#74A09F"
      sales_orders_v2.percent_of_total_sales_amount_target_currency: "transparent"
    y_axes: [{label: '', orientation: bottom,
              series: [{axisId: sales_orders_v2.total_sales_amount_target_currency_formatted,
                            id: sales_orders_v2.total_sales_amount_target_currency_formatted
                      }], showLabels: true, showValues: false,
        }]
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: '#FFFFFF',
          shadow: true,
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:#74A09F;">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:#74A09F;" >{point.y:,.0f}</td></tr>{/each}',
          footerFormat: '</table>',
          useHTML: true,
          shared: true,
        },
      }
    note_display: hover
    note_text: |-
      <div style="text-align: left;">
      Top items or categories ranked in descending order by Total Sales.
      </br></br>Use the dashboard parameter <span style="color:#AECBFA;">Product Level to Display</span> to show either items or categories.
      </br></br>If Item is displayed, use the <span style="color:#AECBFA;">Language of Item Description</span> dashboard parameter to modify the description language.
      </br></br>Limited to 10 items or categories.
      To change:
      </br>1. Click the three-dot menu at the top right of tile
      and select 'Explore from here'.
      </br></br>2. In the Data pane, change the row limit to desired value.
      </div>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
      product_level: sales_orders_v2.parameter_display_product_level
    row: 2
    col: 0
    width: 12
    height: 10
#####################################################################################################
  - name: top_products_by_avg_sales
    title: Top Products by Average Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.selected_product_dimension_id,
             sales_orders_v2.selected_product_dimension_description,
             sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted]
    sorts: [sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted desc]
    hidden_fields: [sales_orders_v2.selected_product_dimension_id]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    show_value_labels: true
    series_colors:
      sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted: "#53575E"
    y_axes: [{label: '', orientation: bottom,
              series: [{axisId: sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted,
                            id: sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted,
                            name: Avg Sales per Order}], showLabels: true, showValues: false,
      }]
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: '#FFFFFF',
          shadow: true,
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>{/each}',
            footerFormat: '</table>',
            useHTML: true,
            shared: true,
          },
        }
    note_display: hover
    note_text: |-
      <div style="text-align: left;">
      Top items or categories ranked in descending order by Average Sales per Order.
      </br></br>Use the dashboard parameter <span style="color:#AECBFA;">Product Level to Display</span> to show either items or categories.

      </br></br>If Item is displayed, use the <span style="color:#AECBFA;">Language of Item Description</span> dashboard parameter to modify the description language.

      </br></br>Limited to 10 items or categories.
      To change:
      </br>1. Click the three-dot menu at the top right of tile
      and select 'Explore from here'.
      </br></br>2. In the Data pane, change the row limit to desired value.
      </div>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
      product_level: sales_orders_v2.parameter_display_product_level
    row: 2
    col: 12
    width: 12
    height: 10
#####################################################################################################
  - name: top_customers_by_sales
    title: Top Customers by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [ sales_orders_v2.sold_to_party_kunnr,
              sales_orders_v2.customer_name,
              sales_orders_v2.total_sales_amount_target_currency_formatted,
              sales_orders_v2.total_sales_amount_target_currency,
              sales_orders_v2.cumulative_sales_amount_target_currency]
    sorts: [sales_orders_v2.total_sales_amount_target_currency_formatted desc]
    hidden_fields: [sales_orders_v2.sold_to_party_kunnr,
                    sales_orders_v2.cumulative_sales_amount_target_currency,
                    sales_orders_v2.total_sales_amount_target_currency]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "(${sales_orders_v2.cumulative_sales_amount_target_currency}\
        \ / ${sales_orders_v2.total_sales_amount_target_currency:total})*100"
      label: Cumulative Percent of Total Sales
      value_format_name: decimal_1
      _kind_hint: measure
      table_calculation: cumulative_percent_of_total_sales
      _type_hint: number
    legend_position: center
    point_style: circle
    show_value_labels: true
    y_axes: [{label: '', orientation: bottom,
              series: [{axisId: sales_orders_v2.total_sales_amount_target_currency_formatted,
                            id: sales_orders_v2.total_sales_amount_target_currency_formatted,
                          name: Total Sales Amount}],
                          showLabels: false, showValues: false,},
            {label: '', orientation: bottom,
              series: [{axisId: cumulative_percent_of_total_sales,
                            id: cumulative_percent_of_total_sales,
                            name: Cumulative Percent of Total Sales}],
                            showLabels: false, showValues: false, }]
    series_types:
      cumulative_percent_of_total_sales: line
    series_colors:
      sales_orders_v2.total_sales_amount_target_currency_formatted: "#74A09F"
      cumulative_percent_of_total_sales: "#000000"
    advanced_vis_config: |-
      {
        series: [
          {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>',
            footerFormat: '</table>',
          },
          },
          {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.1f}%</td></tr>',
            footerFormat: '</table>',
          },
          dataLabels: {
            format: '{y:.0f}%',
            color: '#000000',
            align: 'left',
            allowOverlap: false,
          },
          },
        ],
        tooltip: {
          backgroundColor: '#FFFFFF',
          shared: true,
          formatter: null,
          shadow: true,
        },
      }
    note_display: hover
    note_text: |-
      <div style="text-align: left;">
      Top customers ranked in descending order by Total Sales. The black line reflects a customer's Cumulative Percent of Total Sales.
      </br></br>Use the dashboard parameter <span style="color:#AECBFA;">Customer Type</span> to show either Bill To or Sold To Customers.

      </br></br>Limited to 10 customers.
      To change:
      </br>1. Click the three-dot menu at the top right of tile
      and select 'Explore from here'.
      </br></br>2. In the Data pane, change the row limit to desired value.
      </div>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 20
    col: 0
    width: 12
    height: 10
#####################################################################################################
  - name: top_customers_by_avg_sales
    title: Top Customers by Average Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.sold_to_party_kunnr,
             sales_orders_v2.customer_name,
             sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted]
    sorts: [sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted desc]
    hidden_fields: [sales_orders_v2.sold_to_party_kunnr]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    show_value_labels: true
    series_colors:
      sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted: "#53575E"
    y_axes: [{label: '', orientation: bottom,
              series: [{axisId: sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted,
                            id: sales_orders_v2.average_ordered_amount_per_order_target_currency_formatted}], showLabels: true, showValues: false,}]
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: '#FFFFFF',
          shadow: true,
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>{/each}',
            footerFormat: '</table>',
            useHTML: true,
            shared: true,
          },
        }
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_display: hover
    note_text: |-
      <div style="text-align: left;">
      Top customers ranked in descending order by Average Sales per Order.
      </br></br>Use the dashboard parameter <span style="color:#AECBFA;">Customer Type</span> to show either Bill To or Sold To Customers.

      </br></br>Limited to 10 customers.
      To change:
      </br>1. Click the three-dot menu at the top right of tile
      and select 'Explore from here'.
      </br></br>2. In the Data pane, change the row limit to desired value.
      </div>
    row: 20
    col: 12
    width: 12
    height: 10
#####################################################################################################
  - name: top_sales_organization_by_sales
    title: Top Sales Organizations by Sales
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.sales_organization_vkorg,
             sales_organizations_md.sales_org_name_vtext,
             sales_orders_v2.total_sales_amount_target_currency_formatted]
    sorts: [sales_orders_v2.total_sales_amount_target_currency_formatted desc]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: false
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    legend_position: center
    point_style: none
    show_value_labels: true
    series_colors:
      sales_orders_v2.total_sales_amount_target_currency_formatted: "#74A09F"
    y_axes: [{label: '', orientation: bottom,
              series: [{axisId: sales_orders_v2.total_sales_amount_target_currency_formatted,
                            id: sales_orders_v2.total_sales_amount_target_currency_formatted,
                          name: Total Sales}],
          showLabels: true, showValues: false,
              }]
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: '#FFFFFF',
          shadow: true,
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>{/each}',
            footerFormat: '</table>',
            useHTML: true,
            shared: true,
          },
        }
    note_display: hover
    note_text: |-
      <div style="text-align: left;">
      Top business units ranked in descending order by Average Sales per Order.

      </br></br>Limited to 10 business units.
      To change:
      </br>1. Click the three-dot menu at the top right of tile
      and select 'Explore from here'.
      </br></br>2. In the Data pane, change the row limit to desired value.
      </div>
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 21
    col: 0
    width: 12
    height: 10
#####################################################################################################
  - name: sales_by_distribution_channel
    title: Sales by Distribution Channel
    explore: sales_orders_v2
    type: looker_pie
    fields: [ sales_orders_v2.distribution_channel_vtweg,
              distribution_channels_md.distribution_channel_name_vtext,
              sales_orders_v2.total_sales_amount_target_currency_formatted]
    sorts: [sales_orders_v2.total_sales_amount_target_currency_formatted desc 0]
    hidden_fields: [sales_orders_v2.distribution_channel_vtweg]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    limit: 10
    value_labels: labels
    label_type: labVal
    inner_radius: 50
    color_application:
      collection_id: 9d1da669-a6b4-4a4f-8519-3ea8723b79b5
      palette_id: 0c5264fb-0681-4817-b9a5-d3c81002ce4c
      options:
        steps: 5
        reverse: true
    advanced_vis_config: |-
      {
        tooltip: {
          enabled: false,
        },
        plotOptions: {
          pie: {
            dataLabels: {
              enabled: true,
              format: '<b>{key}</b><span style="font-size: 80%; font-weight: normal"> <br>{percentage:.1f}%<br>{point.rendered}</span>',
            }
          }
        },
        title: {
          text: '<br>Distribution<br>Channel',
          align: 'center',
          verticalAlign: 'middle',
          style: {
                fontSize: '150%',
                fontWeight: 'bold',
              },
        }
      }
    show_value_labels: true
    title_hidden: true
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 21
    col: 12
    width: 12
    height: 10