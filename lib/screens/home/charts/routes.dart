import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xair/consts/style.dart';

class RoutesChart extends StatelessWidget {
  const RoutesChart({Key? key, required this.data}) : super(key: key);

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationDark,
      margin: kPadding5,
      child: SfCircularChart(
        series: <CircularSeries>[
          DoughnutSeries<Map<String, dynamic>, String>(
            dataSource: data,
            xValueMapper: (datum, _) => datum['route'],
            yValueMapper: (datum, _) => datum['number'],
            dataLabelMapper: (datum, _) => '${datum['route']}: ${datum['number']}',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          )
        ],
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        title: ChartTitle(text: 'Routes', textStyle: kChartsTitleTextStyle, alignment: ChartAlignment.near),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}