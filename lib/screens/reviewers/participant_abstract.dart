import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/custom_pager.dart';
import 'package:ybb_master_app/core/helpers/nav_helper.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';
import 'package:ybb_master_app/screens/reviewers/reviewer_data_table_source.dart';

class ParticipantAbstractList extends StatefulWidget {
  const ParticipantAbstractList({super.key});

  static const String routeName = "participant_abstract_list";
  static const String pathName = "/participant_abstract-list";

  @override
  State<ParticipantAbstractList> createState() =>
      _ParticipantAbstractListState();
}

class _ParticipantAbstractListState extends State<ParticipantAbstractList> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late ReviewerDataTableSource _reviewerDataTableSource;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _reviewerDataTableSource = ReviewerDataTableSource(
          context,
          Provider.of<ReviewerPaperProvider>(context, listen: false)
              .reviewerPaperData);

      _controller = PaginatorController();

      if (getCurrentRouteOption(context) == defaultSorting) {
        _sortColumnIndex = 1;
      }
      _initialized = true;
    }
  }

  void sort<T>(
    Comparable<T> Function(ReviewerPaperData d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _reviewerDataTableSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _reviewerDataTableSource.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      const DataColumn(
        label: Text('No.'),
        // onSort: (columnIndex, ascending) =>
        //     sort<String>((d) => d., columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Name(s)'),
        onSort: (columnIndex, ascending) {
          String mergedNames = _reviewerDataTableSource.mergeAuthorNames(
              _reviewerDataTableSource.papers![0].paperAuthors);
          sort<String>((d) => mergedNames, columnIndex, ascending);
        },
      ),
      DataColumn(
        label: const Text('Email(s)'),
        onSort: (columnIndex, ascending) {
          String mergedEmails = _reviewerDataTableSource.mergeAuthorEmails(
              _reviewerDataTableSource.papers![0].paperAuthors);
          sort<String>((d) => mergedEmails, columnIndex, ascending);
        },
      ),
      DataColumn(
        label: const Text('Topic'),
        onSort: (columnIndex, ascending) => sort<num>(
            (d) => d.paperDetail!.paperTopicId!, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Title'),
        onSort: (columnIndex, ascending) => sort<String>(
            (d) => d.paperAbstract!.title!, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Status'),
        // onSort: (columnIndex, ascending) =>
        //     sort<num>((d) => d.carbs, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Last Edit'),
        numeric: true,
        onSort: (columnIndex, ascending) => sort<DateTime>(
            (d) => d.paperDetail!.updatedAt!, columnIndex, ascending),
      ),
      const DataColumn(
        label: Text('Actions'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var reviewerDataProvider = Provider.of<ReviewerPaperProvider>(context);
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
            horizontalMargin: 20,
            checkboxHorizontalMargin: 12,
            columnSpacing: 0,
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
            minWidth: 800,
            fit: FlexFit.tight,
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
            empty: Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey[200],
                    child: const Text('No data'))),
            source: getCurrentRouteOption(context) == noData
                ? ReviewerDataTableSource.empty(context)
                : ReviewerDataTableSource(
                    context,
                    reviewerDataProvider.reviewerPaperData,
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
