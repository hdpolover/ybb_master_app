import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/custom_pager.dart';
import 'package:ybb_master_app/core/helpers/nav_helper.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';
import 'package:ybb_master_app/screens/reviewers/reviewer_data_table_source.dart';

class ReviewerHistoryList extends StatefulWidget {
  const ReviewerHistoryList({super.key});

  static const String routeName = "reviewer_history_list";
  static const String pathName = "/reviewer-history-list";

  @override
  State<ReviewerHistoryList> createState() => _ReviewerHistoryListState();
}

class _ReviewerHistoryListState extends State<ReviewerHistoryList> {
  int _rowsPerPage = 5;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late ReviewerDataTableSource _reviewerDataTableSource;
  bool _initialized = false;
  PaginatorController? _controller;

  getReviewerPapers() {
    PaperReviewerModel reviewer =
        Provider.of<PaperProvider>(context, listen: false).currentReviewer!;

    List<ReviewerPaperData> data =
        Provider.of<ReviewerPaperProvider>(context, listen: false)
            .reviewerPaperData;

    List<ReviewerPaperData> reviewedPapers = data.where((element) {
      return element.paperRevisions.any((element) {
        return element.paperReviewerId == reviewer.id;
      });
    }).toList();

    return reviewedPapers;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // get only the papers that have been reviewed by the reviewer

      _reviewerDataTableSource =
          ReviewerDataTableSource(context, getReviewerPapers());

      _controller = PaginatorController();

      if (getCurrentRouteOption(context) == defaultSorting) {
        _sortColumnIndex = 1;
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _reviewerDataTableSource.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      const DataColumn2(
        fixedWidth: 50,
        label: Text('No.'),
        // onSort: (columnIndex, ascending) =>
        //     sort<String>((d) => d., columnIndex, ascending),
      ),
      const DataColumn2(
          label: Text('Name(s)'),
          // onSort: (columnIndex, ascending) {
          //   String mergedNames = _reviewerDataTableSource.mergeAuthorNames(
          //       _reviewerDataTableSource.papers![0].paperAuthors);
          //   sort<String>((d) => mergedNames, columnIndex, ascending);
          // },
          size: ColumnSize.L),
      const DataColumn2(
        size: ColumnSize.L,
        label: Text('Email(s)'),
        // onSort: (columnIndex, ascending) {
        //   String mergedEmails = _reviewerDataTableSource.mergeAuthorEmails(
        //       _reviewerDataTableSource.papers![0].paperAuthors);
        //   sort<String>((d) => mergedEmails, columnIndex, ascending);
        // },
      ),
      const DataColumn2(
        size: ColumnSize.L,
        label: Text('Topic'),
        // onSort: (columnIndex, ascending) => sort<num>(
        //     (d) => d.paperDetail!.paperTopicId!, columnIndex, ascending),
      ),
      const DataColumn2(
        size: ColumnSize.L,
        label: Text('Title'),
        // onSort: (columnIndex, ascending) => sort<String>(
        //     (d) => d.paperAbstract!.title!, columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Status'),
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.carbs, columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Created At'),
        // onSort: (columnIndex, ascending) => sort<DateTime>(
        //     (d) => d.paperAbstract!.updatedAt!, columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Updated At'),
        // onSort: (columnIndex, ascending) => sort<DateTime>(
        //     (d) => d.paperAbstract!.updatedAt!, columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Reviewed By'),
        // onSort: (columnIndex, ascending) => sort<DateTime>(
        //     (d) => d.paperAbstract!.updatedAt!, columnIndex, ascending),
      ),
      const DataColumn2(
        label: Text('Actions'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<ReviewerPaperData> data = getReviewerPapers();

    // sort the data by last created
    data.sort((a, b) {
      return b.paperDetail!.createdAt!.compareTo(a.paperDetail!.createdAt!);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PaginatedDataTable2(
            // actions: [
            //   IconButton(
            //       icon: const Icon(Icons.info),
            //       onPressed: () {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //             content: Text('This is a custom info message'),
            //           ),
            //         );
            //       }),
            // ],
            // 100 Won't be shown since it is smaller than total records
            availableRowsPerPage: const [2, 5, 10, 30, 100],
            checkboxHorizontalMargin: 12,
            horizontalMargin: 12,
            wrapInCard: false,
            renderEmptyRowsInTheEnd: false,
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.grey[200]!),
            // header: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text('PaginatedDataTable2'),
            //     if (kDebugMode && getCurrentRouteOption(context) == custPager)
            //       Row(children: [
            //         OutlinedButton(
            //             onPressed: () => _controller!.goToPageWithRow(25),
            //             child: const Text('Go to row 25')),
            //         OutlinedButton(
            //             onPressed: () => _controller!.goToRow(5),
            //             child: const Text('Go to row 5'))
            //       ]),
            //     if (getCurrentRouteOption(context) == custPager &&
            //         _controller != null)
            //       PageNumber(controller: _controller!)
            //   ],
            // ),
            rowsPerPage: _rowsPerPage,
            autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
            fit: FlexFit.loose,
            border: TableBorder(
                top: const BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.grey[300]!),
                left: BorderSide(color: Colors.grey[300]!),
                right: BorderSide(color: Colors.grey[300]!),
                verticalInside: BorderSide(color: Colors.grey[300]!),
                horizontalInside:
                    const BorderSide(color: Colors.grey, width: 1)),
            onRowsPerPageChanged: (value) {
              // No need to wrap into setState, it will be called inside the widget
              // and trigger rebuild
              //setState(() {
              _rowsPerPage = value!;
              print(_rowsPerPage);
              //});
            },
            initialFirstRowIndex: 0,
            onPageChanged: (rowIndex) {
              print(rowIndex / _rowsPerPage);
            },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
            sortArrowAnimationDuration:
                const Duration(milliseconds: 0), // custom animation duration
            // onSelectAll: _dessertsDataSource.selectAll,
            controller: getCurrentRouteOption(context) == custPager
                ? _controller
                : null,
            hidePaginator: getCurrentRouteOption(context) == custPager,
            columns: _columns,
            empty: const Center(
                child: Text('You have not reviewed any papers yet.',
                    style: TextStyle(color: Colors.red))),
            source: getCurrentRouteOption(context) == noData
                ? ReviewerDataTableSource.empty(context)
                : ReviewerDataTableSource(
                    context,
                    data,
                  ),
            showCheckboxColumn: false,
          ),
          if (getCurrentRouteOption(context) == custPager)
            Positioned(bottom: 16, child: CustomPager(_controller!)),
        ],
      ),
    );
  }
}
