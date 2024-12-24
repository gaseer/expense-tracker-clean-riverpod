import 'package:flutter/material.dart';

void showSnackBar({
  required String content,
  required BuildContext context,
  required Color color,
  Color? textColor,
  bool? delay,
}) {
  final snackBar = SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.start,
      style: TextStyle(
        letterSpacing: 2,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: textColor ?? Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6, // Add elevation for a floating effect
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Rounded corners
    ),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //     margin: EdgeInsets.fromLTRB(
    //         20, 10, 20, MediaQuery.of(context).viewInsets.bottom + 40),
    duration: const Duration(seconds: 3), // SnackBar duration
  );

  if (delay != true) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
