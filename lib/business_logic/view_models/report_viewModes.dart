import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  HealthReportModel reportModel =
      serviceLocator<ReportControlService>().reportModels[0];
  bool userIsDoctor = false;
  ValueNotifier<int> currentWidgetNumber = ValueNotifier<int>(0);
  ValueNotifier<int> chronicDiseasesLength = ValueNotifier<int>(0);
  ValueNotifier<int> dangerDiseasesLength = ValueNotifier<int>(0);
  ValueNotifier<int> senstivitiesLength = ValueNotifier<int>(0);
  ValueNotifier<int> vaccinationsLength = ValueNotifier<int>(0);

  String newChronicDisease = '';
  String newDangerDisease = '';
  String newSensetivity = '';
  String newVaccination = '';

  set widgetNO(int no) => currentWidgetNumber.value = no;

  int get widgetNo => currentWidgetNumber.value;

  UserType get loggedUserType =>
      serviceLocator<CurrentSessionService>().loggedUser.type;

  UserModel get currentPatient =>
      serviceLocator<PatientControlService>().currentPatient;

  void addChronicDisease(String disease) {
    if (disease != '') {
      reportModel.chronicDiseases.add(disease);
      chronicDiseasesLength.value = reportModel.chronicDiseases.length;
    }
  }

  void removeChronicDisease(int index) {
    reportModel.chronicDiseases.removeAt(index);
    chronicDiseasesLength.value = reportModel.chronicDiseases.length;
  }

  void addDangerDisease(String disease) {
    if (disease != '') {
      reportModel.dangerDiseases.add(disease);
      dangerDiseasesLength.value = reportModel.dangerDiseases.length;
    }
  }

  void removeDangerDisease(int index) {
    reportModel.dangerDiseases.removeAt(index);
    dangerDiseasesLength.value = reportModel.dangerDiseases.length;
  }

  void addSenstivity(String disease) {
    if (disease != '') {
      reportModel.sensitivities.add(disease);
      senstivitiesLength.value = reportModel.sensitivities.length;
    }
  }

  void removeSenstivity(int index) {
    reportModel.sensitivities.removeAt(index);
    senstivitiesLength.value = reportModel.sensitivities.length;
  }

  void addvaccination(String disease) {
    if (disease != '') {
      reportModel.vaccinations.add(disease);
      vaccinationsLength.value = reportModel.vaccinations.length;
    }
  }

  void removevaccinations(int index) {
    reportModel.vaccinations.removeAt(index);
    vaccinationsLength.value = reportModel.vaccinations.length;
  }

  Widget? viewWidget() {
    switch (widgetNo) {
      case 1:
        return Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: AnalyzesView());
      case 2:
        return Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: RadiosView());
      case 3:
        return Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: ExaminationView());
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
      serviceLocator<ReportControlService>().currentEdittingReport =
          reportModel;
      await serviceLocator<ReportControlService>().addEditReport();
      edittingMode.value = false;
    } else {
      edittingMode.value = true;
    }
  }

  void cancelEditting() {
    reportModel = serviceLocator<ReportControlService>().reportModels[0];
    edittingMode.value = false;
  }

  void goToAllPatients() {
    serviceLocator<NavigationService>().navigateTo(routes.AllPatientsRoute);
  }
}
