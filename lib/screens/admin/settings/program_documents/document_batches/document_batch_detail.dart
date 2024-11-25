import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/document_batch_model.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_document_service.dart';
import 'package:ybb_master_app/core/services/program_document_setting_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class DocumentBatchDetail extends StatefulWidget {
  final DocumentBatchModel? documentBatch;

  const DocumentBatchDetail({super.key, this.documentBatch});

  @override
  State<DocumentBatchDetail> createState() => _DocumentBatchDetailState();
}

class _DocumentBatchDetailState extends State<DocumentBatchDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Document Batch Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets().buildTitleTextItem(
                "Document Batch Name",
                widget.documentBatch!.name!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Registration Start Date",
                CommonMethods.formatDate(widget.documentBatch!.startDate!),
              ),
              CommonWidgets().buildTitleTextItem(
                "Registration End Date",
                CommonMethods.formatDate(widget.documentBatch!.endDate!),
              ),
              CommonWidgets().buildTitleTextItem(
                "Document Availability Date",
                CommonMethods.formatDate(
                    widget.documentBatch!.availabilityDate!),
              ),
              CommonWidgets().buildTitleTextItem(
                "Custom Availability Date (in days) - 0 means documents are available after the availability date without any waiting time",
                widget.documentBatch!.customAvailability!,
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.orange,
                text: "Edit Document",
                onPressed: () {
                  // navigate to edit payment screen
                  context.pushNamed(
                      AppRouteConstants.addEditDocumentBatchRouteName,
                      extra: widget.documentBatch);
                },
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.red,
                text: "Delete Document",
                onPressed: () {
                  CommonHelper.showConfirmationDialog(
                      context, "Are you sure you want to delete this document?",
                      () async {
                    // delete payment
                    await ProgramDocumentSettingService()
                        .delete(widget.documentBatch!.id!)
                        .then((value) {
                      Provider.of<ProgramProvider>(context, listen: false)
                          .removeDocumentBatch(widget.documentBatch!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Document batch deleted successfully"),
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
