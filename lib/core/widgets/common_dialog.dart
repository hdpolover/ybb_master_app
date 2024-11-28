import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';

class CommonDialog {
  static void showAlertDialog(
      BuildContext context, String title, String message,
      {bool isError = false, Function()? onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Text(title),
          content: Text(message),
          icon: Icon(
            Icons.info,
            size: 30,
            color: isError ? Colors.red : Colors.blue,
          ),
          actions: [
            CommonWidgets().buildCustomButton(
              text: "OK",
              onPressed: onConfirm ??
                  () {
                    Navigator.of(context).pop();
                  },
            ),
          ],
        );
      },
    );
  }

  static void showConfirmationDialog(BuildContext context, String title,
      String message, Function() onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          icon: const Icon(
            Icons.warning,
            size: 30,
            color: Colors.orange,
          ),
          title: Text(title),
          content: Text(message),
          actions: [
            CommonWidgets().buildCustomButton(
              text: "OK",
              onPressed: onConfirm,
            ),
            const SizedBox(
              height: 10,
            ),
            CommonWidgets().buildCustomButton(
              text: "CANCEL",
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
