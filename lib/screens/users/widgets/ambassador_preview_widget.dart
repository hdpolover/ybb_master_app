import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/ambassador_service.dart';

class AmbassadorPreviewWidget extends StatefulWidget {
  final AmbassadorModel ambassador;
  final List<ParticipantModel> participants;

  AmbassadorPreviewWidget(
      {super.key, required this.ambassador, required this.participants});

  @override
  State<AmbassadorPreviewWidget> createState() =>
      _AmbassadorPreviewWidgetState();
}

class _AmbassadorPreviewWidgetState extends State<AmbassadorPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {
          context.pushNamed(
            AppRouteConstants.ambassadorDetailRouteName,
            extra: widget.ambassador,
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        style: ListTileStyle.list,
        leading: Text(widget.ambassador.refCode ?? "-"),
        title: Text(widget.ambassador.name ?? "-"),
        subtitle: Text(widget.ambassador.email ?? "-"),
        trailing: Text("Referred: ${widget.participants.length}"),
      ),
    );
  }
}
