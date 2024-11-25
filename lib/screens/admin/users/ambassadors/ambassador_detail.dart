import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/services/ambassador_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/screens/admin/users/ambassadors/participant_tile.dart';

class AmbassadorDetail extends StatefulWidget {
  final AmbassadorModel ambassador;
  const AmbassadorDetail({super.key, required this.ambassador});

  @override
  State<AmbassadorDetail> createState() => _AmbassadorDetailState();
}

class _AmbassadorDetailState extends State<AmbassadorDetail> {
  List<ParticipantModel> participants = [];

  @override
  void initState() {
    super.initState();

    getParticipants();
  }

  getParticipants() async {
    // get the data
    await AmbassadorService()
        .getReferredParticipants(widget.ambassador.refCode!)
        .then((value) {
      setState(() {
        participants = value;
      });
    });
  }

  buildParticipantSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("List of Participants",
            style: AppTextStyleConstants.headingTextStyle
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        participants.isEmpty
            ? Text("No participants referred yet",
                style: AppTextStyleConstants.bodyTextStyle)
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ParticipantTile(
                          participantModel: participants[index]),
                    );
                  },
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Ambassador Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ambassador Details",
                          style: AppTextStyleConstants.headingTextStyle
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text("Name: ${widget.ambassador.name}",
                          style: AppTextStyleConstants.bodyTextStyle),
                      const SizedBox(height: 10),
                      Text("Email: ${widget.ambassador.email}",
                          style: AppTextStyleConstants.bodyTextStyle),
                      const SizedBox(height: 10),
                      Text("Referral Code: ${widget.ambassador.refCode}",
                          style: AppTextStyleConstants.bodyTextStyle),
                      const SizedBox(height: 10),
                      Text("Total Participants: ${participants.length}",
                          style: AppTextStyleConstants.bodyTextStyle),
                    ],
                  ),
                ),
              ),
            ),
            // participant section
            buildParticipantSection(),
          ],
        ),
      ),
    );
  }
}
