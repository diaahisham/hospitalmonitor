import 'package:flutter/material.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class PatientNavigationBar extends StatelessWidget {
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
              .fetchRadioModelsByPatientId(
                  serviceLocator<CurrentSessionService>().loggedUser.userID);
          serviceLocator<NavigationService>().navigateTo(routes.RadiosRoute);
          break;
        case 2:
          await serviceLocator<AnalyzesControlService>()
              .fetchAnalysesModelsByPatientId(
                  serviceLocator<CurrentSessionService>().loggedUser.userID);
          serviceLocator<NavigationService>().navigateTo(routes.AnalysisRoute);
          break;
        case 3:
          await serviceLocator<ExaminationControlService>()
              .fetchExamModelsByPatientId(
                  serviceLocator<CurrentSessionService>().loggedUser.userID);
          serviceLocator<NavigationService>()
              .navigateTo(routes.ExaminationViewRoute);
          break;

        default:
      }
    } catch (e) {
      dialogeService.showErrorDialoge("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Radios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Analyzes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Examinations',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
