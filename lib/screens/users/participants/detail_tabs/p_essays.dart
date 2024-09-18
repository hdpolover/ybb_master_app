import 'dart:math';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/users/participant_essay_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/services/participant_service.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';

class PEssays extends StatefulWidget {
  final ParticipantModel participant;
  const PEssays({super.key, required this.participant});

  @override
  State<PEssays> createState() => _PEssaysState();
}

class _PEssaysState extends State<PEssays> {
  List<ParticipantEssayModel> essays = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    // get the data
    await ParticipantService()
        .getEssayByParticipantId(widget.participant.id)
        .then((value) {
      setState(() {
        essays = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      setState(() {
        essays = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
