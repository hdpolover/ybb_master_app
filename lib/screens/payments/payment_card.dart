import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';

class PaymentCard extends StatelessWidget {
  final FullPaymentModel payment;
  const PaymentCard({super.key, required this.payment});

  buildChip(String status) {
    Color color = Colors.grey;
    String text = "";

    if (status == "0") {
      color = Colors.grey;
      text = "Created";
    } else if (status == "1") {
      color = Colors.orange;
      text = "Pending";
    } else if (status == "2") {
      color = Colors.green;
      text = "Success";
    } else if (status == "3" || status == "4") {
      color = Colors.red;
      text = "Rejected/Failed";
    }

    return Chip(
      label: Text(
        text,
        style: AppTextStyleConstants.bodyTextStyle.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // format date to be like "April 14, 2024 10:00:00"
    String paymentDate =
        DateFormat('MMM dd, yyyy HH:mm').format(payment.createdAt!);

    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        horizontalTitleGap: 30,
        style: ListTileStyle.list,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: buildChip(payment.status!),
        title: Text(payment.email!,
            style: AppTextStyleConstants.bodyTextStyle
                .copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(payment.paymentMethodsName!),
        trailing: Text(paymentDate),
        onTap: () {
          context.push(AppRouteConstants.paymentsDetailsRoutePath,
              extra: payment);
        },
      ),
    );
  }
}
