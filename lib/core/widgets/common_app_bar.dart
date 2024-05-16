import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackEnabled;
  final List<Widget>? actions;

  const CommonAppBar({super.key, this.title, this.isBackEnabled, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      automaticallyImplyLeading: isBackEnabled ?? true,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      leading: isBackEnabled != null && isBackEnabled!
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: Text(
        title!,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
