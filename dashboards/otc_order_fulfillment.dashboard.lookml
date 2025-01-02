#########################################################{
# Order Fulfillment dashboard provides insights into
# fulfillment performance over time, items with longest average
# order cycle time and items having fulfillment issues.
#
# Extends otc_template_orders and modifies to:
#   update dashboard_navigation to set parameter_navigation_focus_page: '3'
#
# Visualization Elements:
#   in_full - single value
#   on_time - single value
#   otif - single value
#   late_delivery - single value
#   delivery_performance_by_month - line chart
#   average_cycle_time - bar chart
#   delivery_efficiency - column + line chart
#
#########################################################}

- dashboard: otc_order_fulfillment
  title: Order Fulfillment
  description: "See delivery performance over time, items with longest average order cycle time, and items currently having fulfillment issues."
  extends: otc_template
#####################################################################################################
  elements:
  - name: dashboard_navigation
    filters:
      otc_dashboard_navigation_xvw.parameter_navigation_focus_page: '3'
#####################################################################################################
  - name: in_full
    title: In Full %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
             sales_order_item_delivery_summary_ndt.on_time_order_percent,
             sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
             sales_order_item_delivery_summary_ndt.late_order_percent]
    hidden_fields: [sales_order_item_delivery_summary_ndt.on_time_order_percent,
                    sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
                    sales_order_item_delivery_summary_ndt.late_order_percent]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders delivered completely (for all line items)."
    row: 2
    col: 6
    width: 6
    height: 3
#####################################################################################################
  - name: on_time
    title: On Time %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
              sales_order_item_delivery_summary_ndt.late_order_percent]
    hidden_fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
                    sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
                    sales_order_item_delivery_summary_ndt.late_order_percent]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders delivered by the promised delivery date."
    row: 2
    col: 0
    width: 6
    height: 3
#####################################################################################################
  - name: otif
    title: OTIF %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
              sales_order_item_delivery_summary_ndt.late_order_percent]
    hidden_fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
                    sales_order_item_delivery_summary_ndt.on_time_order_percent,
                    sales_order_item_delivery_summary_ndt.late_order_percent]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders delivered completely (for all line items) by the promised delivery date."
    row: 2
    col: 12
    width: 6
    height: 3
#####################################################################################################
  - name: late_delivery
    title: Late Delivery %
    explore: sales_orders_v2
    type: single_value
    fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_order_percent,
              sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent,
              sales_order_item_delivery_summary_ndt.late_order_percent]
    hidden_fields: [sales_order_item_delivery_summary_ndt.in_full_order_percent,
                    sales_order_item_delivery_summary_ndt.on_time_order_percent,
                    sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    enable_conditional_formatting: true
    conditional_formatting: [{type: greater than, value: 0.05, background_color: '',
        font_color: "#DB4C40", bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_state: collapsed
    note_display: hover
    note_text: "The percentage of sales orders not fully delivered by the promised delivery date."
    row: 2
    col: 18
    width: 6
    height: 3
#####################################################################################################
  - name: delivery_performance_by_month
    title: Delivery Performance by Month
    explore: sales_orders_v2
    type: looker_line
    fields: [sales_orders_v2.creation_date_erdat_month,
            sales_order_item_delivery_summary_ndt.on_time_order_percent_formatted,
            sales_order_item_delivery_summary_ndt.in_full_order_percent_formatted,
            sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent_formatted]
    sorts: [sales_orders_v2.creation_date_erdat_month]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
    legend_position: center
    point_style: none
    y_axis_combined: true
    show_null_points: false
    discontinuous_nulls: true
    interpolation: linear
    y_axes: []
    x_axis_label: Month
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      sales_order_item_delivery_summary_ndt.on_time_order_percent_formatted: "#F39B6D"
      sales_order_item_delivery_summary_ndt.in_full_order_percent_formatted: "#6494AA"
      sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent_formatted: "#89BD9E"
    series_labels:
      sales_order_item_delivery_summary_ndt.on_time_order_percent_formatted: On Time %
      sales_order_item_delivery_summary_ndt.in_full_order_percent_formatted: In Full %
      sales_order_item_delivery_summary_ndt.on_time_and_in_full_order_percent_formatted: OTIF %
    x_axis_datetime_label: "%B %y"
    advanced_vis_config: |-
      {
        tooltip: {
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080; ">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:.1f}%</td></tr>{/each}',
            footerFormat: '</table>',
            shared: true,
            crosshairs: true,
            shadow: true,
            borderColor: '#CCCCCC',
            backgroundColor: '#FFFFFF',
          },
          yAxis: {
            labels: {
              format: '{text}%' ,
            },
            ceiling: 102,
            endOnTick: false,
            maxPadding: 0.2,
          },
        }
    note_state: collapsed
    note_display: hover
    note_text: "Monthly tracking of order on-time and in-full delivery. In Full % is the percentage of sales orders where all order lines have been fulfilled. On Time in Full (OTIF) % is the percentage of sales orders that have been fulfilled completely by the requested delivery date."
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 5
    col: 0
    width: 12
    height: 6
#####################################################################################################
  - name: avg_order_cycle_time
    title: Products with Longest Average Order Cycle Time (Days)
    explore: sales_orders_v2
    type: looker_bar
    fields: [sales_orders_v2.material_number_matnr,
             sales_orders_v2.material_text_maktx,
             sales_order_item_delivery_summary_ndt.avg_order_cycle_time]
    sorts: [sales_order_item_delivery_summary_ndt.avg_order_cycle_time desc]
    hidden_fields: [sales_orders_v2.material_number_matnr]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
      sales_order_item_delivery_summary_ndt.is_order_delivered_in_full: "Yes"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    legend_position: center
    point_style: none
    # show_value_labels: false
    # label_density: 25
    # x_axis_scale: auto
    # y_axis_combined: true
    # ordering: none
    # show_null_labels: false
    # show_totals_labels: false
    # show_silhouette: false
    # totals_color: "#808080"
    y_axes: [{label: Average Order Cycle Time, orientation: bottom,
            series: [{axisId: across_sales_and_deliveries_xvw.avg_distinct_order_cycle_time,
                          id: sales_order_item_delivery_summary_ndt.avg_order_cycle_time,
                          name: Average of Order Cycle Time}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 1, type: linear}]
    x_axis_label: ""
    # x_axis_zoom: true
    # y_axis_zoom: true
    series_colors:
      sales_order_item_delivery_summary_ndt.avg_order_cycle_time: "#B3DEE2"
    reference_lines: [{reference_type: line, range_start: min, range_end: max, margin_top: deviation,
      margin_value: mean, margin_bottom: deviation, label_position: left, color: "#000000",
      label: '', line_value: max}, {reference_type: line, line_value: min, range_start: max,
      range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
      label_position: right, color: "#000000"}]
    # advanced_vis_config: "{\n  yAxis: [{\n \n    plotLines: [{\n        color: '#transparent',\n\
    #     \        label: {\n          align: 'center',\n          verticalAlign: 'top',\n\
    #     \          x: -5,\n          y: 2,\n        },\n    \n      },\n      {\n  \
    #     \      color: '#transparent',\n        label: {\n          align: 'center',\n\
    #     \          verticalAlign: 'bottom',\n          x: 0,\n          y: -1,\n   \
    #     \     },\n        \n      },\n    ],\n    \n\n  }, ],\n}"
    advanced_vis_config: |-
      {
        tooltip: {
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:.1f}</td></tr>{/each}',
            footerFormat: '</table>',
            shared: true,
            crosshairs: true,
            borderColor: '#CCCCCC',
            backgroundColor: '#FFFFFF',
            shadow: true,
          },
          yAxis: [{
            plotLines: [{
            color: '#transparent',
            label: {
            align: 'right',
            verticalAlign: 'top',
            x: -5,
            y: 2,
            },
            },
            {
            color: '#transparent',
            label: {
            align: 'left',
            verticalAlign: 'bottom',
            x: 0,
            y: -1,
            },
            },
          ]
        }, ],
      }
    note_display: hover
    note_text: Limited to 10 products ranked in descending order by Avg Order Cycle Time
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    note_state: collapsed
    note_display: hover
    note_text: "Order cycle time is average number of days between order placement and order delivery. "
    row: 5
    col: 12
    width: 12
    height: 6
#####################################################################################################
  - name: delivery_efficiency
    title: Order vs Delivery Efficiency
    explore: sales_orders_v2
    type: looker_line
    fields: [ sales_orders_v2.material_number_matnr,
              sales_orders_v2.material_text_maktx,
              sales_orders_v2.total_ordered_quantity,
              deliveries.total_delivered_quantity,
              across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty
              ]
    sorts: [across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty desc]
    hidden_fields: [materials_md.material_number_matnr]
    filters:
      sales_orders_v2.document_category_vbtyp: 'C'
      across_sales_and_billing_summary_xvw.order_status: '-Cancelled'
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    show_x_axis_label: false
    show_x_axis_ticks: true
    legend_position: center
    point_style: circle
    show_value_labels: true
    show_null_points: false
    discontinuous_nulls: true
    interpolation: step
    y_axes: [{label: 'Quantities', orientation: left,
              series: [{axisId: sales_orders_v2.total_ordered_quantity,
                            id: sales_orders_v2.total_ordered_quantity,
                          name: Total Ordered Quantity},
                      {axisId: deliveries.total_delivered_quantity,
                           id: deliveries.total_delivered_quantity,
                         name: Total Delivered Quantity}], showLabels: true, showValues: true, },
            {label: 'Difference', orientation: right,
              series: [{axisId: across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
                            id: across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty,
                          name: Difference Ordered Delivered Quantity}], showLabels: true, showValues: true,}]
    x_axis_label: Item
    series_types:
      sales_orders_v2.total_ordered_quantity: column
      deliveries.total_delivered_quantity: column
      across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty: line
    series_colors:
      sales_orders_v2.total_ordered_quantity: "#12B5CB"
      deliveries.total_delivered_quantity: "#A6CFD5"
      across_sales_and_deliveries_xvw.difference_order_qty_delivery_qty: "#404040"
    series_labels:
      sales_orders_v2.total_ordered_quantity: Total Ordered Quantity
      deliveries.total_delivered_quantity: Total Delivered Quantity
    x_axis_label_rotation: 0
    advanced_vis_config: |-
      {
        chart: {
          spacingBottom: 60,
        },
        series: [{
          name: 'Total Ordered Quantity',
          dataLabels: {
            enabled: false,
          }
          }, {
          name: 'Total Delivered Quantity',
          dataLabels: {
            enabled: false,
          }
          },
          {
          name: 'Difference',
          lineWidth: 1,
          },
        ],
        legend: {
          verticalAlign: 'top',
        },
        tooltip: {
          format: '<table><th style="font-size: 1.8em;text-align: left;color: #808080;">{key}</th></table><table>{#each points}<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f}</td></tr>{/each}',
          footerFormat: '</table>',
          shared: true,
          crosshairs: true,
          borderColor: '#CCCCCC',
          backgroundColor: '#FFFFFF',
          shadow: true,
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
      }
    note_state: collapsed
    note_display: above
    note_text: "Top 10 Items with Largest Difference between Quantity Ordered and Delivered"
    listen:
      date: sales_orders_v2.creation_date_erdat_date
      customer_country: countries_md.country_name_landx
      customer_name: sales_orders_v2.customer_name
      sales_org: sales_organizations_md.sales_org_name_vtext
      distribution_channel: distribution_channels_md.distribution_channel_name_vtext
      division: sales_orders_v2.division_name_vtext
      product: sales_orders_v2.material_text_maktx
      # target_currency: otc_common_parameters_xvw.parameter_target_currency
    row: 12
    col: 0
    width: 24
    height: 12