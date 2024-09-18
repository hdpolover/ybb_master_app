import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';

class ParticipantPreviewWidget extends StatelessWidget {
  final ParticipantModel participant;
  const ParticipantPreviewWidget({super.key, required this.participant});

  buildPaymentChip(String status) {
    // 0 (not started), 1 (progress), 2 (submitted)
    Color color;
    Icon icon;

    String formText = "Payment: ";

    switch (status) {
      case "0":
        icon = const Icon(
          Icons.close,
          color: Colors.white,
        );
        break;
      case "1":
        icon = const Icon(
          Icons.access_time,
          color: Colors.white,
        );
        break;
      case "2":
        icon = const Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      default:
        icon = const Icon(
          Icons.error,
          color: Colors.black,
        );
    }

    switch (status) {
      case "0":
        color = Colors.red;
        break;
      case "1":
        color = Colors.orange;
        break;
      case "2":
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        formText,
        style: AppTextStyleConstants.bodyTextStyle.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    );
  }

  buildFormChip(String status) {
    // 0 (not started), 1 (progress), 2 (submitted)
    Color color;
    Icon icon;

    String formText = "Form: ";

    switch (status) {
      case "0":
        icon = const Icon(
          Icons.close,
          color: Colors.white,
        );
        break;
      case "1":
        icon = const Icon(
          Icons.access_time,
          color: Colors.white,
        );
        break;
      case "2":
        icon = const Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      default:
        icon = const Icon(
          Icons.error,
          color: Colors.black,
        );
    }

    switch (status) {
      case "0":
        color = Colors.red;
        break;
      case "1":
        color = Colors.orange;
        break;
      case "2":
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Wrap(
        children: [
          Text(
            formText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.white,
            ),
          ),
          icon,
        ],
      ),
      backgroundColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          context.pushNamed(AppRouteConstants.participantDetailRouteName,
              extra: participant);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        style: ListTileStyle.list,
        leading: participant.pictureUrl == null
            ? const Icon(
                Icons.person,
                size: 50,
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(participant.pictureUrl!),
                radius: 30,
              ),
        title: Text(participant.fullName ?? "-"),
        subtitle: Text(participant.email ?? "-"),
        trailing: Wrap(
          children: [
            buildFormChip(participant.formStatus!),
          ],
        ));
  }
}
