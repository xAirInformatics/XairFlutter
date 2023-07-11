import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../consts/style.dart';

class AlertsPerRegionChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AlertsPerRegionChart({Key? key}) : super(key: key);

  @override
  _AlertsPerRegionChartState createState() => _AlertsPerRegionChartState();
}

class _AlertsPerRegionChartState extends State<AlertsPerRegionChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('A', 12),
      _ChartData('B', 15),
      _ChartData('C', 30),
      _ChartData('D', 6.4),
      _ChartData('E', 14),
      _ChartData('F', 12),
      _ChartData('G', 15),
      _ChartData('H', 30),
      _ChartData('I', 6.4),
      _ChartData('J', 14),
      _ChartData('K', 15),
      _ChartData('L', 30),
      _ChartData('M', 6.4),
      _ChartData('N', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationDark,
      padding: kPadding8,
      margin: kPadding8,
      child: SfCartesianChart(
          title: ChartTitle(
            alignment: ChartAlignment.near,
            text: "Alerts Per Region",
            textStyle: kChartsTitleTextStyle
          ),
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
          tooltipBehavior: _tooltip,
          series: <ChartSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Alerts',
                width: .3,
                color: kRed)
          ]),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
