import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xair/consts/style.dart';
import '../../networking/select_alerts.dart';
import 'home.dart';

class HomeTables extends StatelessWidget {
  const HomeTables({Key? key, required this.from, required this.to}) : super(key: key);
  final DateTime from;
  final DateTime to;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: selectAlertsHome('${from.year}-${from.month}-${from.day}',
            '${to.year}-${to.month}-${to.day}'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var snap = snapshot.data['message']['alerts'];
            if (snap.length == 0) {
              return const Text("No data");
            } else {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (BuildContext context, int index) {
                    ListItem item = ListItem(
                        title: snap[index]['type'],
                        columns: snap[index]['columns'],
                        data: snap[index]['alerts']);
                    return Card(
                      color: kBackgroundDarkColor,
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          textColor: Colors.white,
                          collapsedTextColor: Colors.white70,
                          backgroundColor: kBackgroundDarkColor,
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          onExpansionChanged: (bool isExpanded) {
                            // Update the isExpanded property of the corresponding ListItem object
                            item.isExpanded = isExpanded;
                          },
                          initiallyExpanded: item.isExpanded,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Table(
                                children: [
                                      TableRow(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 1, color: Colors.grey),
                                            bottom: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                        ),
                                        children: List.generate(
                                                item.columns.length, (index) {
                                              return TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding: kPadding5,
                                                  child: Text(item
                                                      .columns[index]
                                                      .toString()),
                                                ),
                                              );
                                            }) +
                                            [
                                              const TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Text("Action"),
                                              )
                                            ],
                                      ),
                                    ] +
                                    List.generate(item.data.length, (rIndex) {
                                      return TableRow(
                                          children: List.generate(
                                                  item.columns.length,
                                                  (cIndex) {
                                                return TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Text(
                                                        "${item.data[rIndex]['${item.columns[cIndex]}']}"));
                                              }) +
                                              [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: PopupMenuButton(
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return [
                                                          'Assign',
                                                          'Email',
                                                          'Print'
                                                        ].map((String option) {
                                                          return PopupMenuItem(
                                                            value: option,
                                                            child: Text(option),
                                                            // onTap: (){_dialogBuilder(context);},
                                                          );
                                                        }).toList();
                                                      },
                                                      onSelected: (String
                                                          selectedOption) {
                                                        _dialogBuilder(context,
                                                            '${item.data[rIndex]['name']}');
                                                        // Perform action based on selected option
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        decoration:
                                                            kBoxDecorationDark,
                                                        child: const Icon(
                                                          Icons.more_vert,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ))
                                              ]);
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        });
  }

  Future<void> _dialogBuilder(BuildContext context, alert_name) {
    // Replace this with your own list
    String _selectedItem;
    DateTime _toDate = DateTime.now().add(const Duration(days: 5));
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assign To User'),
          content: FutureBuilder(
            future: selectUsers(),
            // Replace this with your own future that fetches the data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var snap = snapshot.data['data'];
              final List newList =
                  snap.map((e) => e['name'] as String).toList();
              final List<String> stringList =
                  List<String>.from(newList.map((e) => e.toString()));
              _selectedItem = stringList[0];
              return StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text('Assign To: '),
                    Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        return stringList
                            .where((item) =>
                                item.toString().contains(textEditingValue.text))
                            .toList();
                      },
                      onSelected: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('To Date: '),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _toDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2024),
                        );
                        if (picked != null && picked != _toDate) {
                          if (picked.isBefore(DateTime.now())) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Invalid input. Please try again.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            setState(() {
                              _toDate = picked;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment:
                          // MainAxisAlignment
                          //     .spaceBetween,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(null != _toDate
                                ? '${_toDate.day} - ${_toDate.month} - ${_toDate.year}'
                                : 'From'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_selectedItem != null) {
                          var result = await assignAlertToUser(
                              user: _selectedItem.toString(),
                              alert: alert_name,
                              from_date: '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                              to_date:'${_toDate.year}-${_toDate.month}-${_toDate.day}');
                          if (kDebugMode) {
                            print(_selectedItem);
                          }
                          Navigator.of(context).pop();
                          _dialogBuilder2(context, result);
                        }
                      },
                      child: const Text('Assign'),
                    ),
                  ],
                );
              });
            },
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder2(BuildContext context, String status) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        );
      },
    );
  }
}

class ListItem {
  final String title;
  final List columns;
  final List data;
  bool isExpanded;

  ListItem({
    required this.title,
    required this.columns,
    required this.data,
    this.isExpanded = false,
  });
}
