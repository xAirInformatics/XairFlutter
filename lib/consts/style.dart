import 'package:flutter/material.dart';

const kBackgroundDarkColor = Color(0xff222D64);
const kBackgroundLightColor = Color(0xff30376A);

const kUnActiveIconColor = Color(0xffAFD3E2);
const kActiveIconColor = Color(0xffF6F1F1);
//
const kBlue = Color(0xff4791FF);
// const kOrange = Color(0xffFFD950);
// const kYellow = Color(0xffEDFF47);
// const kPurple = Color(0xffF847FF);
const kRed = Color(0xffFF2366);
const kGreen = Color(0xff02BC77);

const kTitleTextStyle =
    TextStyle(color: Color(0xffeeeeee), fontSize: 24, fontWeight: FontWeight.bold,);

const kTopTitleTextStyle =
TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,);

const kLabelTextStyle =
TextStyle(color: Colors.white, fontSize: 13);

const kSubTitleTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 15,
);

const kNumberTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w100
);

const kPadding20 = EdgeInsets.all(20);
const kPadding8 = EdgeInsets.all(8);
const kPadding5 = EdgeInsets.all(5);

var kBoxDecorationLight = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: kBackgroundLightColor,
);

var kBoxDecorationDark = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: kBackgroundDarkColor,
);

List<Color> colorLists = [
  Colors.amberAccent,
  Colors.cyanAccent,
  Colors.deepOrangeAccent,
  Colors.greenAccent,
  Colors.lightGreenAccent,
  Colors.orangeAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.redAccent,
  Colors.tealAccent,
  Colors.yellowAccent,
];

const TextStyle kChartsTitleTextStyle = TextStyle(
fontWeight: FontWeight.bold,
fontSize: 12
);