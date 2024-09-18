import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/screens/settings/landing_page/faq/lp_faq_setting.dart';
import 'package:ybb_master_app/screens/settings/landing_page/lp_home_setting.dart';

class LandingPageSetting extends StatefulWidget {
  const LandingPageSetting({super.key});

  @override
  State<LandingPageSetting> createState() => _LandingPageSettingState();
}

class _LandingPageSettingState extends State<LandingPageSetting> {
  DefaultTabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const CommonAppBar(title: "Landing Page"),
        // cretae tab bar
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: TabBar(
              tabs: [
                Tab(text: "Home"),
                Tab(text: "About Us"),
                Tab(text: "Partnerships and Sponsorships"),
                Tab(text: "FAQs"),
              ],
            ),
            body: TabBarView(
              children: [
                LpHomeSetting(),
                Center(child: Text("About")),
                Center(child: Text("Programs")),
                LpFaqSetting(),
              ],
            ),
          ),
        ));
  }
}
