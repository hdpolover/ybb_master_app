import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/payment_xendit_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/participant_status_service.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class PaymentDetail extends StatefulWidget {
  final FullPaymentModel payment;
  final PaymentXenditModel? paymentXendit;

  const PaymentDetail({super.key, required this.payment, this.paymentXendit});

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
                        String paymentStatus = "";

                        if (widget.payment.programPaymentsName!
                            .toLowerCase()
                            .contains("regist")) {
                          paymentStatus = "1";
                        } else {
                          paymentStatus = "2";
                        }

                        Map<String, dynamic> data = {
                          "payment_status": paymentStatus,
                        };

                        await ParticipantStatusService()
                            .updateStatus(widget.payment.participantId!, data)
                            .then((value) async {
                          String programId = Provider.of<ProgramProvider>(
                                  context,
                                  listen: false)
                              .currentProgram!
                              .id!;
                          await PaymentService()
                              .getAll(programId)
                              .then((value) {
                            setState(() {
                              isLoading = false;
                            });

                            Provider.of<PaymentProvider>(context, listen: false)
                                .payments = value;

                            CommonHelper().showSimpleOkDialog(
                                context,
                                "Data updated",
                                "Payment has been approved", () {
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pop(context);
                            });
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
                        String programId =
                            Provider.of<ProgramProvider>(context, listen: false)
                                .currentProgram!
                                .id!;

                        await PaymentService().getAll(programId).then((value) {
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
    return Scaffold(
      appBar: const CommonAppBar(title: "Payment Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonWidgets().buildCustomButton(
              //     text: "Back",
              //     onPressed: () {
              //       context.pushNamed(AppRouteConstants.participantDetailRouteName,
              //           arguments: widget.payment.participantId);
              //     }),
              CommonWidgets().buildTitleTextItem(
                "Full Name",
                widget.payment.fullName!,
                isCopyable: true,
                context: context,
              ),
              CommonWidgets().buildTitleTextItem(
                "Email",
                widget.payment.email!,
                isCopyable: true,
                context: context,
              ),
              CommonWidgets().buildTitleTextItem(
                "Program Payment",
                widget.payment.programPaymentsName!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Payment Method",
                widget.payment.paymentMethodsName!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Payment Type",
                widget.payment.type!,
              ),
              widget.payment.type == "gateway" && widget.paymentXendit != null
                  ? CommonWidgets().buildTitleTextItem(
                      "External ID",
                      widget.paymentXendit!.externalId!,
                      isCopyable: true,
                      context: context,
                    )
                  : const SizedBox.shrink(),
              CommonWidgets().buildTitleTextItem(
                "Amount",
                CommonHelper()
                    .formatMoney(double.parse(widget.payment.amount!)),
              ),
              CommonWidgets().buildTitleTextItem(
                "Status",
                _getStatus(widget.payment.status!),
              ),
              CommonWidgets().buildTitleTextItem(
                "Payment Date",
                widget.payment.createdAt.toString(),
              ),

              // buildDetailItem(
              //     "Program Payment", widget.payment.programPaymentsName!),
              // buildDetailItem(
              //     "Payment Method", widget.payment.paymentMethodsName!),
              // buildDetailItem("Payment Type", widget.payment.type!),
              // buildDetailItem(
              //     "Amount",
              //     CommonHelper()
              //         .formatMoney(double.parse(widget.payment.amount!))),
              // buildDetailItem("Status", _getStatus(widget.payment.status!)),
              // buildDetailItem(
              //     "Payment Date", widget.payment.createdAt.toString()),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Proof of Payment",
                    style: AppTextStyleConstants.bodyTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  widget.payment.proofUrl == null
                      ? Text(
                          "No proof of payment",
                          style: AppTextStyleConstants.bodyTextStyle,
                        )
                      : GestureDetector(
                          onTap: () {
                            showImageViewer(
                              context,
                              Image.network(widget.payment.proofUrl).image,
                              useSafeArea: true,
                              swipeDismissible: true,
                              doubleTapZoomable: true,
                            );
                          },
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Image.network(widget.payment.proofUrl!)),
                        )
                ],
              ),
              widget.payment.status == "2"
                  ? const SizedBox.shrink()
                  : buildButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
