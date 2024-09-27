import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/services/participant_service.dart';
import 'package:ybb_master_app/core/services/participant_status_service.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_basic_info.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_essays.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_payments.dart';

class ParticipantDetails extends StatefulWidget {
  final ParticipantModel participant;
  const ParticipantDetails({super.key, required this.participant});

  @override
  State<ParticipantDetails> createState() => _ParticipantDetailsState();
}

class _ParticipantDetailsState extends State<ParticipantDetails>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    getData();
  }

  getData() async {
    // get status
    await ParticipantStatusService()
        .getByParticipantId(widget.participant.id!)
        .then((value) {
      Provider.of<ParticipantProvider>(context, listen: false)
          .setParticipantStatus(value);
    });

    // get essays
    await ParticipantService()
        .getEssayByParticipantId(widget.participant.id)
        .then((value) {
      // if essays are not empty, clear the list first
      if (Provider.of<ParticipantProvider>(context, listen: false)
          .selectedParticipantEssays
          .isNotEmpty) {
        Provider.of<ParticipantProvider>(context, listen: false)
            .clearSelectedParticipantEssays();
      }

      Provider.of<ParticipantProvider>(context, listen: false)
          .selectedParticipantEssays = value;
    });

    // get payments
    await PaymentService()
        .getByParticipantId(widget.participant.id!)
        .then((value) async {
      if (Provider.of<ParticipantProvider>(context, listen: false)
          .selectedParticipantPayments
          .isNotEmpty) {
        Provider.of<ParticipantProvider>(context, listen: false)
            .selectedParticipantPayments
            .clear();
      }

      Provider.of<ParticipantProvider>(context, listen: false)
          .selectedParticipantPayments = value;
    });
  }

  submitForm() async {
    // get participant payments
    List<FullPaymentModel> payments =
        Provider.of<ParticipantProvider>(context, listen: false)
            .selectedParticipantPayments;

    // check if the participant has made any payments
    if (payments.isEmpty) {
      CommonDialog.showAlertDialog(
        context,
        "No Payments",
        "This participant has not made any payments yet. Please ask the participant to make a payment first.",
      );

      setState(() {
        isLoading = false;
      });

      return;
    } else {
      // check if there is any successful payment
      bool hasSuccessfulPayment = false;

      for (var payment in payments) {
        if (payment.status == "2") {
          hasSuccessfulPayment = true;
          break;
        }
      }

      if (!hasSuccessfulPayment) {
        CommonDialog.showAlertDialog(
          context,
          "No Successful Payments",
          "This participant has not made any successful payments yet. Please ask the participant to make a successful payment first.",
        );

        setState(() {
          isLoading = false;
        });

        return;
      }
    }

    // update participant status
    Map<String, dynamic> statusData = {
      "form_status": "2",
      "general_status": "1",
    };

    await ParticipantStatusService()
        .updateStatus(
            Provider.of<ParticipantProvider>(context, listen: false)
                .participantStatus!
                .id!,
            statusData)
        .then((value) {
      Navigator.pop(context);

      Provider.of<ParticipantProvider>(context, listen: false)
          .setParticipantStatus(value);

      CommonDialog.showAlertDialog(
        context,
        "Form Submitted",
        "The participant's form has been successfully submitted.",
      );

      setState(() {
        isLoading = false;
      });
    });
  }

  _buildFab(BuildContext context) {
    // i need two buttons, one for editing the participant and one for deleting the participant
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      onPressed: () {
        // i want to show a dialog with two options, edit and delete
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              title: const Text("Participant Options"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CommonWidgets().buildCustomButton(
                  //   text: "Edit Participant",
                  //   color: Colors.orange,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     // i want to navigate to the edit participant page
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 10
                  // ),
                  widget.participant.formStatus == "2" &&
                          widget.participant.generalStatus == "1"
                      ?
                      // create container to show that the form is submitted
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Form Submitted",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : CommonWidgets().buildCustomButton(
                          text: "Submit Form",
                          onPressed: () {
                            Navigator.pop(context);

                            // i want to show a dialog to confirm submission
                            CommonDialog.showConfirmationDialog(
                              context,
                              "Submit Form",
                              "Are you sure you want to submit this participant's form?",
                              () {
                                setState(() {
                                  isLoading = true;
                                });

                                submitForm();

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                ],
              ),
            );
          },
        );
      },
      child: const Icon(Icons.more_vert),
    );
  }

  @override
  Widget build(BuildContext context) {
    // i want a page with tabs for basic info, essays, and payments
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Participant Details"),
      floatingActionButton: _buildFab(context),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Basics",
                ),
                Tab(
                  text: "Essays",
                ),
                Tab(
                  text: "Documents",
                ),
                Tab(
                  text: "Payments",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PBasicInfo(
                  participant: widget.participant,
                ),
                PEssays(
                  participant: widget.participant,
                ),
                Container(),
                PPayments(participant: widget.participant),
              ],
            ),
          )
        ],
      ),
    );
  }
}
