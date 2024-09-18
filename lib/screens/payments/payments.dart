import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/excel_helper.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/payment_xendit_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/routes/router_config.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/services/program_payment_method_service.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/payments/payment_card.dart';
import 'package:ybb_master_app/screens/users/widgets/payment_filter_dialog.dart';

class PaymentFilterChip {
  String label;
  String status;

  PaymentFilterChip({
    required this.label,
    required this.status,
  });
}

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<FullPaymentModel>? filteredPayments;
  List<PaymentFilterItemModel> paymentMethods = [];
  List<PaymentFilterItemModel> programPayments = [];
  List<PaymentFilterItemModel> paymentStatuses = [];

  Map<String, dynamic> selectedFilters = {};
  String filterText = "";

  List<ParticipantModel> participants = [];
  int resultCount = 0;

  @override
  void initState() {
    super.initState();

    updatePayments();
    getPaymentData();
  }

  updatePayments() async {
    await PaymentService().updatXenditPayments().then((value) {
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payments updated")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update payments")),
        );
      }
    });
  }

  getPaymentStatusLabel(String status) {
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
        return "All";
    }
  }

  getPaymentData() async {
    setState(() {
      filteredPayments = null;
    });

    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    // get the data
    PaymentService().getAll(programId).then((value) async {
      value.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      print(value.length);

      Provider.of<PaymentProvider>(context, listen: false).payments = value;

      filteredPayments = value;

      print(filteredPayments!.length);

      resultCount = filteredPayments!.length;

      // get the payment types from value and set it to paymentTypes
      for (var item in value) {
        if (paymentMethods.isEmpty) {
          paymentMethods.add(PaymentFilterItemModel(
            id: item.paymentMethodId!,
            type: item.paymentMethodsName,
          ));
        } else {
          if (paymentMethods
              .where((element) => element.id == item.paymentMethodId)
              .isEmpty) {
            paymentMethods.add(PaymentFilterItemModel(
              id: item.paymentMethodId,
              type: item.paymentMethodsName,
            ));
          }
        }
      }

      // get the program payments from value and set it to programPayments
      for (var item in value) {
        if (programPayments.isEmpty) {
          programPayments.add(PaymentFilterItemModel(
            id: item.programPaymentId!,
            type: item.programPaymentsName,
          ));
        } else {
          if (programPayments
              .where((element) => element.id == item.programPaymentId)
              .isEmpty) {
            programPayments.add(PaymentFilterItemModel(
              id: item.programPaymentId,
              type: item.programPaymentsName,
            ));
          }
        }
      }

      // sort the program payments in alphabetical order
      programPayments.sort((a, b) => a.type!.compareTo(b.type!));

      // get the payment statuses from value and set it to paymentStatuses
      for (var item in value) {
        if (paymentStatuses.isEmpty) {
          paymentStatuses.add(PaymentFilterItemModel(
            id: item.status!,
            type: getPaymentStatusLabel(item.status!),
          ));
        } else {
          if (paymentStatuses
              .where((element) => element.id == item.status)
              .isEmpty) {
            paymentStatuses.add(PaymentFilterItemModel(
              id: item.status,
              type: getPaymentStatusLabel(item.status!),
            ));
          }
        }
      }

      setState(() {});

      await ProgramPaymentService().getAll(programId).then((value) async {
        Provider.of<ProgramProvider>(context, listen: false).programPayments =
            value;

        await ProgramPaymentMethodService().getAll(programId).then((value) {
          Provider.of<PaymentProvider>(context, listen: false).paymentMethods =
              value;
        });
      });
    }).onError((error, stackTrace) {
      print(error);

      setState(() {
        filteredPayments = [];
      });
    });
  }

  void _showFilterDialog() async {
    filterText = "";

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return PaymentFilterDialog(
          paymentMethods: paymentMethods,
          programPayments: programPayments,
          paymentStatuses: paymentStatuses,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedFilters = result;

        if (selectedFilters.keys.isEmpty) {
          filterText = "No filters applied ($resultCount results)";
        } else {
          for (var key in selectedFilters.keys) {
            if (key == "program_payment") {
              String label = "Program Payment: ";
              String value = "";

              for (var a in programPayments) {
                if (a.id == selectedFilters[key]) {
                  value = a.type!;

                  break;
                } else {
                  value = "All";
                }
              }

              filterText += label + value;
            } else if (key == "payment_method") {
              String label = "Payment Method: ";
              String value = "";

              for (var a in paymentMethods) {
                if (a.id == selectedFilters[key]) {
                  value = a.type!;

                  break;
                } else {
                  value = "All";
                }
              }

              filterText += label + value;
            } else if (key == "payment_status") {
              String label = "Payment Status: ";
              String value = "";

              for (var a in paymentStatuses) {
                if (a.id == selectedFilters[key]) {
                  value = a.type!;

                  break;
                } else {
                  value = "All";
                }
              }

              filterText += label + value;
            } else if (key == "text") {
              String textQuery = selectedFilters[key].toString().isEmpty
                  ? "No text filter"
                  : selectedFilters[key].toString();
              filterText += "Text: $textQuery";
            }

            if (selectedFilters.keys.last != key) {
              filterText += ", ";
            }
          }
        }
      });

      applyFilters();
    }
  }

  void applyFilters() {
    List<FullPaymentModel> temp =
        Provider.of<PaymentProvider>(context, listen: false).payments;
    List<FullPaymentModel> filteredTemp = [];

    for (var item in temp) {
      if (selectedFilters.containsKey("payment_method")) {
        if (selectedFilters["payment_method"] == "0") {
          filteredTemp.add(item);
        } else {
          if (item.paymentMethodId == selectedFilters["payment_method"]) {
            filteredTemp.add(item);
          }
        }
      }
    }

    if (selectedFilters.containsKey("text")) {
      filteredTemp = filteredTemp.where((participant) {
        return participant.email!
                .toLowerCase()
                .contains(selectedFilters["text"].toString().toLowerCase()) ||
            participant.accountName!
                .toLowerCase()
                .contains(selectedFilters["text"].toString().toLowerCase()) ||
            (participant.externalId != null &&
                participant.externalId!.toLowerCase().contains(
                    selectedFilters["text"].toString().toLowerCase())) ||
            (participant.nationality != null &&
                participant.nationality!.toLowerCase().contains(
                    selectedFilters["text"].toString().toLowerCase()));
      }).toList();
    }

    if (selectedFilters.containsKey("program_payment")) {
      if (selectedFilters["program_payment"] != "0") {
        filteredTemp = filteredTemp.where((participant) {
          return participant.programPaymentId ==
              selectedFilters["program_payment"];
        }).toList();
      }
    }

    if (selectedFilters.containsKey("payment_status")) {
      if (selectedFilters["payment_status"] != "-1") {
        filteredTemp = filteredTemp.where((participant) {
          return participant.status == selectedFilters["payment_status"];
        }).toList();
      }
    }

    filteredPayments = filteredTemp;

    resultCount = filteredPayments!.length;

    filterText += " ($resultCount results)";

    setState(() {});
  }

  buildFilterSection() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(selectedFilters.keys.isEmpty
                    ? "No filters applied ($resultCount results)"
                    : filterText)),
            const SizedBox(width: 10),
            CommonWidgets().buildCustomButton(
              width: 100,
              color: Colors.orange,
              text: "Statistics",
              onPressed: () {
                context.pushNamed(AppRouteConstants.paymentStatisticsRouteName);
              },
            ),
            const SizedBox(width: 10),
            CommonWidgets().buildCustomButton(
              width: 100,
              color: Colors.green,
              text: "Export",
              onPressed: () {
                String detailText =
                    filterText.isEmpty ? "No filters applied" : filterText;

                CommonDialog.showConfirmationDialog(context, "Export to Excel",
                    "Do you want to export the payments to an Excel file?\n\nDetails: $detailText",
                    () {
                  Navigator.of(context).pop();

                  ExcelHelper.exportPaymentData(filteredPayments!, filterText);
                });
              },
            ),
            const SizedBox(width: 10),
            CommonWidgets().buildCustomButton(
              width: 100,
              text: "Filter",
              onPressed: _showFilterDialog,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedFilters = {};
                });

                getPaymentData();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(
        title: "Payments",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildFilterSection(),
            filteredPayments == null
                ? CommonWidgets.buildLoading()
                : filteredPayments!.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: const Center(
                              child: Text("No payments found"),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          itemCount: filteredPayments!.length,
                          itemBuilder: (context, index) {
                            return PaymentCard(
                              payment: filteredPayments![index],
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class PaymentFilterItemModel {
  String? id;
  String? type;

  PaymentFilterItemModel({
    this.id,
    this.type,
  });
}
