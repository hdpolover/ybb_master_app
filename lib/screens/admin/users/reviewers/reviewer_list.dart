import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/services/paper_topic_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/users/reviewers/add_edit_reviewer.dart';
import 'package:ybb_master_app/screens/admin/users/reviewers/reviewer_tile.dart';

class ReviewerList extends StatefulWidget {
  const ReviewerList({super.key});

  static const String routeName = "reviewer_list";
  static const String pathName = "reviewer_list";

  @override
  State<ReviewerList> createState() => _ReviewerListState();
}

class _ReviewerListState extends State<ReviewerList> {
  @override
  void initState() {
    super.initState();

    checkPaperTopics();
  }

  void checkPaperTopics() async {
    List<PaperTopicModel> paperTopics =
        Provider.of<PaperProvider>(context, listen: false).paperTopics;

    if (paperTopics.isEmpty) {
      String programId = Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id!;

      await PaperTopicService().getAll(programId).then((value) {
        Provider.of<PaperProvider>(context, listen: false).paperTopics = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var paperProvider = Provider.of<PaperProvider>(context);

    List<PaperReviewerModel> reviewers = paperProvider.paperReviewers;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Reviewers"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          context.pushNamed(AddEditReviewer.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemCount: reviewers.length,
        itemBuilder: (context, index) {
          PaperReviewerModel reviewer = reviewers[index];

          return ReviewerTile(reviewer: reviewer);
        },
      ),
    );
  }
}
