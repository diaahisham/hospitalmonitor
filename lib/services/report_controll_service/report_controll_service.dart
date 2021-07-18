import 'dart:math';

import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/reports.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class ReportControlService {
  List<HealthReportModel> reportModels =
      List<HealthReportModel>.empty(growable: true);

  HealthReportModel currentEdittingReport = HealthReportModel();

  void setupLoggedPatientReport() {
    UserModel patientUser = serviceLocator<CurrentSessionService>().patientUser;
    HealthReportModel patientReport = HealthReportModel(
      patientID: patientUser.userID,
      patientName: patientUser.userName,
      bloodPressure: patientUser.bloodPressure,
      bloodType: patientUser.bloodType,
      breathingRate: patientUser.breathingRate,
      diabetesRate: patientUser.diabetesRate,
      chronicDiseases:
          List<String>.from(patientUser.chronicDiseases, growable: true),
      dangerDiseases:
          List<String>.from(patientUser.dangerDiseases, growable: true),
      sensitivities:
          List<String>.from(patientUser.sensitivities, growable: true),
      vaccinations: List<String>.from(patientUser.vaccinations, growable: true),
    );
    reportModels.clear();
    reportModels.add(patientReport);
  }

  Future<void> fetchReportModelsByPatientId(String patientID) async {
    reportModels.clear();
    List<HealthReportModel> result = healthReports
        .where((element) => element.patientID == patientID)
        .toList();
    reportModels.addAll(result);
  }

  Future<void> addEditReport() async {
    if (currentEdittingReport.reportID == '') {
      currentEdittingReport.reportID = Random().toString();
    } else {
      healthReports.removeWhere(
          (element) => element.reportID == currentEdittingReport.reportID);
    }
    healthReports.add(currentEdittingReport);
    await fetchReportModelsByPatientId(currentEdittingReport.patientID);
  }
}
