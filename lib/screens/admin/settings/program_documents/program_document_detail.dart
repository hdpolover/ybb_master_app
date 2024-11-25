import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_document_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class ProgramDocumentDetail extends StatefulWidget {
  final ProgramDocumentModel? programDocument;

  const ProgramDocumentDetail({super.key, this.programDocument});

  @override
  State<ProgramDocumentDetail> createState() => _ProgramDocumentDetailState();
}

class _ProgramDocumentDetailState extends State<ProgramDocumentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Program Document Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets().buildTitleTextItem(
                "Document Name",
                widget.programDocument!.name!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Document Description",
                widget.programDocument!.desc!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Document Drive URL",
                widget.programDocument!.driveUrl!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Document File URL",
                widget.programDocument!.fileUrl!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Is Document Generated?",
                widget.programDocument!.isGenerated! == "1" ? "Yes" : "No",
              ),
              CommonWidgets().buildTitleTextItem(
                "Is Document Uploaded?",
                widget.programDocument!.isUpload! == "1" ? "Yes" : "No",
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.orange,
                text: "Edit Document",
                onPressed: () {
                  // navigate to edit payment screen
                  context.pushNamed(
                      AppRouteConstants.addEditProgramDocumentRouteName,
                      extra: widget.programDocument);
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
                    await ProgramDocumentService()
                        .delete(widget.programDocument!.id!)
                        .then((value) {
                      Provider.of<ProgramProvider>(context, listen: false)
                          .removeProgramDocument(widget.programDocument!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Document deleted successfully"),
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
