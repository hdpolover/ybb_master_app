import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/asset_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  const CommonAppBar({required this.height, super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.height,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(AppAssetConstants.ybbLogo, height: 150),
            Text(
              "v1.0.0",
              style: AppTextStyleConstants.captionTextStyle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      titleSpacing: MediaQuery.of(context).size.width * 0.035,
      title: Text(
        "YBB Master App",
        style: AppTextStyleConstants.appBarTitle,
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
