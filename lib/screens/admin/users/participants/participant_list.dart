import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/excel_helper.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';
import 'package:ybb_master_app/screens/admin/users/widgets/participant_filter_dialog.dart';
import 'package:ybb_master_app/screens/admin/users/widgets/participant_preview_widget.dart';

class ParticipantList extends StatefulWidget {
  const ParticipantList({super.key});

  @override
  State<ParticipantList> createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  Map<String, dynamic> selectedFilters = {};
  String filterText = "";

  List<ParticipantModel> participants = [];
  int resultCount = 0;
  String category = "All";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() {
    var participantProvider =
        Provider.of<ParticipantProvider>(context, listen: false);

    // get the data
    participants = participantProvider.participants;

    filterText =
        "No filters applied. (${participants.length} results, $category) ";

    setState(() {});
  }

  void _showFilterDialog() async {
    filterText = "";

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return const ParticipantFilterDialog();
      },
    );

    if (result != null) {
      setState(() {
        selectedFilters = result;

        if (selectedFilters.keys.isEmpty) {
          filterText = "No filters applied";
        } else {
          for (var key in selectedFilters.keys) {
            if (key == "form_status") {
              String label = "Form Status: ";
              String value = "";

              switch (selectedFilters[key]) {
                case "0":
                  value = "Not Started";
                  category = "Not Started";
                  break;
                case "1":
                  value = "In Progress";
                  category = "In Progress";
                  break;
                case "2":
                  value = "Completed";
                  category = "Completed";
                  break;
                default:
                  value = "All";
                  category = "All";
              }

              filterText += label + value;
            } else if (key == "text") {
              filterText += "Text: ${selectedFilters[key]}";
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
    var participantProvider =
        Provider.of<ParticipantProvider>(context, listen: false);

    List<ParticipantModel> filteredParticipants = [];

    for (var participant in participantProvider.participants) {
      if (selectedFilters.containsKey("form_status")) {
        if (selectedFilters["form_status"] == "-1") {
          filteredParticipants.add(participant);
        } else {
          if (participant.formStatus == selectedFilters["form_status"]) {
            filteredParticipants.add(participant);
          }
        }
      }
    }

    if (selectedFilters.containsKey("text")) {
      filteredParticipants = filteredParticipants.where((participant) {
        return participant.fullName!
                .toLowerCase()
                .contains(selectedFilters["text"].toString().toLowerCase()) ||
            participant.email!
                .toLowerCase()
                .contains(selectedFilters["text"].toString().toLowerCase());
      }).toList();
    }

    participants = filteredParticipants;

    resultCount = participants.length;

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
            Expanded(child: Text(filterText)),
            const SizedBox(width: 10),
            isLoading
                ? const LoadingWidget()
                : CommonWidgets().buildCustomButton(
                    width: 100,
                    color: Colors.green,
                    text: "Export",
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(const Duration(seconds: 2));

                      await ExcelHelper()
                          .exportParticipantData(participants, category)
                          .then((res) {
                        if (res) {
                          CommonDialog.showAlertDialog(context, "Success",
                              "Data has been exported successfully",
                              onConfirm: () {
                            setState(() {
                              isLoading = false;
                            });

                            // remove parent dialog
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        } else {
                          CommonDialog.showAlertDialog(context, "Error",
                              "An error occurred while exporting data",
                              onConfirm: () {
                            setState(() {
                              isLoading = false;
                            });

                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        }
                      });
                    },
                  ),
            const SizedBox(width: 10),
            CommonWidgets().buildCustomButton(
              width: 100,
              text: "Filter",
              onPressed: _showFilterDialog,
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
      appBar: const CommonAppBar(title: "Participants"),
      body: Column(
        children: [
          buildFilterSection(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: participants.isEmpty
                  ? const Center(child: Text("No participants to be shown"))
                  : ListView.builder(
                      itemCount: participants.length,
                      itemBuilder: (context, index) {
                        return ParticipantPreviewWidget(
                            participant: participants[index]);
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
