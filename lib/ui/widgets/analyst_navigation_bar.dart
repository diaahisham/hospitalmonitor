import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AnalystNavigationBar extends StatelessWidget {
  static int selectedIndex = 0;
  Future<void> _onItemTapped(int index) async {
    selectedIndex = index;
    switch (index) {
      case 0:
        serviceLocator<NavigationService>().navigateTo(routes.ProfileRoute);
        break;
      case 1:
        await serviceLocator<AnalyzesControlService>()
            .fetchAnalysesModelsByAnalystId();
        serviceLocator<NavigationService>().navigateTo(routes.AnalysisRoute);
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Analyzes',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
