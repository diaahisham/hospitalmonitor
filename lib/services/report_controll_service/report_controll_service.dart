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

  Future<void> fetchReportModelForPatient(UserModel patient) async {
    reportModels.clear();
    HealthReportModel result = HealthReportModel(
      patientID: patient.userID,
      patientName: patient.userName,
      bloodPressure: patient.bloodPressure,
      bloodType: patient.bloodType,
      breathingRate: patient.breathingRate,
      diabetesRate: patient.diabetesRate,
      chronicDiseases:
          List<String>.from(patient.chronicDiseases, growable: true),
      dangerDiseases: List<String>.from(patient.dangerDiseases, growable: true),
      sensitivities: List<String>.from(patient.sensitivities, growable: true),
      vaccinations: List<String>.from(patient.vaccinations, growable: true),
    );
    reportModels.add(result);
  }

  Future<void> addEditReport() async {
    // if (currentEdittingReport.reportID == '') {
    //   currentEdittingReport.reportID = Random().toString();
    // } else {
    //   healthReports.removeWhere(
    //       (element) => element.reportID == currentEdittingReport.reportID);
    // }
    // healthReports.add(currentEdittingReport);
    // await fetchReportModelsByPatientId(currentEdittingReport.patientID);
  }
}
