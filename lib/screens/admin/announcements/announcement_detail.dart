import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_announcement_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/providers/program_announcement_provider.dart';

class AnnouncementDetails extends StatefulWidget {
  final ProgramAnnouncementModel announcement;
  const AnnouncementDetails({super.key, required this.announcement});

  @override
  State<AnnouncementDetails> createState() => _AnnouncementDetailsState();
}

class _AnnouncementDetailsState extends State<AnnouncementDetails> {
  Map<String, dynamic> visibleToData = {
    "0": "Public",
    "1": "Participants",
    "2": "Program Participants",
  };

  String visibleToText = "";

  getVisibleToText() {
    visibleToData.forEach((key, value) {
      if (key == widget.announcement.visibleTo) {
        visibleToText = value;
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getVisibleToText();
  }

  @override
  Widget build(BuildContext context) {
    var announcementProvider =
        Provider.of<ProgramAnnouncementProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(title: "Announcement Details"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.announcement.imgUrl == null
                    ? const SizedBox(
                        height: 300, child: Icon(Icons.announcement))
                    : Image.network(
                        widget.announcement.imgUrl!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(height: 20),
                Text(
                    "Published on ${DateFormat.yMMMd().format(widget.announcement.createdAt!)}",
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 10),
                Text(
                  "Last updated on ${DateFormat.yMMMd().format(widget.announcement.updatedAt!)}",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  "Visible to: $visibleToText",
                ),
                const SizedBox(height: 20),
                CommonWidgets().buildCustomButton(
                  text: "Copy link to share",
                  onPressed: () async {
                    // encrypt the announcement id
                    await ProgramAnnouncementService()
                        .encrpytId(widget.announcement.id!)
                        .then((value) {
                      String encrpytedId = value;

                      String redirectUrl =
                          "https://redirect.ybbfoundation.com/news?id=$encrpytedId";

                      // copy to clipboard
                      FlutterClipboard.copy(redirectUrl).then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Copied link to clipboard"),
                        ));
                      });
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 10),
                Text(widget.announcement.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(height: 10),
                HtmlWidget(widget.announcement.description!),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // create buttons to edit and delete announcement
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        context.pushNamed(
                            AppRouteConstants.addEditAnnouncementRouteName,
                            extra: widget.announcement);
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text("Edit",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        CommonHelper.showConfirmationDialog(context,
                            "Are you sure to delete this announcement?",
                            () async {
                          await ProgramAnnouncementService()
                              .delete(widget.announcement.id!)
                              .then((value) {
                            if (value) {
                              announcementProvider
                                  .removeAnnouncement(widget.announcement);

                              context.pop();
                            } else {
                              context.pop();

                              CommonHelper().showSimpleOkDialog(
                                  context,
                                  "Error",
                                  "Failed to delete announcement. Please try again",
                                  () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            }
                          });
                        });
                      },
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text("Delete",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
