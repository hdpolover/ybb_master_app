import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/users/participant_essay_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';

class PEssays extends StatelessWidget {
  final ParticipantModel participant;
  const PEssays({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    var participantProvider = Provider.of<ParticipantProvider>(context);

    List<ParticipantEssayModel> essays =
        participantProvider.selectedParticipantEssays;

    return essays.isEmpty
        ? const Center(
            child: Text("No essays available"),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.builder(
                itemCount: essays.length,
                itemBuilder: (context, index) {
                  return CommonWidgets().buildTitleTextItem(
                      essays[index].questions!, essays[index].answer ?? "-");
                }),
          );
  }
}
