import 'dart:math';
import 'dart:convert';
import 'package:hospitalmonitor/business_logic/models/analysis_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/analyzes%20.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:http/http.dart' as http;

class AnalyzesControlService {
  List<AnalysisModel> analysisModels =
      List<AnalysisModel>.empty(growable: true);

  AnalysisModel currentEdittingAnaysis = AnalysisModel();

  Future<void> fetchAnalysesModelsByAnalystId() async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    List<AnalysisModel> result = List<AnalysisModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/analysts/analyses" +
        "?filter[include][0][relation]=analyst" +
        "&filter[include][0][scope][include][0]=analysisLab" +
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
      result.add(AnalysisModel.fromJson(element));
    });

    analysisModels.clear();
    analysisModels.addAll(result);
  }

  Future<void> fetchAnalysesModelsByPatientId(String patientID) async {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    switch (loggedUser.type) {
      case UserType.doctor:
        await _doctorFetchAnalyis(patientID, loggedUser);
        break;
      case UserType.patient:
        await _patientFetchAnalyis(loggedUser);
        break;
      default:
    }
  }

  Future<void> _patientFetchAnalyis(UserModel loggedPatient) async {
    List<AnalysisModel> result = List<AnalysisModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/patients/analyses" +
        "?filter[include][0][relation]=analyst" +
        "&filter[include][0][scope][include][0]=analysisLab" +
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
      result.add(AnalysisModel.fromJson(element));
    });

    analysisModels.clear();
    analysisModels.addAll(result);
  }

  Future<void> _doctorFetchAnalyis(
      String patientID, UserModel loggedDoctor) async {
    List<AnalysisModel> result = List<AnalysisModel>.empty(growable: true);
    String url = common.baseURL +
        "/api/doctors/patients/$patientID/analyses" +
        "?filter[include][0][relation]=analyst" +
        "&filter[include][0][scope][include][0]=analysisLab" +
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
      result.add(AnalysisModel.fromJson(element));
    });

    analysisModels.clear();
    analysisModels.addAll(result);
  }

  Future<void> addEditAnalysis() async {
    currentEdittingAnaysis.date = DateTime.now().toString().substring(0, 10);
    currentEdittingAnaysis.analystID =
        serviceLocator<CurrentSessionService>().loggedUser.userID;
    currentEdittingAnaysis.analystName =
        serviceLocator<CurrentSessionService>().loggedUser.userName;
    if (currentEdittingAnaysis.analysisID == '') {
      currentEdittingAnaysis.analysisID = Random().toString();
    } else {
      analyzes.removeWhere(
          (element) => element.analysisID == currentEdittingAnaysis.analysisID);
    }
    analyzes.add(currentEdittingAnaysis);
    await fetchAnalysesModelsByAnalystId();
  }
}
