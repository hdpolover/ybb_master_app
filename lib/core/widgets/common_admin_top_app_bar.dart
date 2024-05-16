import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/asset_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/providers/admin_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class CommonAdminTopAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final double height;
  const CommonAdminTopAppBar({required this.height, super.key});

  @override
  State<CommonAdminTopAppBar> createState() => _CommonAdminTopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CommonAdminTopAppBarState extends State<CommonAdminTopAppBar> {
  // Initial Selected Value
  ProgramModel? selectedProgram;

  buildAdminProfile(String? profileUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CircleAvatar(
        backgroundImage: NetworkImage(profileUrl ?? ""),
      ),
    );
  }

  buildProgramDropdown(ProgramProvider programProvider) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<ProgramModel>(
        isExpanded: true,
        icon: const FaIcon(FontAwesomeIcons.angleDown),
        underline: const SizedBox(),
        enableFeedback: false,
        value: selectedProgram ?? programProvider.currentProgram,
        items: programProvider.programs
            .map<DropdownMenuItem<ProgramModel>>((ProgramModel value) {
          return DropdownMenuItem<ProgramModel>(
            value: value,
            child: Text(value.name!),
          );
        }).toList(),
        onChanged: (ProgramModel? value) {
          setState(
            () {},
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var adminProvider = Provider.of<AdminProvider>(context);
    var programProvider = Provider.of<ProgramProvider>(context);

    return AppBar(
      automaticallyImplyLeading: false,
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
      title: programProvider.currentProgram == null
          ? null
          : buildProgramDropdown(programProvider),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        buildAdminProfile(adminProvider.currentAdmin == null
            ? ""
            : adminProvider.currentAdmin!.profileUrl),
      ],
    );
  }
}
