import 'package:flutter/material.dart';
import '../../../consts/style.dart';

// ignore: must_be_immutable
class AlertCard extends StatelessWidget {
  AlertCard(
      {super.key, required this.type,
      required this.color,
      required this.label,
      required this.onTap,
      required this.number});

  String type;
  Color color;
  String label;
  int number;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: kBoxDecorationDark,
      padding: kPadding8,
      child: TextButton(
        onPressed: onTap,
        child: ListTile(
          leading: Stack(
            children: [
              Container(
                  padding: kPadding8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color.withOpacity(.2),
                  ),
                  child: Icon(
                    type == 'a' ? Icons.warning_amber_outlined : Icons.airplanemode_active_rounded,
                    color: color,
                  )),
            ],
          ),
          title: Text(
            label,
            style: kLabelTextStyle,
          ),
          trailing: Text(
            number.toString(),
            style: kNumberTextStyle,
          ),
        ),
      ),
    );
  }
}
