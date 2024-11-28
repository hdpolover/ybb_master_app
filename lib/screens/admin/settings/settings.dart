import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/menu_card.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/paper_program_details/paper_program_detail.dart';
import 'package:ybb_master_app/screens/admin/settings/paper_topics/paper_topic_list.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isPaperProgram = false;

  @override
  void initState() {
    super.initState();

    check();
  }

  check() {
    //check if the program is a paper program
    if (Provider.of<ProgramProvider>(context, listen: false)
            .currentProgramInfo!
            .programTypeId ==
        "3") {
      setState(() {
        isPaperProgram = true;
      });
    }
  }

  List<MenuCard> menuCards = [
    const MenuCard(
      title: "Landing Page",
      icon: FontAwesomeIcons.house,
      routeName: AppRouteConstants.landingPageRouteName,
    ),
    const MenuCard(
      title: "Program Timeline",
      icon: FontAwesomeIcons.calendarDays,
      routeName: AppRouteConstants.programTimelineSettingRouteName,
    ),
    const MenuCard(
      title: "Program Payments",
      icon: Icons.payment,
      routeName: AppRouteConstants.paymentSettingRouteName,
    ),
    const MenuCard(
      title: "Payment Methods",
      icon: FontAwesomeIcons.creditCard,
      routeName: AppRouteConstants.paymentMethodRouteName,
    ),
    const MenuCard(
      title: "Program Documents",
      icon: FontAwesomeIcons.fileLines,
      routeName: AppRouteConstants.programDocumentSettingRouteName,
    ),
    const MenuCard(
      title: "Program Certificates",
      icon: FontAwesomeIcons.certificate,
      routeName: AppRouteConstants.programCertificateRouteName,
    ),
  ];

  List<MenuCard> paperMenuCards = [
    const MenuCard(
      title: "Paper Topics",
      icon: FontAwesomeIcons.book,
      routeName: PaperTopicList.routeName,
    ),
    const MenuCard(
      title: "Paper Program Details",
      icon: FontAwesomeIcons.info,
      routeName: PaperProgramDetail.routeName,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<MenuCard> allMenuCards = menuCards;

    if (isPaperProgram) {
      allMenuCards.addAll(paperMenuCards);
    }

    return Scaffold(
      appBar: const CommonAppBar(
        title: "Settings",
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: allMenuCards.length,
          itemBuilder: (context, index) {
            return allMenuCards[index];
          },
        ),
      ),
    );
  }
}
