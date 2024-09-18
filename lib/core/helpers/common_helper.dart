import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';

class CommonHelper {
  bool convertToBool(String source) => source == '1' ? true : false;

  showSimpleOkDialog(
      BuildContext context, String title, String message, Function() onOk) {
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

  static void showConfirmationDialog(
      BuildContext context, String message, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          iconPadding: const EdgeInsets.only(top: 30),
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
            size: 60,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // a button to close the dialog with primary color
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // a button to close the dialog with primary color
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: const Text(
                'CONFIRM',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

  formatMoney(double amount) {
    return NumberFormat.simpleCurrency(name: amount < 1000 ? 'USD' : 'IDR')
        .format(amount);
  }
}
