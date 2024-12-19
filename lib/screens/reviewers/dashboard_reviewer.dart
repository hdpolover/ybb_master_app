import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/menu_card.dart';
import 'package:ybb_master_app/screens/reviewers/participant_abstract.dart';
import 'package:ybb_master_app/screens/reviewers/reviewer_history_list.dart';
import 'package:ybb_master_app/screens/reviewers/reviewer_personal_setting.dart';

class DashboardReviewer extends StatefulWidget {
  const DashboardReviewer({super.key});

  static const String routeName = "dashboard_reviewer";
  static const String pathName = "/dashboard-reviewer";

  @override
  State<DashboardReviewer> createState() => _DashboardReviewerState();
}

class _DashboardReviewerState extends State<DashboardReviewer> {
  List<MenuCard> menuCards = [
    const MenuCard(
      title: "Participants Abstracts",
      icon: Icons.article,
      routeName: ParticipantAbstractList.routeName,
    ),
    const MenuCard(
      title: "Abstract Comment History",
      icon: Icons.history,
      routeName: ReviewerHistoryList.routeName,
    ),
    const MenuCard(
      title: "Personal Setting",
      icon: Icons.person,
      routeName: ReviewerPersonalSetting.routeName,
    ),
  ];

  buildProfileSummary() {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.3,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Reviewer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Reviewer ID: 123456",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Reviewer Name: John Doe",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  buildReviewerDashboardContent() {
    // create a tab bar view here with two tabs: "Abstracts" and "Comment History"
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: "Abstracts",
                ),
                Tab(
                  text: "Comment History",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Abstracts tab
                  ParticipantAbstractList(),
                  // Comment History tab
                  const ReviewerHistoryList(),
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
          // Expanded(
          //   child: GridView.builder(
          //       padding: const EdgeInsets.all(20),
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 3,
          //         crossAxisSpacing: 20,
          //         mainAxisSpacing: 20,
          //         childAspectRatio: 0.6,
          //       ),
          //       itemCount: menuCards.length,
          //       itemBuilder: (context, index) {
          //         return menuCards[index];
          //       }),
          // ),
        ],
      ),
    );
  }
}
