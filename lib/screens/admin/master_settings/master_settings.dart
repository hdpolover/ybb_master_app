import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class MasterSettings extends StatefulWidget {
  const MasterSettings({super.key});

  @override
  State<MasterSettings> createState() => _MasterSettingsState();
}

class _MasterSettingsState extends State<MasterSettings> {
  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);

    int programTotal = programProvider.programs.length;
    int programActive = 0;

    for (var program in programProvider.programs) {
      if (program.isActive! == "1") {
        programActive++;
      }
    }

    return Scaffold(
      appBar: const CommonAppBar(
        title: "Master Settings",
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              context
                  .goNamed(AppRouteConstants.masterProgramCategoriesRouteName);
            },
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "Program Categories",
                      style: AppTextStyleConstants.headingTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$programActive\nActive",
                            textAlign: TextAlign.center),
                        Text("$programTotal\nTotal",
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Text(
                    "Programs",
                    style: AppTextStyleConstants.headingTextStyle
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$programActive\nActive",
                          textAlign: TextAlign.center),
                      Text("$programTotal\nTotal", textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
