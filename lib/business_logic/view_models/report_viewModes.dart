import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/report_controll_service/report_controll_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/ui/views/analyzes_view.dart';
import 'package:hospitalmonitor/ui/views/examination_view.dart';
import 'package:hospitalmonitor/ui/views/radios_view.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class ReportViewModel {
  HealthReportModel get reportModel =>
      serviceLocator<ReportControlService>().reportModels[0];
  bool userIsDoctor = false;
  ValueNotifier<int> currentWidgetNumber = ValueNotifier<int>(0);

  set widgetNO(int no) => currentWidgetNumber.value = no;

  int get widgetNo => currentWidgetNumber.value;

  UserType get loggedUserType =>
      serviceLocator<CurrentSessionService>().loggedUser.type;

  UserModel get currentPatient =>
      serviceLocator<PatientControlService>().currentPatient;

  Widget? viewWidget() {
    switch (widgetNo) {
      case 1:
        return AnalyzesView();
      case 2:
        return RadiosView();
      case 3:
        return ExaminationView();
      default:
        return null;
    }
  }

  DialogeService dialogeService = DialogeService();
  ValueNotifier<bool> edittingMode = ValueNotifier<bool>(false);

  ReportViewModel() {
    userIsDoctor = (serviceLocator<CurrentSessionService>().loggedUser.type ==
        UserType.doctor);
  }

  Future<void> submitEditting() async {
    if (edittingMode.value) {
      await serviceLocator<ReportControlService>().addEditReport();
      edittingMode.value = false;
    } else {
      edittingMode.value = true;
    }
  }

  void goToAllPatients() {
    serviceLocator<NavigationService>().navigateTo(routes.AllPatientsRoute);
  }
}
