import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/core/models/program/program_category_model.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/welcome/components/program_tile.dart';

class ProgramSection extends StatelessWidget {
  const ProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    var programCategories =
        Provider.of<ProgramProvider>(context).programCategories;
    var programs = Provider.of<ProgramProvider>(context).programs;

    buildProgramGroup(ProgramCategoryModel programCategory) {
      List<ProgramTile> programsTiles = [];

      // get programs from programCategory which has the same id
      for (ProgramModel program in programs) {
        if (program.programCategoryId == programCategory.id) {
          programsTiles.add(ProgramTile(program: program));
        }
      }

      // move inactive programs to the bottom
      programsTiles.sort((a, b) => a.program.isActive == "1" ? -1 : 1);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          initiallyExpanded: true,
          title: Text(
            programCategory.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: programsTiles,
        ),
      );
    }

    // sort program categores that do not have any programs to the bottom
    programCategories.sort((a, b) {
      int aCount = 0;
      int bCount = 0;

      for (ProgramModel program in programs) {
        if (program.programCategoryId == a.id) {
          aCount++;
        } else if (program.programCategoryId == b.id) {
          bCount++;
        }
      }

      return aCount == 0
          ? 1
          : bCount == 0
              ? -1
              : 0;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: programCategories.length,
        itemBuilder: (context, index) {
          return buildProgramGroup(programCategories[index]);
        },
      ),
    );
  }
}
