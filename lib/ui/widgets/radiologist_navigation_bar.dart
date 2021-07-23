import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class RadiologistNavigationBar extends StatelessWidget {
  static int selectedIndex = 0;
  Future<void> _onItemTapped(int index) async {
    DialogeService dialogeService = DialogeService();
    try {
      selectedIndex = index;
      switch (index) {
        case 0:
          serviceLocator<NavigationService>().navigateTo(routes.ProfileRoute);
          break;
        case 1:
          await serviceLocator<RadiosControlService>()
              .fetchRadioModelsByRadiologistId();
          serviceLocator<NavigationService>().navigateTo(routes.RadiosRoute);
          break;

        default:
      }
    } on Exception catch (e) {
      dialogeService.showErrorDialoge("$e");
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
          label: 'Radios',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
