import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ybb_master_app/core/constants/asset_constants.dart';
import 'package:ybb_master_app/core/constants/size_constants.dart';
import 'package:ybb_master_app/core/widgets/common_admin_top_app_bar.dart';
import 'package:ybb_master_app/screens/admin/welcome/components/program_section.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CommonAdminTopAppBar(
        height:
            MediaQuery.of(context).size.height * AppSizeConstants.appBarHeight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text("Welcome to YBB Master App",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const ProgramSection(),
          ],
        ),
      ),
    );
  }
}
