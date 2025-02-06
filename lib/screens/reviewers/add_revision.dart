import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';
import 'package:ybb_master_app/core/models/paper_revision_model.dart';
import 'package:ybb_master_app/core/services/paper_abstract_service.dart';
import 'package:ybb_master_app/core/services/paper_revision_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';

class AddRevision extends StatefulWidget {
  final String paperDetailId;
  const AddRevision({super.key, required this.paperDetailId});

  static const String routeName = "add_revision";
  static const String pathName = "/add-revision";

  @override
  State<AddRevision> createState() => _AddRevisionState();
}

class _AddRevisionState extends State<AddRevision> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _commentKey = GlobalKey<FormBuilderFieldState>();

  bool _isLoading = false;

  saveComment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      PaperRevisionModel paperRevision = PaperRevisionModel(
        paperDetailId: widget.paperDetailId,
        paperReviewerId: Provider.of<PaperProvider>(context, listen: false)
            .currentReviewer!
            .id,
        comment: _commentKey.currentState!.value,
      );

      // save the comment
      // add the comment to the database
      await PaperRevisionService().save(paperRevision).then((value) async {
        setState(() {
          _isLoading = false;
        });

        // update reviewer paper data with the new comment
        ReviewerPaperData reviewerPaperData =
            Provider.of<ReviewerPaperProvider>(context, listen: false)
                .reviewerPaperData
                .firstWhere((element) =>
                    element.paperDetail!.id == widget.paperDetailId);

        paperRevision.createdAt = DateTime.now();

        reviewerPaperData.paperRevisions.add(paperRevision);

        await PaperAbstractService()
            .updateStatus(reviewerPaperData.paperAbstract!.id!, "1")
            .then((value) {
          PaperAbstractModel paperAbstract = reviewerPaperData.paperAbstract!;

          paperAbstract.status = "1";

          reviewerPaperData.paperAbstract = paperAbstract;

          Provider.of<ReviewerPaperProvider>(context, listen: false)
              .updateReviewerPaperData(reviewerPaperData);

          CommonDialog.showAlertDialog(
              context, "Success", "Comment added successfully", isError: false,
              onConfirm: () {
            Navigator.of(context, rootNavigator: true).pop();

            Navigator.pop(context);
          });
        });
      }).onError((error, stackTrace) {
        print(error);
        setState(() {
          _isLoading = false;
        });

        CommonDialog.showAlertDialog(
            context, "Error", "Failed to add comment. Please try again",
            isError: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(
          title: "Add Revision",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  CommonWidgets().buildTextField(
                    _commentKey,
                    "comment",
                    "Revision Comment",
                    [
                      FormBuilderValidators.required(
                          errorText: "Please enter your comment"),
                    ],
                    lines: 5,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const LoadingWidget()
                      : CommonWidgets().buildCustomButton(
                          text: "Save Comment",
                          onPressed: saveComment,
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
