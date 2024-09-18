import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';

class PBasicInfo extends StatefulWidget {
  final ParticipantModel participant;
  const PBasicInfo({super.key, required this.participant});

  @override
  State<PBasicInfo> createState() => _PBasicInfoState();
}

class _PBasicInfoState extends State<PBasicInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.participant.pictureUrl == null
                ? Icon(
                    Icons.person,
                    size: 150,
                  )
                : GestureDetector(
                    onTap: () {
                      showImageViewer(
                        context,
                        Image.network(widget.participant.pictureUrl!).image,
                        useSafeArea: true,
                        swipeDismissible: true,
                        doubleTapZoomable: true,
                      );
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.network(widget.participant.pictureUrl!)),
                  ),
            CommonWidgets().buildTitleTextItem(
                "Full name", widget.participant.fullName ?? "-",
                isCopyable: true, context: context),
            CommonWidgets().buildTitleTextItem(
                "Email", widget.participant.email ?? "-",
                isCopyable: true, context: context),
            CommonWidgets()
                .buildTitleTextItem("Gender", widget.participant.gender ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Birth Date",
                widget.participant.birthdate == null
                    ? "-"
                    : CommonMethods.formatDate(widget.participant.birthdate!)),
            CommonWidgets().buildTitleTextItem(
                "Phone number", widget.participant.phoneNumber ?? "-",
                isCopyable: true, context: context),
            CommonWidgets().buildTitleTextItem(
                "Origin Address", widget.participant.originAddress ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Current Address", widget.participant.currentAddress ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Nationality", widget.participant.nationality ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Tshirt Size", widget.participant.tshirtSize ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Disease History", widget.participant.diseaseHistory ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Occupation", widget.participant.occupation ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Institution", widget.participant.institution ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Organization", widget.participant.organizations ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Achievements", widget.participant.achievements ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Experiences", widget.participant.experiences ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Twibbon Link", widget.participant.twibbonLink ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Instagram", widget.participant.instagramAccount ?? "-"),
            CommonWidgets().buildTitleTextItem("Source Account Name",
                widget.participant.sourceAccountName ?? "-"),
            CommonWidgets().buildTitleTextItem(
              "Know Program From",
              widget.participant.knowledgeSource ?? "-",
            )
          ],
        ),
      ),
    );
  }
}
