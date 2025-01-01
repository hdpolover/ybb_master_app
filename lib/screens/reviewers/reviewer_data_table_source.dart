import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
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

    sort((d) => d.paperDetail!.id!, true);
  }

  ReviewerDataTableSource.empty(this.context) {
    papers = Provider.of<ReviewerPaperProvider>(context, listen: false)
        .reviewerPaperData;
  }

  void sort<T>(
      Comparable<T> Function(ReviewerPaperData d) getField, bool ascending) {
    papers!.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int indexNumber = 0;

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

  Chip paperStatusChip(String status) {
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

    return Chip(
      label: Text(
        statusName,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }

  @override
  DataRow getRow(int index) {
    final ReviewerPaperData paper = papers![index];
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    indexNumber++;

    return DataRow2.byIndex(
      index: index,
      specificRowHeight: 100,
      cells: [
        DataCell(Text((index).toString())),
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
        DataCell(paperStatusChip("0")),
        DataCell(Text(formatter.format(paper.paperDetail!.createdAt!))),
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
                    extra: paper,
                  );
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
