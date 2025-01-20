import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/core/models/paper_detail_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_topic_model.dart';
import 'package:ybb_master_app/core/models/paper_revision_model.dart';
import 'package:ybb_master_app/core/services/paper_abstract_service.dart';
import 'package:ybb_master_app/core/services/paper_author_service.dart';
import 'package:ybb_master_app/core/services/paper_detail_service.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_topic_service.dart';
import 'package:ybb_master_app/core/services/paper_revision_service.dart';
import 'package:ybb_master_app/core/services/paper_topic_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/providers/reviewer_paper_provider.dart';
import 'package:ybb_master_app/screens/reviewers/participant_abstract.dart';
import 'package:ybb_master_app/screens/reviewers/reviewer_history_list.dart';

class ReviewerPaperData {
  List<PaperAuthorModel> paperAuthors = [];
  List<PaperRevisionModel> paperRevisions = [];
  PaperDetailModel? paperDetail;
  PaperAbstractModel? paperAbstract;

  ReviewerPaperData({
    required this.paperAuthors,
    required this.paperDetail,
    required this.paperAbstract,
    required this.paperRevisions,
  });
}

class DashboardReviewer extends StatefulWidget {
  const DashboardReviewer({super.key});

  static const String routeName = "dashboard_reviewer";
  static const String pathName = "/dashboard-reviewer";

  @override
  State<DashboardReviewer> createState() => _DashboardReviewerState();
}

class _DashboardReviewerState extends State<DashboardReviewer> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    String? programId =
        Provider.of<ProgramProvider>(context, listen: false).currentProgram!.id;

    List<PaperDetailModel> tempDetails = [];
    List<PaperAbstractModel> tempAbstracts = [];
    List<PaperRevisionModel> tempRevisions = [];

    List<ReviewerPaperData> tempData = [];

    await PaperDetailService().getAll(programId).then((details) async {
      tempDetails = details!;

      await PaperRevisionService().getAll().then((revisions) async {
        tempRevisions = revisions!;

        await PaperAbstractService().getAll(programId).then((abstracts) async {
          tempAbstracts = abstracts!;

          for (var item in tempDetails) {
            if (item.paperAbstractId != null && item.paperTopicId != null) {
              PaperAbstractModel? matchingAbstract;

              await PaperAuthorService().getAll(item.id).then((authors) {
                for (var abstract in tempAbstracts) {
                  if (abstract.id == item.paperAbstractId) {
                    matchingAbstract = abstract;
                  }
                }

                List<PaperRevisionModel> matchingRevisions = [];

                for (var revision in tempRevisions) {
                  if (revision.paperDetailId == item.id) {
                    matchingRevisions.add(revision);
                  }
                }

                ReviewerPaperData data = ReviewerPaperData(
                  paperAuthors: authors!,
                  paperDetail: item,
                  paperAbstract: matchingAbstract,
                  paperRevisions: matchingRevisions,
                );

                tempData.add(data);

                setState(() {
                  isLoading = false;
                });
              }).onError((error, stackTrace) {
                print("Error: $error");
              });
            }
          }
        }).onError((error, stackTrace) {
          print("Error: $error");
        });

        print("temprevisions: " + tempRevisions.length.toString());
      }).onError((error, stackTrace) {
        print("Error: $error");
      });
    }).onError((error, stackTrace) {
      print("Error: $error");
    });

    // get reviewer topics
    List<PaperReviewerTopicModel> reviewerTopics =
        Provider.of<PaperProvider>(context, listen: false).reviewerTopics;

    List<PaperReviewerTopicModel> currentReviewerTopics = [];

    for (var topic in reviewerTopics) {
      if (topic.paperReviewerId ==
          Provider.of<PaperProvider>(context, listen: false)
              .currentReviewer!
              .id) {
        currentReviewerTopics.add(topic);
      }
    }

    print(currentReviewerTopics.length);

    // remove abstracts that do not match the current reviewer's topic
    if (currentReviewerTopics.isEmpty) {
      Provider.of<ReviewerPaperProvider>(context, listen: false)
          .reviewerPaperData = tempData;
      return;
    } else {
      List<ReviewerPaperData> temp = [];

      for (var topic in currentReviewerTopics) {
        for (var data in tempData) {
          if (data.paperDetail!.paperTopicId == topic.paperTopicId) {
            temp.add(data);
          }
        }
      }

      Provider.of<ReviewerPaperProvider>(context, listen: false)
          .reviewerPaperData = temp;
    }
  }

  buildProfileSummary() {
    PaperReviewerModel reviewer =
        Provider.of<PaperProvider>(context, listen: false).currentReviewer!;

    var topics = Provider.of<PaperProvider>(context, listen: false).paperTopics;
    var reviewerTopics =
        Provider.of<PaperProvider>(context, listen: false).reviewerTopics;

    String topicName = "";

    // check if reviewer topics contain the current reviewer's topic
    bool hasTopic = false;

    for (var topic in reviewerTopics) {
      if (topic.paperReviewerId == reviewer.id) {
        hasTopic = true;
        break;
      }
    }

    if (hasTopic) {
      List<String> topicNames = [];
      for (var topic in reviewerTopics) {
        for (var t in topics) {
          if (t.id == topic.paperTopicId &&
              topic.paperReviewerId == reviewer.id) {
            topicNames.add(t.topicName!);
          }
        }
      }

      topicName =
          "${topicNames.length} Assigned topics: ${topicNames.join(", ")}";
    } else {
      topicName = "No assigned topics yet";
    }

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Reviewer Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Text(
            reviewer.name ?? "-",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            reviewer.email ?? "-",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            topicName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  buildReviewerDashboardContent() {
    // create a tab bar view here with two tabs: "Abstracts" and "Comment History"
    return const Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: "Abstracts",
                ),
                Tab(
                  text: "Revision History",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Abstracts tab
                  ParticipantAbstractList(),
                  // Comment History tab
                  ReviewerHistoryList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: "Reviewer Dashboard",
        isBackEnabled: false,
      ),
      body: Row(
        children: [
          buildProfileSummary(),
          // create a tab bar view here
          buildReviewerDashboardContent(),
        ],
      ),
    );
  }
}
