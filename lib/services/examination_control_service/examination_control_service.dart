import 'dart:convert';
import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:http/http.dart' as http;

class ExaminationControlService {
  List<ExaminationModel> examModels =
      List<ExaminationModel>.empty(growable: true);

  ExaminationModel currentEdittingExam = ExaminationModel();

  Future<void> fetchExamModelsByPatientId(String patientID) async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    switch (loggedUser.type) {
      case UserType.doctor:
        await _doctorFetchExams(patientID, loggedUser);
        break;
      case UserType.patient:
        await _patientFetchExams(loggedUser);
        break;
      default:
    }
  }

  Future<void> _patientFetchExams(UserModel loggedPatient) async {
    List<ExaminationModel> result =
        List<ExaminationModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/patients/examinations" +
        "?filter[include][0][relation]=doctor" +
        "&filter[include][1][relation]=patient";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${loggedPatient.token}'
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    List<dynamic> body = json.decode(response.body);

    body.forEach((element) {
      result.add(ExaminationModel.fromJson(element));
    });

    examModels.clear();
    examModels.addAll(result);
  }

  Future<void> _doctorFetchExams(
      String patientID, UserModel loggedDoctor) async {
    List<ExaminationModel> result =
        List<ExaminationModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/doctors/patients/$patientID/examinations" +
        "?filter[include][0][relation]=doctor" +
        "&filter[include][1][relation]=patient";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${loggedDoctor.token}'
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    List<dynamic> body = json.decode(response.body);

    body.forEach((element) {
      result.add(ExaminationModel.fromJson(element));
    });

    examModels.clear();
    examModels.addAll(result);
  }

  Future<void> addEditExamination() async {
    UserModel currentPatient =
        serviceLocator<PatientControlService>().currentPatient;
    UserModel loggedDoctor = serviceLocator<CurrentSessionService>().loggedUser;
    String url = common.baseURL +
        "/api/doctors/examinations" +
        ((currentEdittingExam.examinationID != '')
            ? "/${currentEdittingExam.examinationID}"
            : "");

    final response = (currentEdittingExam.examinationID != '')
        ? await http.patch(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${loggedDoctor.token}'
            },
            body: jsonEncode(currentEdittingExam),
          )
        : await http.post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${loggedDoctor.token}'
            },
            body: jsonEncode(currentEdittingExam),
          );

    if (response.statusCode != 200 && response.statusCode != 204) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    await fetchExamModelsByPatientId(currentPatient.userID);
  }
}
