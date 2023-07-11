import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xair/screens/home/tables.dart';
import '../../components/side_bar.dart';
import '../../consts/style.dart';
import '../../networking/select_alerts.dart';
import 'charts.dart';
import 'components/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundDarkColor,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  color: kBackgroundLightColor,
                  width: MediaQuery.of(context).size.width - 50,
                  margin: const EdgeInsets.only(
                    left: 50,
                  ),
                  height: 70,
                ),
                Container(
                  height: 90,
                  padding: const EdgeInsets.only(left: 70),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hello <User>",
                    style: kTopTitleTextStyle.copyWith(fontSize: 35),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 160,
                        margin: const EdgeInsets.only(
                          left: 70,
                          right: 20,
                        ),
                        padding: kPadding20,
                        decoration: kBoxDecorationLight,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Indicators Summary",
                                        style: kTopTitleTextStyle,
                                      ),
                                      IconButton(onPressed: (){
                                        setState(() {

                                        });
                                      }, icon: Icon(Icons.refresh)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          PopupMenuButton(
                                            itemBuilder:
                                                (BuildContext context) {
                                              return ['as json', 'as csv']
                                                  .map((String option) {
                                                return PopupMenuItem(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList();
                                            },
                                            onSelected:
                                                (String selectedOption) {
                                              print(
                                                  'Selected option: $selectedOption');
                                              // Perform action based on selected option
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                              decoration: kBoxDecorationDark,
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                      Icons.play_arrow_rounded),
                                                  Text("Extract"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  final DateTime? picked =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: _fromDate,
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2024),
                                                  );
                                                  if (picked != null &&
                                                      picked != _fromDate) {
                                                    if (picked
                                                        .isAfter(_toDate)) {
                                                      // ignore: use_build_context_synchronously
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Error'),
                                                            content: const Text(
                                                                'Invalid input. Please try again.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                                onPressed: () {
                                                                  setState(() {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _fromDate = picked;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.calendar_today,
                                                        size: 17,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(null != _fromDate
                                                          ? '${_fromDate.day} - ${_fromDate.month} - ${_fromDate.year}'
                                                          : 'From'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              TextButton(
                                                onPressed: () async {
                                                  final DateTime? picked =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: _toDate,
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2024),
                                                  );
                                                  if (picked != null &&
                                                      picked != _toDate) {
                                                    if (picked
                                                        .isBefore(_fromDate)) {
                                                      // ignore: use_build_context_synchronously
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Error'),
                                                            content: const Text(
                                                                'Invalid input. Please try again.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _toDate = picked;
                                                        if (kDebugMode) {
                                                          print(
                                                              "********************* $_toDate");
                                                        }
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.calendar_today,
                                                        size: 17,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          '${_toDate.day} - ${_toDate.month} - ${_toDate.year}'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      "Flights",
                                      style: kTitleTextStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: selectAlertNumbers( from:'${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
                                          to: '${_toDate.year}-${_toDate.month}-${_toDate.day}'),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ));
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          var snap = snapshot.data['message']['flights'][0]['g_elements'];
                                          if (snap.length != 0) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 3,
                                                  ),
                                                  itemCount: snap.length,
                                                  itemBuilder: (_, index) {
                                                    return AlertCard(
                                                      label: snap[index]
                                                          ['status'],
                                                      color: colorLists[index],
                                                      onTap: () {},
                                                      number: snap[index]
                                                          ['counter'],
                                                      type: 'f',
                                                    );
                                                  }),
                                            );
                                          } else {
                                            return const Text("No data");
                                          }
                                        }
                                      }),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      "Alerts",
                                      style: kTitleTextStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: selectAlertNumbers(from:'${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
                                          to: '${_toDate.year}-${_toDate.month}-${_toDate.day}'),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ));
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          var snap = snapshot.data['message']['alerts'][0]['g_elements'];
                                          if (snap.length != 0) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 4,
                                                  ),
                                                  itemCount: snap.length,
                                                  itemBuilder: (_, index) {
                                                    return AlertCard(
                                                      label: snap[index]
                                                          ['status'],
                                                      color: colorLists[index],
                                                      onTap: () {
                                                        if (kDebugMode) {
                                                          print(snap[index]
                                                              ['counter']);
                                                        }
                                                      },
                                                      number: snap[index]
                                                          ['counter'],
                                                      type: 'a',
                                                    );
                                                  }),
                                            );
                                          } else {
                                            return const Text("No data");
                                          }
                                        }
                                      }),
                                  FutureBuilder(
                                      future: selectAlertNumbers(from:'${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
                                          to: '${_toDate.year}-${_toDate.month}-${_toDate.day}'),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ));
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          var snap = snapshot.data['message']['alerts'][1]['g_elements'];
                                          if (snap.length != 0) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  4.5,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 3,
                                                  ),
                                                  itemCount: snap.length,
                                                  itemBuilder: (_, index) {
                                                    return AlertCard(
                                                      label: snap[index]
                                                      ['status'],
                                                      color: colorLists[index],
                                                      onTap: () {
                                                        if (kDebugMode) {
                                                          print(snap[index]
                                                          ['counter']);
                                                        }
                                                      },
                                                      number: snap[index]
                                                      ['counter'],
                                                      type: 'a',
                                                    );
                                                  }),
                                            );
                                          } else {
                                            return const Text("No data");
                                          }
                                        }
                                      }),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(bottom: 12),
                                  //   child: Text(
                                  //     "View",
                                  //     style: kTitleTextStyle,
                                  //     textAlign: TextAlign.left,
                                  //   ),
                                  // ),
                                  // const Padding(
                                    //   padding: EdgeInsets.only(bottom: 12),
                                    //   child: Text(
                                    //     "View",
                                    //     style: kTitleTextStyle,
                                    //     textAlign: TextAlign.left,
                                    //   ),
                                    // ),// HomeCharts(
                                  //   from: _fromDate,
                                  //   to: _toDate,
                                  // ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 12, top: 30),
                                    child: Text(
                                      "Alerts",
                                      style: kTitleTextStyle,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  HomeTables(
                                    from: _fromDate,
                                    to: _toDate,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding: kPadding20,
                          height: MediaQuery.of(context).size.height - 160,
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          decoration: kBoxDecorationLight,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Flights",
                                          style: kTitleTextStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "20/02/2020 -> 20/20/2023",
                                          style: kSubTitleTextStyle,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 200,
                                          child:
                                          FutureBuilder(
                                              future: selectAlertNumbers(from : '', to: ''),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ));
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  var snap =  snapshot.data['message']['flights'][0]['g_elements'];
                                                  if (snap.length != 0) {
                                                    return SizedBox(
                                                      height: 50 ,
                                                      child: ListView.builder(
                                                          itemCount:
                                                              snap.length,
                                                          itemBuilder:
                                                              (_, index) {
                                                            return AlertCard(
                                                              type: 'f',
                                                              label: snap[index]
                                                                  ['status'],
                                                              color: colorLists[
                                                                  index],
                                                              onTap: () {
                                                                if (kDebugMode) {
                                                                  print(snap[
                                                                          index]
                                                                      ['status']);
                                                                }
                                                              },
                                                              number: snap[
                                                                      index]
                                                                  ['counter'],
                                                            );
                                                          }),
                                                    );
                                                  } else {
                                                    return Text("No Data");
                                                  }
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Alerts",
                                          style: kTitleTextStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "20/02/2020 -> 20/20/2023",
                                          style: kSubTitleTextStyle,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 600,
                                          child: FutureBuilder(
                                              future: selectAlertNumbers(from : '', to: ''),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ));
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  var snap =  snapshot.data['message']['alerts'][0]['g_elements'];
                                                  if (snap.length != 0) {
                                                    return SizedBox(
                                                      height: 200,
                                                      child: ListView.builder(
                                                          itemCount:
                                                              snap.length,
                                                          itemBuilder:
                                                              (_, index) {
                                                            return AlertCard(
                                                              type: 'a',
                                                              label: snap[index]
                                                                  ['status'],
                                                              color: colorLists[
                                                                  index],
                                                              onTap: () {
                                                                if (kDebugMode) {
                                                                  print(snap[
                                                                          index]
                                                                      ['status']);
                                                                }
                                                              },
                                                              number: snap[
                                                                      index]
                                                                  ['counter'],
                                                            );
                                                          }),
                                                    );
                                                  } else {
                                                    return Text("No Data");
                                                  }
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Sidebar("Home"),
        ],
      ),
    );
  }
}
