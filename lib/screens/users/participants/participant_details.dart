import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_basic_info.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_essays.dart';
import 'package:ybb_master_app/screens/users/participants/detail_tabs/p_payments.dart';

class ParticipantDetails extends StatefulWidget {
  final ParticipantModel participant;
  const ParticipantDetails({super.key, required this.participant});

  @override
  State<ParticipantDetails> createState() => _ParticipantDetailsState();
}

class _ParticipantDetailsState extends State<ParticipantDetails>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // i want a page with tabs for basic info, essays, and payments
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Participant Details"),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Basics",
                ),
                Tab(
                  text: "Essays",
                ),
                Tab(
                  text: "Documents",
                ),
                Tab(
                  text: "Payments",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PBasicInfo(
                  participant: widget.participant,
                ),
                PEssays(
                  participant: widget.participant,
                ),
                Container(),
                PPayments(participant: widget.participant),
              ],
            ),
          )
        ],
      ),
    );
  }
}
