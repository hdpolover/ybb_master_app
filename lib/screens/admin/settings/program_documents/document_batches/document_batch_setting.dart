import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/document_batch_model.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_document_service.dart';
import 'package:ybb_master_app/core/services/program_document_setting_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';

class DocumentBatchSetting extends StatefulWidget {
  const DocumentBatchSetting({super.key});

  @override
  State<DocumentBatchSetting> createState() => _DocumentBatchSettingState();
}

class _DocumentBatchSettingState extends State<DocumentBatchSetting> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await ProgramDocumentSettingService().getAll(programId).then((value) {
      Provider.of<ProgramProvider>(context, listen: false).documentBatches =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<DocumentBatchModel>? documentBatches = programProvider.documentBatches;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Document Batch Settings"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment method
          context.pushNamed(AppRouteConstants.addEditProgramDocumentRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: documentBatches == null
          ? const LoadingWidget()
          : documentBatches.isEmpty
              ? const Center(
                  child: Text("No document batch setting found"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: documentBatches.length,
                  itemBuilder: (context, index) {
                    String formattedDate =
                        "Registration Date Range: ${CommonMethods.formatDate(documentBatches[index].startDate!)} - ${CommonMethods.formatDate(documentBatches[index].endDate!)}";

                    String customAvailabilityNumber = documentBatches[index]
                                .customAvailability ==
                            "0"
                        ? ""
                        : "After ${documentBatches[index].customAvailability} day(s) of registration";

                    String availabilityFormattedDate =
                        "Document Availability: ${CommonMethods.formatDate(documentBatches[index].availabilityDate!)} $customAvailabilityNumber";

                    return ItemWidgetTile(
                      id: documentBatches[index].id!,
                      title: documentBatches[index].name!,
                      description: formattedDate,
                      moreDesc: availabilityFormattedDate,
                      onTap: () {
                        // Edit payment method
                        context.pushNamed(
                          AppRouteConstants.documentBatchDetailRouteName,
                          extra: documentBatches[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
