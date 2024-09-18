import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String routeName;
  const MenuCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(routeName);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: AppTextStyleConstants.bodyTextStyle
                    .copyWith(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
