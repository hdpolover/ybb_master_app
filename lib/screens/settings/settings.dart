import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/menu_card.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
  @override
  Widget build(BuildContext context) {
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
          itemCount: menuCards.length,
          itemBuilder: (context, index) {
            return menuCards[index];
          },
        ),
      ),
    );
  }
}
