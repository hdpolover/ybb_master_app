import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/core/models/paper_revision_model.dart';
import 'package:ybb_master_app/core/services/notification_service.dart';
import 'package:ybb_master_app/core/services/paper_abstract_service.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';
import 'package:ybb_master_app/screens/reviewers/paper_detail_page.dart';

// create a data table source for the data table with domain from the data table 2 package ReviewerPaperData model
class ReviewerDataTableSource extends DataTableSource {
  List<ReviewerPaperData>? papers;
  final BuildContext context;

  // ReviewerDataTableSource(this.papers, this.context);

  ReviewerDataTableSource(
    this.context,
    this.papers,
  ) {
    papers = papers;
  }

  ReviewerDataTableSource.empty(this.context) {
    papers = Provider.of<ReviewerPaperProvider>(context, listen: false)
        .reviewerPaperData;
  }

  String reviewerName(List<PaperRevisionModel> revisions) {
    String name = "";

    List<String> reviewerIds = [];

    // get reviewer ids from revisions unique
    for (var reviewer in revisions) {
      if (!reviewerIds.contains(reviewer.paperReviewerId)) {
        reviewerIds.add(reviewer.paperReviewerId!);
      }
    }

    for (var id in reviewerIds) {
      for (var paperReviewer
          in Provider.of<PaperProvider>(context, listen: false)
              .paperReviewers) {
        if (id == paperReviewer.id) {
          if (name == "") {
            name += paperReviewer.name!;
          } else {
            name += ", ${paperReviewer.name!}";
          }
        }
      }
    }
    return name;
  }

  String mergeAuthorNames(List<PaperAuthorModel> authors) {
    String authorNames = "";

    for (int i = 0; i < authors.length; i++) {
      authorNames += authors[i].name!;

      if (i != authors.length - 1) {
        authorNames += ", ";
      }
    }

    return authorNames;
  }

  String mergeAuthorEmails(List<PaperAuthorModel> authors) {
    String authorEmails = "";

    for (int i = 0; i < authors.length; i++) {
      authorEmails += authors[i].email!;

      if (i != authors.length - 1) {
        authorEmails += ", ";
      }
    }

    return authorEmails;
  }

  String paperTopicName(String paperTopicId) {
    String topicName = "";

    for (var topic
        in Provider.of<PaperProvider>(context, listen: false).paperTopics) {
      if (topic.id == paperTopicId) {
        topicName = topic.topicName!;
      }
    }

    return topicName;
  }

  Text paperStatusChip(String status) {
    Color color = Colors.grey;
    String statusName = "";

    if (status == "0") {
      statusName = "Created";
      color = Colors.grey;
    } else if (status == "1") {
      statusName = "Under Review";
      color = Colors.orange;
    } else if (status == "2") {
      statusName = "Accepted";
      color = Colors.green;
    } else if (status == "3") {
      statusName = "Rejected";
      color = Colors.red;
    }

    return Text(
      statusName,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  bool isLoading = false;

  void acceptAbstract(ReviewerPaperData data,
      PaperAbstractModel currentAbstract, String emails) {
    CommonDialog.showConfirmationDialog(
      context,
      "Accept Abstract",
      "Are you sure you want to accept this abstract? The participant(s) will receive a letter of acceptance and be notified to proceed.",
      () async {
        isAcceptingNotifier.value = true;

        try {
          String programId =
              Provider.of<ProgramProvider>(context, listen: false)
                  .currentProgram!
                  .id!;
          await NotificationService()
              .sendEmail(emails, programId)
              .then((value) async {
            print(value);
            if (value) {
              // update abstract status to accepted
              await PaperAbstractService()
                  .updateStatus(currentAbstract.id.toString(), "2")
                  .then((value) {
                PaperAbstractModel paperAbstract = data.paperAbstract!;

                paperAbstract.status = "2";

                data.paperAbstract = paperAbstract;

                Provider.of<ReviewerPaperProvider>(context, listen: false)
                    .updateReviewerPaperData(data);

                isAcceptingNotifier.value = false;

                CommonDialog.showAlertDialog(
                    context, "Success", "Notification sent successfully",
                    isError: false, onConfirm: () {
                  Navigator.of(context, rootNavigator: true).pop();

                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              });
            } else {
              isAcceptingNotifier.value = false;
              CommonDialog.showAlertDialog(
                  context, "Error", "Failed to send notification",
                  isError: true, onConfirm: () {
                Navigator.of(context, rootNavigator: true).pop();

                Navigator.pop(context);
              });
            }
          });
        } catch (e) {
          isAcceptingNotifier.value = false;
          CommonDialog.showAlertDialog(context, "Error", e.toString());
        }
      },
    );
  }

  @override
  DataRow getRow(int index) {
    final ReviewerPaperData paper = papers![index];
    // format date and time to dd/MM/yyyy HH:mm
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return DataRow2.byIndex(
      index: index,
      specificRowHeight: 100,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Container(
            constraints: const BoxConstraints(
              maxHeight: 300, // Maximum width
              minHeight: 100, // Minimum width
            ),
            child: Center(child: Text(mergeAuthorNames(paper.paperAuthors))))),
        DataCell(Text(mergeAuthorEmails(paper.paperAuthors))),
        DataCell(Text(paperTopicName(paper.paperDetail!.paperTopicId!))),
        DataCell(Text(
          paper.paperAbstract!.title!,
          softWrap: true,
        )),
        DataCell(Center(child: paperStatusChip(paper.paperAbstract!.status!))),
        DataCell(Text(formatter.format(paper.paperAbstract!.createdAt!))),
        DataCell(Text(formatter.format(paper.paperAbstract!.updatedAt!))),
        DataCell(Text(paper.paperRevisions.isEmpty
            ? "-"
            : reviewerName(paper.paperRevisions))),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.blue,
                ),
                onPressed: () {
                  context.pushNamed(
                    PaperDetailPage.routeName,
                    extra: paper.paperDetail!.id,
                  );
                },
              ),
              // icon button with check icon
              paper.paperAbstract!.status! == "2"
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(
                        Icons.check_box,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        String emails = mergeAuthorEmails(paper.paperAuthors);

                        // remove space after comma
                        emails = emails.replaceAll(", ", ",");

                        acceptAbstract(paper, paper.paperAbstract!, emails);
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => papers!.length;

  @override
  int get selectedRowCount => 0;
}
