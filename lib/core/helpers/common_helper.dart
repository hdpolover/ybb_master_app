import 'package:flutter/material.dart';

class CommonHelper {
  bool convertToBool(String source) => source == '1' ? true : false;

  showSimpleOkDialog(
      BuildContext context, String title, String message, VoidCallback? onOk) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onOk,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  showError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
