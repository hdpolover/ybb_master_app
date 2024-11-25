import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';

class ParticipantFilterDialog extends StatefulWidget {
  const ParticipantFilterDialog({super.key});

  @override
  State<ParticipantFilterDialog> createState() =>
      _ParticipantFilterDialogState();
}

class _ParticipantFilterDialogState extends State<ParticipantFilterDialog> {
  String formStatusKey = '-1';
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setData();
  }

  void setData() {
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
  }

  Map<String, String> formStatusOptions = {
    '-1': 'All',
    '0': 'Not started',
    '1': 'On progress',
    '2': 'Submitted',
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Filter Options',
                style: AppTextStyleConstants.headingTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Search by text (email, full name, etc.)",
              style: AppTextStyleConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Form Submission Status",
              style: AppTextStyleConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton(
              value: formStatusKey,
              onChanged: (String? newValue) {
                setState(() {
                  formStatusKey = newValue!;
                });
              },
              items: formStatusOptions.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Reset filter options
                    setState(() {
                      formStatusKey = '-1';
                      textController.clear();
                    });
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filter options and close dialog
                    Navigator.of(context).pop({
                      'text': textController.text,
                      'form_status': formStatusKey,
                    });
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
