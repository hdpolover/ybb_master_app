import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_announcement_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_announcement_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/announcements/announcement_card.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({super.key});

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  List<ProgramAnnouncementModel>? filteredAnnouncements;

  @override
  void initState() {
    super.initState();

    fetchAnnouncements();
  }

  Map<String, dynamic> visibleToData = {
    "-1": "All",
    "0": "Public",
    "1": "Participants",
    "2": "Program Participants",
  };

  fetchAnnouncements() async {
    String? programId = Provider.of<ProgramProvider>(context, listen: false)
            .currentProgram!
            .id ??
        "3";
    await ProgramAnnouncementService().getAll(programId).then((value) {
      Provider.of<ProgramAnnouncementProvider>(context, listen: false)
          .announcements = value;
    });
  }

  buildFilterChip() {
    return Wrap(
      spacing: 5,
      children: [
        FilterChip(
          label: const Text("All"),
          onSelected: (bool value) {
            if (value) {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements;
              });
            } else {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements;
              });
            }
          },
        ),
        FilterChip(
          label: const Text("Public"),
          onSelected: (bool value) {
            if (value) {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements
                        .where((element) => element.visibleTo == "0")
                        .toList();
              });
            } else {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements;
              });
            }
          },
        ),
        FilterChip(
          label: const Text("Participants"),
          onSelected: (bool value) {
            if (value) {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements
                        .where((element) => element.visibleTo == "1")
                        .toList();
              });
            } else {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements;
              });
            }
          },
        ),
        FilterChip(
          label: const Text("Program Participants"),
          onSelected: (bool value) {
            if (value) {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements
                        .where((element) => element.visibleTo == "2")
                        .toList();
              });
            } else {
              setState(() {
                filteredAnnouncements =
                    Provider.of<ProgramAnnouncementProvider>(context,
                            listen: false)
                        .announcements;
              });
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var announcementProvider =
        Provider.of<ProgramAnnouncementProvider>(context);

    return Scaffold(
      appBar: const CommonAppBar(title: "Announcements"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          context.pushNamed(AppRouteConstants.addEditAnnouncementRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: announcementProvider.announcements.isEmpty
            ? const Center(
                child: Text("No announcements available"),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                itemCount: announcementProvider.announcements.length,
                itemBuilder: (context, index) {
                  return AnnouncementCard(
                      announcement: announcementProvider.announcements[index]);
                },
              ),
      ),
    );
  }
}
