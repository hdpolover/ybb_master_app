import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/data/fake_data.dart';
import 'package:ybb_master_app/core/models/program.dart';
import 'package:ybb_master_app/core/models/program_category.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/screens/welcome/components/program_tile.dart';

class ProgramSection extends StatelessWidget {
  const ProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    buildProgramGroup(ProgramCategory programCategory) {
      List<ProgramTile> programsTiles = [];

      // get programs from programCategory which has the same id
      for (Program program in programs) {
        if (program.programCategory!.id == programCategory.id) {
          programsTiles.add(ProgramTile(program: program));
        }
      }

      // move inactive programs to the bottom
      programsTiles.sort((a, b) => a.program.isActive! ? -1 : 1);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          initiallyExpanded: true,
          title: Text(programCategory.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          children: programsTiles,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "Programs",
          style: AppTextStyleConstants.pageTitleTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                foregroundColor: Colors.white,
                backgroundColor: AppColorConstants.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                context.push(AppRouteConstants.addProgramRoutePath);
              },
              icon: const FaIcon(FontAwesomeIcons.plus),
              label: const Text("Add Program"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: programCategories.length,
                itemBuilder: (context, index) {
                  return buildProgramGroup(programCategories[index]);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
