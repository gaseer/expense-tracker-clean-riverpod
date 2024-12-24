import 'package:expense_tracker/core/utils/colors.dart';
import 'package:flutter/material.dart';

Future<bool?> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required Icon icon,
  required String actionText,
  bool? isDismissible,
}) async {
  return await showDialog<bool>(
    barrierDismissible: isDismissible ?? true,
    context: context,
    builder: (BuildContext context) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(w * 0.05)),
          backgroundColor: gray,
          content: SizedBox(
            height: h * .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                icon,
                SizedBox(
                  width: w * 0.7,
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.02),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.04,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.05,
                ),
                backgroundColor: gray70,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.035,
                    color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.035,
                ),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                actionText,
              ),
            ),
          ]);
    },
  );
}
