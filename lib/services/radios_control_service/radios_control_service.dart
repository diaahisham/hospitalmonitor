import 'dart:convert';
import 'package:hospitalmonitor/business_logic/models/radio_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:http/http.dart' as http;

class RadiosControlService {
  List<RadioModel> radioModels = List<RadioModel>.empty(growable: true);

  RadioModel currentEdittingRadio = RadioModel();

  Future<void> fetchRadioModelsByRadiologistId() async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    List<RadioModel> result = List<RadioModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/radiologists/radiologies" +
        "?filter[include][0][relation]=radiologist" +
        "&filter[include][0][scope][include][0]=radiologyLab" +
        "&filter[include][1][relation]=patient";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${loggedUser.token}'
      },
    );

    if (response.statusCode != 200) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    List<dynamic> body = json.decode(response.body);

    body.forEach((element) {
      result.add(RadioModel.fromJson(element));
    });

    radioModels.clear();
    radioModels.addAll(result);
  }

  Future<void> fetchRadioModelsByPatientId(String patientID) async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    switch (loggedUser.type) {
      case UserType.doctor:
        await _doctorFetchRadios(patientID, loggedUser);
        break;
      case UserType.patient:
        await _patientFetchRadios(loggedUser);
        break;
      default:
    }
  }

  Future<void> _patientFetchRadios(UserModel loggedPatient) async {
    List<RadioModel> result = List<RadioModel>.empty(growable: true);

    String url = common.baseURL +
        "/api/patients/radiologies" +
        "?filter[include][0][relation]=radiologist" +
        "&filter[include][0][scope][include][0]=radiologyLab" +
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
      result.add(RadioModel.fromJson(element));
    });

    radioModels.clear();
    radioModels.addAll(result);
  }

  Future<void> _doctorFetchRadios(
      String patientID, UserModel loggedDoctor) async {
    List<RadioModel> result = List<RadioModel>.empty(growable: true);

    String url = common.baseURL +
        "/api/doctors/patients/$patientID/radiology" +
        "?filter[include][0][relation]=radiologist" +
        "&filter[include][0][scope][include][0]=radiologyLab" +
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
      result.add(RadioModel.fromJson(element));
    });

    radioModels.clear();
    radioModels.addAll(result);
  }

  Future<void> addEditRadio() async {
    UserModel loggedRadiologist =
        serviceLocator<CurrentSessionService>().loggedUser;
    currentEdittingRadio.radiologistID = loggedRadiologist.userID;

    String url = common.baseURL +
        "/api/radiologists/radiologies" +
        ((currentEdittingRadio.radioID != '')
            ? "/${currentEdittingRadio.radioID}"
            : "");

    final response = (currentEdittingRadio.radioID != '')
        ? await http.patch(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${loggedRadiologist.token}'
            },
            body: jsonEncode(currentEdittingRadio),
          )
        : await http.post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': '${loggedRadiologist.token}'
            },
            body: jsonEncode(currentEdittingRadio),
          );
    if (response.statusCode != 200 && response.statusCode != 204) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    await fetchRadioModelsByRadiologistId();
  }
}
