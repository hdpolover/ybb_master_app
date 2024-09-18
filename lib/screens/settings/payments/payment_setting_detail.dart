import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class PaymentSettingDetail extends StatefulWidget {
  final ProgramPaymentModel? payment;

  const PaymentSettingDetail({super.key, this.payment});

  @override
  State<PaymentSettingDetail> createState() => _PaymentSettingDetailState();
}

class _PaymentSettingDetailState extends State<PaymentSettingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Payment Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets().buildTitleTextItem(
                "Payment Name",
                widget.payment!.name!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Category",
                widget.payment!.category!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Payment Description",
                widget.payment!.description!,
              ),
              CommonWidgets().buildTitleTextItem(
                "IDR Amount",
                CommonHelper()
                    .formatMoney(double.parse(widget.payment!.idrAmount!)),
              ),
              CommonWidgets().buildTitleTextItem(
                "USD Amount",
                CommonHelper()
                    .formatMoney(double.parse(widget.payment!.usdAmount!)),
              ),
              CommonWidgets().buildTitleTextItem(
                "Start Date",
                DateFormat("dd MMMM yyyy").format(widget.payment!.startDate!),
              ),
              CommonWidgets().buildTitleTextItem(
                "End Date",
                DateFormat("dd MMMM yyyy").format(widget.payment!.endDate!),
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.orange,
                text: "Edit Payment",
                onPressed: () {
                  // navigate to edit payment screen
                  context.pushNamed(AppRouteConstants.addEditPaymentRouteName,
                      extra: widget.payment);
                },
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.red,
                text: "Delete Payment",
                onPressed: () {
                  CommonHelper.showConfirmationDialog(
                      context, "Are you sure you want to delete this payment?",
                      () async {
                    // delete payment
                    await ProgramPaymentService()
                        .delete(widget.payment!.id!)
                        .then((value) {
                      Provider.of<ProgramProvider>(context, listen: false)
                          .removeProgramPayment(widget.payment!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Payment deleted successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.of(context).pop();
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
