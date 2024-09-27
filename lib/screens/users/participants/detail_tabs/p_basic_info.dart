import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';

class PBasicInfo extends StatelessWidget {
  final ParticipantModel participant;
  const PBasicInfo({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            participant.pictureUrl == null
                ? const Icon(
                    Icons.person,
                    size: 150,
                  )
                : GestureDetector(
                    onTap: () {
                      showImageViewer(
                        context,
                        Image.network(participant.pictureUrl!).image,
                        useSafeArea: true,
                        swipeDismissible: true,
                        doubleTapZoomable: true,
                      );
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.network(participant.pictureUrl!)),
                  ),
            CommonWidgets().buildTitleTextItem(
                "Full name", participant.fullName ?? "-",
                isCopyable: true, context: context),
            CommonWidgets().buildTitleTextItem(
                "Email", participant.email ?? "-",
                isCopyable: true, context: context),
            CommonWidgets()
                .buildTitleTextItem("Gender", participant.gender ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Birth Date",
                participant.birthdate == null
                    ? "-"
                    : CommonMethods.formatDate(participant.birthdate!)),
            CommonWidgets().buildTitleTextItem(
                "Phone number", participant.phoneNumber ?? "-",
                isCopyable: true, context: context),
            CommonWidgets().buildTitleTextItem(
                "Origin Address", participant.originAddress ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Current Address", participant.currentAddress ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Nationality", participant.nationality ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Tshirt Size", participant.tshirtSize ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Disease History", participant.diseaseHistory ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Occupation", participant.occupation ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Institution", participant.institution ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Organization", participant.organizations ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Achievements", participant.achievements ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Experiences", participant.experiences ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Twibbon Link", participant.twibbonLink ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Instagram", participant.instagramAccount ?? "-"),
            CommonWidgets().buildTitleTextItem(
                "Source Account Name", participant.sourceAccountName ?? "-"),
            CommonWidgets().buildTitleTextItem(
              "Know Program From",
              participant.knowledgeSource ?? "-",
            )
          ],
        ),
      ),
    );
  }
}
