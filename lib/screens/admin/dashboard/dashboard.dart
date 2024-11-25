import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/services/dashboard_service.dart';
import 'package:ybb_master_app/core/widgets/common_admin_top_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/dashboard_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/dashboard/nationality_count_widget.dart';
import 'package:ybb_master_app/screens/admin/dashboard/user_count_widget.dart';

import 'gender_count_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;
    // get the data
    await DashboardService().getUserCountByDay(programId).then((value) {
      Provider.of<DashboardProvider>(context, listen: false).userCount = value;
    });

    await DashboardService().getNationalities(programId).then((value) {
      Provider.of<DashboardProvider>(context, listen: false).nationalityCount =
          value;
    });

    await DashboardService().getGenderCount(programId).then((value) {
      Provider.of<DashboardProvider>(context, listen: false).genderCount =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dashboardProvider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: dashboardProvider.userCount.isEmpty ||
              dashboardProvider.genderCount.isEmpty ||
              dashboardProvider.nationalityCount.isEmpty
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    UserCountWidget(
                      userCount: dashboardProvider.userCount,
                    ),
                    Row(
                      children: [
                        GenderCountWidget(
                          genderCount: dashboardProvider.genderCount,
                        ),
                        NationalityCountWidget(
                          nationalityList: dashboardProvider.nationalityCount,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
