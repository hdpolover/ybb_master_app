import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/core/models/paper_revision_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/add_revision.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';

class PaperDetailPage extends StatefulWidget {
  final String paperDetailId;

  const PaperDetailPage({super.key, required this.paperDetailId});

  static const String routeName = "paper_detail";
  static const String pathName = "/paper-detail";

  @override
  State<PaperDetailPage> createState() => _PaperDetailPageState();
}

class _PaperDetailPageState extends State<PaperDetailPage> {
  _buildPaperSection(ReviewerPaperData reviewerPaperData) {
    // create a container card with a column of text widgets for the paper details
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets().buildTitleTextItem(
              "Author(s)", mergeAuthorNames(reviewerPaperData.paperAuthors)),
          CommonWidgets().buildTitleTextItem("Topic",
              getTopicName(reviewerPaperData.paperDetail!.paperTopicId!)),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          CommonWidgets().buildTitleTextItem(
              "Title", reviewerPaperData.paperAbstract!.title!),
          CommonWidgets().buildTitleTextItem(
              "Abstract", reviewerPaperData.paperAbstract!.content!),
          CommonWidgets().buildTitleTextItem(
              "Keywords", reviewerPaperData.paperAbstract!.keywords!),
        ],
      ),
    );
  }

  _buildRevisionSection(List<PaperRevisionModel> revisions) {
    // sort the revisions by date descending
    revisions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Revisions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CommonWidgets().buildCustomButton(
                width: 150,
                text: "Add Revision",
                onPressed: () {
                  context.pushNamed(AddRevision.routeName,
                      extra: widget.paperDetailId);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          // create a list view of the revisions
          revisions.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text("No revisions available"),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: revisions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(revisions[index].comment!),
                            const SizedBox(height: 10),
                            Text(
                              "Commented on ${DateFormat('yyyy-MM-dd HH:mm').format(revisions[index].createdAt!)}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var reviewerPaperProvider = Provider.of<ReviewerPaperProvider>(context);

    List<ReviewerPaperData> data = reviewerPaperProvider.reviewerPaperData;

    // get the paper data
    ReviewerPaperData reviewerPaperData = data.firstWhere(
        (element) => element.paperDetail!.id == widget.paperDetailId);

    // get the revision data for the paper
    List<PaperRevisionModel> revisions = [];

    for (var paper in data) {
      if (paper.paperDetail!.id == widget.paperDetailId) {
        revisions = paper.paperRevisions;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "Abstract Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _buildPaperSection(reviewerPaperData),
              const SizedBox(height: 20),
              _buildRevisionSection(revisions),
            ],
          ),
        ),
      ),
    );
  }

  String mergeAuthorNames(List<PaperAuthorModel> paperAuthors) {
    String mergedNames = "";

    for (int i = 0; i < paperAuthors.length; i++) {
      mergedNames += paperAuthors[i].name!;

      if (i != paperAuthors.length - 1) {
        mergedNames += ", ";
      }
    }

    return mergedNames;
  }

  String getTopicName(param0) {
    var topics = Provider.of<PaperProvider>(context, listen: false).paperTopics;

    String topicName = "";

    for (var topic in topics) {
      if (topic.id == param0) {
        topicName = topic.topicName!;
      }
    }

    return topicName;
  }
}
