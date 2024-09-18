import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/payment_method_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class PaymentMethodSettingDetail extends StatefulWidget {
  final PaymentMethodModel? paymentMethod;

  const PaymentMethodSettingDetail({super.key, this.paymentMethod});

  @override
  State<PaymentMethodSettingDetail> createState() =>
      _PaymentMethodSettingDetailState();
}

class _PaymentMethodSettingDetailState
    extends State<PaymentMethodSettingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Payment Method Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets().buildTitleTextItem(
                "Payment Name",
                widget.paymentMethod!.name!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Type",
                widget.paymentMethod!.type!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Payment Method Description",
                widget.paymentMethod!.description!,
              ),
              CommonWidgets()
                  .buildTextImageItem("Image", widget.paymentMethod!.imgUrl!),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.orange,
                text: "Edit Payment Method",
                onPressed: () {
                  // navigate to edit payment screen
                  context.pushNamed(
                      AppRouteConstants.addEditPaymentMethodRouteName,
                      extra: widget.paymentMethod);
                },
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.red,
                text: "Delete Payment",
                onPressed: () {
                  CommonHelper.showConfirmationDialog(context,
                      "Are you sure you want to delete this payment method?",
                      () async {
                    // delete payment
                    await ProgramPaymentService()
                        .delete(widget.paymentMethod!.id!)
                        .then((value) {
                      Provider.of<ProgramProvider>(context, listen: false)
                          .removePaymentMethod(widget.paymentMethod!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Payment method deleted successfully"),
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
