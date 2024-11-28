import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/users/complete_participant_data_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/ambassador_service.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_service.dart';
import 'package:ybb_master_app/core/services/participant_service.dart';
import 'package:ybb_master_app/core/services/participant_status_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/users/reviewers/reviewer_list.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<AmbassadorModel> ambassadors = [];
  bool isPaperProgram = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    // get the data
    var participantProvider =
        Provider.of<ParticipantProvider>(context, listen: false);

    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id
        .toString();

    String programTypeId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgramInfo!
        .programTypeId
        .toString();

    if (programTypeId == "3") {
      setState(() {
        isPaperProgram = true;
      });
    }

    if (participantProvider.participants.isEmpty) {
      // get the data
      await ParticipantService().getAll(programId).then((value) async {
        print(value.length);

        participantProvider.addParticipants(value);
      });
    }

    if (ambassadors.isEmpty) {
      // get the data
      await AmbassadorService().getAllByProgram(programId).then((value) {
        setState(() {
          ambassadors = value;
        });
      });
    }

    if (isPaperProgram) {
      await PaperReviewerService().getAll(programId).then((value) {
        List<PaperReviewerModel> paperReviewers = value;

        Provider.of<PaperProvider>(context, listen: false).paperReviewers =
            paperReviewers;
      });
    }
  }

  buildUserItemContainer(String name, int total, String route) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: $total',
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var participantProvider = Provider.of<ParticipantProvider>(context);

    List<Widget> userItems = [
      buildUserItemContainer(
          "Participants",
          participantProvider.participants.length,
          AppRouteConstants.participantListRouteName),
      buildUserItemContainer("Ambassadors", ambassadors.length,
          AppRouteConstants.ambassadorListRouteName),
      if (isPaperProgram)
        buildUserItemContainer(
            "Paper Reviewers",
            Provider.of<PaperProvider>(context).paperReviewers.length,
            ReviewerList.routeName),
      buildUserItemContainer("Partners", 0, ""),
    ];

    return Scaffold(
      appBar: const CommonAppBar(
        title: "Users",
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: userItems.length,
        itemBuilder: (context, index) {
          return userItems[index];
        },
      ),
    );
  }
}
