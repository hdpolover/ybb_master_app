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
      body: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //create a text widget with the text "Welcome to YBB Master App"
                    Text("Welcome to YBB Master App",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: SvgPicture.asset(AppAssetConstants.welcomeSvg,
                          semanticsLabel: 'welcome'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: ProgramSection(),
          ),
        ],
      ),
    );
  }
}
