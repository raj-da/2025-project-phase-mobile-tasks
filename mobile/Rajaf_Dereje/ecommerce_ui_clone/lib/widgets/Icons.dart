import 'package:flutter/material.dart';

Widget squareIcon({
  required IconData icon,
  Color iconColor = Colors.grey,
  Color borderColor = Colors.grey,
  double size = 30,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid, color: borderColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: IconButton(
      onPressed: () {
        debugPrint("Search Icon");
      },
      icon: Icon(icon, color: iconColor, size: size),
    ),
  );
}


Widget circleIcon({
  required IconData icon,
  Color iconColor = Colors.grey,
  Color borderColor = Colors.grey,
  Color backGroundColor = Colors.white,
  double size = 24,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid, color: borderColor),
      borderRadius: BorderRadius.circular(100),
      color: backGroundColor,
    ),
    child: IconButton(
      onPressed: () {
        debugPrint("Back arrow Icon");
      },
      icon: Icon(icon, color: iconColor, size: size),
    ),
  );
}