import 'dart:math';

import 'package:hospitalmonitor/business_logic/models/analysis_model.dart';
import 'package:hospitalmonitor/business_logic/utils/analyzes%20.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class AnalyzesControlService {
  List<AnalysisModel> analysisModels =
      List<AnalysisModel>.empty(growable: true);

  AnalysisModel currentEdittingAnaysis = AnalysisModel();

  Future<void> fetchAnalysesModelsByAnalystId() async {
    String analystID =
        serviceLocator<CurrentSessionService>().loggedUser.userID;
    analysisModels.clear();
    List<AnalysisModel> result =
        analyzes.where((element) => element.analystID == analystID).toList();
    analysisModels.addAll(result);
  }

  Future<void> fetchAnalysesModelsByPatientId(String patientID) async {
    analysisModels.clear();
    List<AnalysisModel> result =
        analyzes.where((element) => element.patientID == patientID).toList();
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
