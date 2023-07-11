import 'package:flutter/material.dart';
import 'charts/aircraft.dart';
import 'charts/alerts_per_region.dart';
import 'charts/home_flights.dart';
import 'charts/routes.dart';

class HomeCharts extends StatelessWidget {
  const HomeCharts({Key? key, required this.from, required this.to})
      : super(key: key);

  final DateTime from;
  final DateTime to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: Row(
            children: [
              const RoutesChart(data: [
                {"route": "p2", "number": 5},
                {"route": "p1", "number": 7}
              ]),
              const AircraftChart(data: [
                {"type": "p1", "number": 5},
                {"type": "p2", "number": 2},
                {"type": "p3", "number": 1},
                {"type": "p4", "number": 10}
              ]),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: HomeAirportFlightChart()),
                    Expanded(child: HomeAirportFlightChart()),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 400, child: AlertsPerRegionChart())
      ],
    );

    // FutureBuilder(
    //   future: selectAlertsHome( '${from.year}-${from.month}-${from.day}', '${to.year}-${to.month}-${to.day}'),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //           child: CircularProgressIndicator(
    //             color: Colors.white,
    //           ));
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       var snap = snapshot.data['message']['alerts'];
    //       if (kDebugMode) {
    //         print(snap);
    //       }
    //       return SizedBox(
    //         height: 400,
    //         child: ListView.builder(
    //           itemCount: snap.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             ListItem item = ListItem(
    //                 title: snap[index]['type'],
    //                 alerts: snap[index]['alerts']);
    //             return Card(
    //               color: kBackgroundDarkColor,
    //               elevation: 2.0,
    //               margin: const EdgeInsets.symmetric(
    //                   horizontal: 8.0, vertical: 4.0),
    //               child: Theme(
    //                 data: ThemeData(
    //                     dividerColor: Colors.transparent
    //                 ),
    //                 child: ExpansionTile(
    //                   iconColor: Colors.white,
    //                   collapsedIconColor: Colors.white,
    //                   textColor: Colors.white,
    //                   collapsedTextColor: Colors.white70,
    //                   backgroundColor: kBackgroundDarkColor,
    //                   title: Text(
    //                     item.title,
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16.0,
    //                     ),
    //                   ),
    //                   onExpansionChanged: (bool isExpanded) {
    //                     // Update the isExpanded property of the corresponding ListItem object
    //                     item.isExpanded = isExpanded;
    //                   },
    //                   initiallyExpanded: item.isExpanded,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                         horizontal: 16.0,
    //                         vertical: 8.0,
    //                       ),
    //                       child:Table(
    //                         columnWidths: const {
    //                           0: FractionColumnWidth(0.4),
    //                           1: FractionColumnWidth(0.3),
    //                           2: FractionColumnWidth(0.3),
    //                         },
    //                         children: [
    //                           const TableRow(
    //                             decoration: BoxDecoration(
    //                               border: Border(
    //                                 top: BorderSide(width: 1, color: Colors.grey),
    //                                 bottom: BorderSide(width: 1, color: Colors.grey),
    //                               ),
    //                             ),
    //                             children: [
    //                               TableCell(
    //                                 child: Padding(
    //                                   padding: kPadding5,
    //                                   child: Text('Flight'),
    //                                 ),
    //                               ),
    //                               TableCell(
    //                                 child: Padding(
    //                                   padding: kPadding5,
    //                                   child: Text('Date'),
    //                                 ),
    //                               ),
    //                               TableCell(
    //                                 child: Padding(
    //                                   padding: kPadding5,
    //                                   child: Text('Alert Text'),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           ...item.alerts.map((item) {
    //                             return TableRow(
    //                               children: [
    //                                 TableCell(
    //                                   child: Text(item['flight'].toString()),
    //                                 ),
    //                                 TableCell(
    //                                   child: Text(item['flight_date'].toString()),
    //                                 ),
    //                                 TableCell(
    //                                   child: Text(item['alert_text'].toString()),
    //                                 ),
    //                               ],
    //                             );
    //                           }).toList(),
    //                         ],
    //
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     }
    //   });
  }
}

class ListItem {
  final String title;
  final List alerts;
  bool isExpanded;

  ListItem({
    required this.title,
    required this.alerts,
    this.isExpanded = false,
  });
}
