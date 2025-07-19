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
