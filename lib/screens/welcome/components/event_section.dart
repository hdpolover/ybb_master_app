import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventSection extends StatelessWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          // create a card that has an image logo, title and description
          GestureDetector(
            onTap: () {
              // navigate to details screen
              context.go('/dashboard');
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
          ),
        ],
      ),
    );
  }
}
