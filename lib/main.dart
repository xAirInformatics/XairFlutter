import 'package:flutter/material.dart';
import 'package:xair/consts/style.dart';
import 'package:xair/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safety Report',
      theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true, fontFamily: 'Montserrat'),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
