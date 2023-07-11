import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:xair/consts/style.dart';

class AircraftChart extends StatelessWidget {
  const AircraftChart({Key? key, required this.data}) : super(key: key);

   final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecorationDark,
      margin: kPadding5,
      child: SfCircularChart(
        palette: colorLists,
        series: <CircularSeries>[
          PieSeries<Map<String, dynamic>, String>(
            dataSource: data,
            xValueMapper: (datum, _) => datum['type'],
            yValueMapper: (datum, _) => datum['number'],
            dataLabelMapper: (datum, _) => '${datum['type']}: ${datum['number']}',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          )
        ],
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        title: ChartTitle(text: 'Aircraft' , textStyle: kChartsTitleTextStyle, alignment: ChartAlignment.near),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );

  }
}


