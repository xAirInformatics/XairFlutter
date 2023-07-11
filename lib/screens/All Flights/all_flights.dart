import 'package:flutter/material.dart';
import '../../components/side_bar.dart';
import '../../consts/style.dart';

class AllFlights extends StatefulWidget {
  const AllFlights({Key? key}) : super(key: key);

  @override
  State<AllFlights> createState() => _AllFlightsState();
}

class _AllFlightsState extends State<AllFlights> {
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
                    "All Flights",
                    style: kTopTitleTextStyle.copyWith(fontSize: 35),
                  ),
                ),

              ],
            ),
          ),
          Sidebar("All Flights"),
        ],
      ),
    );
  }
}
