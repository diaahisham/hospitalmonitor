import 'dart:convert';

import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:http/http.dart' as http;

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

  Future<void> editReport() async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    String url = common.baseURL +
        "/api/doctors/patients/" +
        currentEdittingReport.patientID;

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${loggedUser.token}'
      },
      body: jsonEncode(currentEdittingReport),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }
    reportModels.clear();
    reportModels.add(currentEdittingReport);
  }
}
