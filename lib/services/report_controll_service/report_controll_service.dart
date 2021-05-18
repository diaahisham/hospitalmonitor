import 'dart:math';

import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/utils/reports.dart';

class ReportControlService {
  List<HealthReportModel> reportModels =
      List<HealthReportModel>.empty(growable: true);

  HealthReportModel currentEdittingReport = HealthReportModel();

  // Future<void> fetchReportModelsByDoctorId() async {
  //   String doctorID = serviceLocator<CurrentSessionService>().loggedUser.userID;
  //   reportModels.clear();
  //   List<HealthReportModel> result =
  //       healthReports.where((element) => element.d == doctorID).toList();
  //   reportModels.addAll(result);
  // }

  Future<void> fetchReportModelsByPatientId(String patientID) async {
    reportModels.clear();
    List<HealthReportModel> result = healthReports
        .where((element) => element.patientID == patientID)
        .toList();
    reportModels.addAll(result);
  }

  Future<void> addEditReport() async {
    //. = DateTime.now().toString().substring(0, 10);
    // currentEdittingReport.doctorID =
    //     serviceLocator<CurrentSessionService>().loggedUser.userID;
    // currentEdittingReport.doctorName =
    //     serviceLocator<CurrentSessionService>().loggedUser.userName;
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
