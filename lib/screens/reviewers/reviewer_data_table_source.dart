import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';

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

  @override
  DataRow getRow(int index) {
    final ReviewerPaperData paper = papers![index];
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    indexNumber++;

    return DataRow2.byIndex(
      index: index,
      cells: [
        DataCell(Text((index).toString())),
        DataCell(Text(mergeAuthorNames(paper.paperAuthors))),
        DataCell(Text(mergeAuthorEmails(paper.paperAuthors))),
        DataCell(Text(paper.paperDetail!.paperTopicId!)),
        DataCell(Text(paper.paperAbstract!.title!)),
        const DataCell(Text("0")),
        DataCell(Text(formatter.format(paper.paperDetail!.createdAt!))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.remove_red_eye),
            onPressed: () {
              // Navigator.of(context).pushNamed(
              //   ParticipantAbstractList.routeName,
              //   arguments: paper,
              // );
            },
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
