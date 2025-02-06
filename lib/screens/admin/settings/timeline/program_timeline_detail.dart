import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/core/services/program_timeline_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class ProgramTimelineDetail extends StatefulWidget {
  final ProgramTimelineModel? programTimeline;

  const ProgramTimelineDetail({super.key, this.programTimeline});

  @override
  State<ProgramTimelineDetail> createState() => _ProgramTimelineDetailState();
}

class _ProgramTimelineDetailState extends State<ProgramTimelineDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Program Timeline Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // order number
              CommonWidgets().buildTitleTextItem(
                "Order Number",
                widget.programTimeline!.orderNumber.toString(),
              ),
              CommonWidgets().buildTitleTextItem(
                "Timeline Name",
                widget.programTimeline!.name!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Timeline Description",
                widget.programTimeline!.description!,
              ),
              CommonWidgets().buildTitleTextItem(
                "Start Date",
                DateFormat("dd MMMM yyyy")
                    .format(widget.programTimeline!.startDate!),
              ),
              CommonWidgets().buildTitleTextItem(
                "End Date",
                DateFormat("dd MMMM yyyy")
                    .format(widget.programTimeline!.endDate!),
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.orange,
                text: "Edit Timeline",
                onPressed: () {
                  // navigate to edit payment screen
                  context.pushNamed(
                      AppRouteConstants.addEditProgramTimelineRouteName,
                      extra: widget.programTimeline);
                },
              ),
              const SizedBox(height: 20),
              CommonWidgets().buildCustomButton(
                color: Colors.red,
                text: "Delete Timeline",
                onPressed: () {
                  CommonHelper.showConfirmationDialog(
                      context, "Are you sure you want to delete this timeline?",
                      () async {
                    // delete payment
                    await ProgramTimelineService()
                        .delete(widget.programTimeline!.id!)
                        .then((value) {
                      Provider.of<ProgramProvider>(context, listen: false)
                          .removeProgramTimeline(widget.programTimeline!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Timeline deleted successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.of(context).pop();
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
