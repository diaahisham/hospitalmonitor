import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/report_controll_service/report_controll_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AllPatientsViewModel {
  List<UserModel> patients =
      serviceLocator<PatientControlService>().allPatients;

  ValueNotifier<String> searchValue = ValueNotifier<String>('');
  int rowNumber = -1;

  bool isRowVisible(String name) {
    if (searchValue.value == '') return true;

    if (name.length < searchValue.value.length) return false;

    return (searchValue.value.toLowerCase() ==
        name.substring(0, searchValue.value.length).toLowerCase());
  }

  void searchValueChange(String search) {
    rowNumber = -1;
    searchValue.value = search;
  }

  Color? rowColor() {
    rowNumber += 1;
    if (rowNumber % 2 == 1)
      return Colors.grey[350];
    else
      return Colors.white;
  }

  Future<void> viewPatient(UserModel patient) async {
    await serviceLocator<ReportControlService>()
        .fetchReportModelsByPatientId(patient.userID);
    serviceLocator<PatientControlService>().currentPatient = patient;
    await serviceLocator<AnalyzesControlService>()
        .fetchAnalysesModelsByPatientId(patient.userID);
    await serviceLocator<RadiosControlService>()
        .fetchRadioModelsByPatientId(patient.userID);
    await serviceLocator<ExaminationControlService>()
        .fetchExamModelsByPatientId(patient.userID);
    serviceLocator<NavigationService>().navigateTo(routes.HealthReportRoute);
  }
}
