import 'package:flutter/material.dart';

Widget addUpdateButton({
  required String buttonTitle,
  Color color = Colors.deepPurple,
  double radius = 12.0,
  Color textColor = Colors.white,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        debugPrint("Add Pressed");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(buttonTitle, style: TextStyle(color: textColor)),
    ),
  );
}

Widget deleteButton({
  required String buttonTitle,
  double radius = 12.0,
  Color textColor = Colors.red,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        debugPrint("DELETE Pressed");
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(
          // width: 5.0,
          color: Colors.red,
        ),
      ),
      child: Text(buttonTitle, style: TextStyle(color: textColor)),
    ),
  );
}
