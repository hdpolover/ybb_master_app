import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';

class PaymentDetail extends StatefulWidget {
  final FullPaymentModel payment;
  const PaymentDetail({super.key, required this.payment});

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  bool isLoading = false;

  _getStatus(String status) {
    switch (status) {
      case "0":
        return "Created";
      case "1":
        return "Pending";
      case "2":
        return "Success";
      case "3":
        return "Cancelled";
      case "4":
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  buildDetailItem(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyleConstants.headingTextStyle.copyWith(fontSize: 15),
      ),
      subtitle: Text(subtitle),
    );
  }

  buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isLoading
              ? const Text("Now Loading...")
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await PaymentService()
                        .updateStatus(widget.payment.id!, "2")
                        .then((value) async {
                      if (value) {
                        await PaymentService().getAll().then((value) {
                          setState(() {
                            isLoading = false;
                          });

                          Provider.of<PaymentProvider>(context, listen: false)
                              .payments = value;

                          CommonHelper().showSimpleOkDialog(context,
                              "Data updated", "Payment has been approved", () {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pop(context);
                          });
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to approve payment"),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Approve',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          isLoading
              ? const Text("Now Loading...")
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await PaymentService()
                        .updateStatus(widget.payment.id!, "4")
                        .then((value) async {
                      if (value) {
                        await PaymentService().getAll().then((value) {
                          setState(() {
                            isLoading = false;
                          });

                          Provider.of<PaymentProvider>(context, listen: false)
                              .payments = value;

                          CommonHelper().showSimpleOkDialog(context,
                              "Data updated", "Payment has been rejected", () {
                            // use parent context
                            // close dialog
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pop(context);
                          });
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to reject payment"),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.payment.id!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailItem("Full Name", widget.payment.fullName!),
            buildDetailItem("Email", widget.payment.email!),
            buildDetailItem(
                "Payment Method", widget.payment.paymentMethodsName!),
            buildDetailItem("Payment Method", widget.payment.type!),
            buildDetailItem("Amount", "IDR${widget.payment.amount!}"),
            buildDetailItem("Status", _getStatus(widget.payment.status!)),
            buildDetailItem(
                "Payment Date", widget.payment.createdAt.toString()),
            ListTile(
              title: Text("Proof of Payment",
                  style: AppTextStyleConstants.headingTextStyle
                      .copyWith(fontSize: 15)),
              subtitle: widget.payment.proofUrl == null
                  ? const Text("No proof of payment")
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.network(widget.payment.proofUrl!)),
            ),
            widget.payment.status == "2" ||
                    widget.payment.status == "4" ||
                    widget.payment.status == "3"
                ? const SizedBox.shrink()
                : buildButtons(),
          ],
        ),
      ),
    );
  }
}
