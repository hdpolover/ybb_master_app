import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';

class AnnouncementCard extends StatefulWidget {
  final ProgramAnnouncementModel announcement;
  const AnnouncementCard({super.key, required this.announcement});

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouteConstants.announcementDetailRouteName,
            extra: widget.announcement);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.announcement.imgUrl == null
                  ? const SizedBox(height: 200, child: Icon(Icons.announcement))
                  : Image.network(
                      widget.announcement.imgUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(widget.announcement.title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(
                        "Published on ${DateFormat.yMMMd().format(widget.announcement.createdAt!)}",
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
