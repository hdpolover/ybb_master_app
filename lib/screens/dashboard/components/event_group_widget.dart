import 'package:flutter/material.dart';
import 'package:ybb_master_app/screens/dashboard/components/event_item_widget.dart';

class EventGroupWidget extends StatelessWidget {
  const EventGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // create row that has a title with image and see all button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Event Group Title'),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        // create a list view that has a list of event item widget
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return const EventItemWidget();
            },
          ),
        ),
      ],
    );
  }
}
