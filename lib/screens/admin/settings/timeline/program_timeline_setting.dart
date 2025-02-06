import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_timeline_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';

class ProgramTimelineSetting extends StatefulWidget {
  const ProgramTimelineSetting({super.key});

  @override
  State<ProgramTimelineSetting> createState() => _ProgramTimelineSettingState();
}

class _ProgramTimelineSettingState extends State<ProgramTimelineSetting> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await ProgramTimelineService().getAll(programId).then((value) {
      Provider.of<ProgramProvider>(context, listen: false).programTimelines =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<ProgramTimelineModel>? programTimelines =
        programProvider.programTimelines;

    if (programTimelines != null) {
      programTimelines.sort((a, b) => a.orderNumber!.compareTo(b.orderNumber!));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Program Timelines"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment method
          context.pushNamed(AppRouteConstants.addEditProgramTimelineRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: programTimelines == null
          ? const LoadingWidget()
          : programTimelines.isEmpty
              ? const Center(
                  child: Text("No program timelines found"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: programTimelines.length,
                  itemBuilder: (context, index) {
                    return ItemWidgetTile(
                      id: programTimelines[index].id!,
                      title: programTimelines[index].name!,
                      description: programTimelines[index].description!,
                      moreDesc:
                          "Start Date: ${CommonMethods.formatDate(programTimelines[index].startDate)}"
                          "\nEnd Date: ${CommonMethods.formatDate(programTimelines[index].endDate)}",
                      onTap: () {
                        // Edit payment method
                        context.pushNamed(
                          AppRouteConstants.programTimelineDetailRouteName,
                          extra: programTimelines[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
