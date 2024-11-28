import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/routes/router_config.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_service.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/screens/admin/users/reviewers/add_edit_reviewer.dart';

class ReviewerTile extends StatelessWidget {
  final PaperReviewerModel reviewer;
  const ReviewerTile({super.key, required this.reviewer});

  @override
  Widget build(BuildContext context) {
    var paperProvider = Provider.of<PaperProvider>(context);

    String? topicName = paperProvider.paperTopics
            .firstWhere((element) => element.id == reviewer.paperTopicId)
            .topicName ??
        "-";
    // make a card for each reviewer
    return Card(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey[300],
        elevation: 3,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewer.name ?? "-",
                      style: AppTextStyleConstants.headingTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      reviewer.email ?? "-",
                      style: AppTextStyleConstants.bodyTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      topicName ?? "-",
                      style: AppTextStyleConstants.bodyTextStyle,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // buttons
                  CommonWidgets().buildCustomButton(
                      width: 100,
                      color: Colors.orange,
                      text: "Edit",
                      onPressed: () {
                        context.pushNamed(AddEditReviewer.routeName,
                            extra: reviewer);
                      }),
                  const SizedBox(width: 10),
                  CommonWidgets().buildCustomButton(
                      width: 100,
                      color: Colors.red,
                      text: "Delete",
                      onPressed: () {
                        // show a dialog to confirm deletion
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Reviewer"),
                              content: const Text(
                                  "Are you sure you want to delete this reviewer?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // delete the reviewer
                                    await PaperReviewerService()
                                        .delete(reviewer.id!)
                                        .then((value) {
                                      Provider.of<PaperProvider>(context,
                                              listen: false)
                                          .paperReviewers
                                          .remove(reviewer);
                                      context.pop();
                                    });
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
