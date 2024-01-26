import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // create a card that has an image logo, title and description
    return GestureDetector(
      onTap: () {
        // navigate to details screen
        Get.toNamed('/details');
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // generate image from network
            Image.network('https://picsum.photos/250?image=9'),
            const Text('Event Title'),
            const Text('Event Description'),
          ],
        ),
      ),
    );
  }
}
