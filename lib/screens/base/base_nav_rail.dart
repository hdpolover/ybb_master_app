import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/size_constants.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        height:
            MediaQuery.of(context).size.height * AppSizeConstants.appBarHeight,
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 1,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            extended: true,
            backgroundColor: Colors.white,
            indicatorColor: AppColorConstants.kPrimaryColor,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedLabelTextStyle:
                const TextStyle(color: AppColorConstants.kPrimaryColor),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 5),
                label: Text('Dashboard'),
                icon: FaIcon(FontAwesomeIcons.gaugeHigh),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 5),
                label: Text('Users'),
                icon: FaIcon(FontAwesomeIcons.users),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 5),
                label: Text('Payments'),
                icon: FaIcon(FontAwesomeIcons.moneyBill),
              ),
              NavigationRailDestination(
                padding: EdgeInsets.symmetric(vertical: 5),
                label: Text('Settings'),
                icon: FaIcon(FontAwesomeIcons.moneyBill),
              ),
            ],
          ),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
