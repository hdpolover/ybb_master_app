import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/custom_pager.dart';
import 'package:ybb_master_app/core/helpers/nav_helper.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
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
  int _rowsPerPage = 5;
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

  Map<String, dynamic> filters = {
    "topic": "all",
    "status": "all",
    "reviewer": "all",
  };

  showFilterDialog() {
    List<Map<String, dynamic>> topics = [];

    List<PaperTopicModel> globalTopics =
        Provider.of<PaperProvider>(context, listen: false).paperTopics;

    for (var topic in globalTopics) {
      topics.add({
        "topicName": topic.topicName,
        "topicId": topic.id,
      });
    }

    Map<String, dynamic> reviewers = {};

    List<PaperReviewerModel> globalReviewers =
        Provider.of<PaperProvider>(context, listen: false).paperReviewers;

    for (var reviewer in globalReviewers) {
      reviewers[reviewer.id!] = reviewer.name;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter Abstracts"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Topics"),
                  const SizedBox(height: 10),
                  // create dropdown for topics
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    value: filters["topic"] == "all" ? "all" : filters["topic"],
                    hint: const Text("Select Topic"),
                    items: [
                      const DropdownMenuItem(
                        value: "all",
                        child: Text("All Topics"),
                      ),
                      for (var topic in topics)
                        DropdownMenuItem(
                          value: topic["topicId"],
                          child: Text(topic["topicName"]),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filters["topic"] = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status"),
                  const SizedBox(height: 10),
                  // create dropdown for status
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    value:
                        filters["status"] == "all" ? "all" : filters["status"],
                    hint: const Text("Select Status"),
                    items: const [
                      DropdownMenuItem(
                        value: "all",
                        child: Text("All Status"),
                      ),
                      DropdownMenuItem(
                        value: "0",
                        child: Text("Created"),
                      ),
                      DropdownMenuItem(
                        value: "1",
                        child: Text("Under Review"),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text("Accepted"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filters["status"] = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // create dropdown for reviewers
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reviewer"),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    value: filters["reviewer"] == "all"
                        ? "all"
                        : filters["reviewer"],
                    hint: const Text("Select Reviewer"),
                    items: [
                      const DropdownMenuItem(
                        value: "all",
                        child: Text("All Reviewers"),
                      ),
                      for (var reviewer in reviewers.entries)
                        DropdownMenuItem(
                          value: reviewer.key,
                          child: Text(reviewer.value),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filters["reviewer"] = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  showStatisticsDialog() {
    List<ReviewerPaperData> data =
        Provider.of<ReviewerPaperProvider>(context, listen: false)
            .reviewerPaperData;

    int created = 0;
    int underReview = 0;
    int accepted = 0;

    for (var paper in data) {
      if (paper.paperAbstract!.status == "0") {
        created++;
      } else if (paper.paperAbstract!.status == "1") {
        underReview++;
      } else if (paper.paperAbstract!.status == "2") {
        accepted++;
      }
    }

    List<PaperTopicModel> topics =
        Provider.of<PaperProvider>(context, listen: false).paperTopics;

    Map<String, String> abstractCountBasedOnTopic = {};

    for (var topic in topics) {
      int count = 0;

      for (var paper in data) {
        if (paper.paperDetail!.paperTopicId == topic.id) {
          count++;
        }
      }

      abstractCountBasedOnTopic[topic.id!] = count.toString();
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Abstract Statistics",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Total Abstracts: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(data.length.toString()),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Created: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(created.toString()),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Under Review: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(underReview.toString()),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Accepted: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Text(accepted.toString()),
                      ],
                    ),
                  ],
                ),
                // add divider
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 30,
                ),
                // show abstract count based on topic
                const Text("Abstract Count Based on Topic: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                for (var topic in abstractCountBasedOnTopic.entries)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Provider.of<PaperProvider>(context, listen: false)
                            .paperTopics
                            .where((element) {
                              return element.id == topic.key;
                            })
                            .first
                            .topicName!,
                      ),
                      Text(topic.value),
                    ],
                  ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonWidgets.buildCommonButton(
                      width: 100,
                      text: "Close",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildFilterRow() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonWidgets().buildCustomButton(
            width: 100,
            text: "Statistics",
            onPressed: () {
              // show filter dialog
              showStatisticsDialog();
            },
          ),
          const SizedBox(width: 10),
          CommonWidgets().buildCustomButton(
            width: 100,
            text: "Filter",
            onPressed: () {
              // show filter dialog
              showFilterDialog();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var reviewerDataProvider = Provider.of<ReviewerPaperProvider>(context);

    List<ReviewerPaperData> data = reviewerDataProvider.reviewerPaperData;

    List<ReviewerPaperData> filteredData = data;

    // sort list the ones with status "created" first and created at descending
    filteredData.sort((a, b) {
      if (a.paperAbstract!.status == "0" &&
          b.paperAbstract!.createdAt!.compareTo(a.paperAbstract!.createdAt!) ==
              0) {
        return -1;
      } else {
        return b.paperAbstract!.createdAt!
            .compareTo(a.paperAbstract!.createdAt!);
      }
    });

    // filter data based on the selected filters
    filteredData = filteredData.where((element) {
      // filter every element based on the selected filters and return true if it matches
      if (filters["topic"] != "all") {
        if (element.paperDetail!.paperTopicId != filters["topic"]) {
          return false;
        }
      }

      if (filters["status"] != "all") {
        if (element.paperAbstract!.status != filters["status"]) {
          return false;
        }
      }

      if (filters["reviewer"] != "all") {
        // loop through paper revisions, and if any of the reviewer id matches the selected reviewer id, return true
        for (var revision in element.paperRevisions) {
          if (revision.paperReviewerId == filters["reviewer"]) {
            return true;
          }
        }
      }

      return true;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          _buildFilterRow(),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PaginatedDataTable2(
                  dataRowHeight: 100,
                  headingRowHeight: 100,
                  headingTextStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  headingRowDecoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
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
                  wrapInCard: false,
                  renderEmptyRowsInTheEnd: false,
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => Colors.grey[200]!),
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
                  sortArrowAnimationDuration: const Duration(
                      milliseconds: 0), // custom animation duration
                  // onSelectAll: _dessertsDataSource.selectAll,
                  controller: getCurrentRouteOption(context) == custPager
                      ? _controller
                      : null,
                  hidePaginator: getCurrentRouteOption(context) == custPager,
                  columns: _columns,
                  empty: Center(
                      child: Text(
                          // if any of the filters is not "all", then show this message
                          filteredData.isEmpty
                              ? 'No abstracts found with the selected filters'
                              : 'No abstracts with your assigned topics found',
                          style: const TextStyle(color: Colors.red))),
                  source: getCurrentRouteOption(context) == noData
                      ? ReviewerDataTableSource.empty(context)
                      : ReviewerDataTableSource(
                          context,
                          filteredData,
                        ),
                  showCheckboxColumn: false,
                ),
                if (getCurrentRouteOption(context) == custPager)
                  Positioned(bottom: 16, child: CustomPager(_controller!)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
