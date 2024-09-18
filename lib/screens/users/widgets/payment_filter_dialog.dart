import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/screens/payments/payments.dart';

class PaymentFilterDialog extends StatefulWidget {
  final List<PaymentFilterItemModel> paymentMethods;
  final List<PaymentFilterItemModel> programPayments;
  final List<PaymentFilterItemModel> paymentStatuses;

  const PaymentFilterDialog(
      {super.key,
      required this.paymentMethods,
      required this.programPayments,
      required this.paymentStatuses});

  @override
  State<PaymentFilterDialog> createState() => _PaymentFilterDialogState();
}

class _PaymentFilterDialogState extends State<PaymentFilterDialog> {
  String paymentStatusKey = '-1';
  TextEditingController textController = TextEditingController();
  PaymentFilterItemModel? selectedPaymentMethod;
  PaymentFilterItemModel? selectedProgramPayment;
  PaymentFilterItemModel? selectedPaymentStatus;

  Map<String, String> formStatusOptions = {
    '-1': 'All',
    '0': 'Created',
    '1': 'Pending',
    '2': 'Success',
    '3': 'Cancelled',
    '4': 'Rejected',
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
              "Search by text (Email, Full name, Nationality or Xendit external ID)",
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
              "Payment Statuses",
              style: AppTextStyleConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton(
                hint: const Text('All payment statuses'),
                value: selectedPaymentStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedPaymentStatus = newValue;
                  });
                },
                items: widget.paymentStatuses
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.type!),
                        ))
                    .toList()),
            const SizedBox(height: 20),
            Text(
              "Payment Methods",
              style: AppTextStyleConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton(
                hint: const Text('All payment methods'),
                value: selectedPaymentMethod,
                onChanged: (newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue;
                  });
                },
                items: widget.paymentMethods
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.type!),
                        ))
                    .toList()),
            const SizedBox(height: 20),
            Text(
              "Program Payments",
              style: AppTextStyleConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton(
              hint: const Text('All program payments'),
              value: selectedProgramPayment,
              onChanged: (newValue) {
                setState(() {
                  selectedProgramPayment = newValue;
                });
              },
              items: widget.programPayments
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.type!),
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
                      paymentStatusKey = '-1';
                      textController.clear();
                    });
                  },
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filter options and close dialog
                    Navigator.of(context).pop({
                      'text': textController.text,
                      'payment_method': selectedPaymentMethod == null
                          ? '0'
                          : selectedPaymentMethod!.id,
                      'program_payment': selectedProgramPayment == null
                          ? '0'
                          : selectedProgramPayment!.id,
                      'payment_status': selectedPaymentStatus == null
                          ? '-1'
                          : selectedPaymentStatus!.id,
                    });
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
