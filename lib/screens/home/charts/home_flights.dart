import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xair/consts/style.dart';

class HomeAirportFlightChart extends StatefulWidget {
  @override
  State<HomeAirportFlightChart> createState() => _HomeAirportFlightChartState();
}

class _HomeAirportFlightChartState extends State<HomeAirportFlightChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Total', 27),
      _ChartData('Has Alerts', 15),
      _ChartData('No Alerts', 12),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationDark,
      padding: kPadding8,
      margin: EdgeInsets.all(4),
      child: SfCartesianChart(
          title: ChartTitle(text: "Flights From Home Airport", textStyle: kChartsTitleTextStyle,  alignment: ChartAlignment.near),
          primaryXAxis: CategoryAxis(
              labelStyle: TextStyle(fontSize: 9),
              labelIntersectAction: AxisLabelIntersectAction.rotate45),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
          tooltipBehavior: _tooltip,
          series: <ChartSeries<_ChartData, String>>[
            BarSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Alerts',
              width: 0.2,
              pointColorMapper: (data, index) {
                if (index == 0) {
                  return kBlue;
                } else if (index == 1) {
                  return kRed;
                } else if (index == 2) {
                  return kGreen;
                }
              },
            )
          ]),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
