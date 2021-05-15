import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/models/analysis_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AddEditAnalysisViewModel {
  DialogeService dialogeService = DialogeService();
  AnalysisModel get currentEdittingAnalysis =>
      serviceLocator<AnalyzesControlService>().currentEdittingAnaysis;

  set currentEdittingAnalysis(AnalysisModel newRadio) =>
      serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
          newRadio;

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  Future<void> submit() async {
    await serviceLocator<AnalyzesControlService>().addEditAnalysis();
    serviceLocator<NavigationService>().popAndNavigateTo(routes.AnalysisRoute);
  }

  void cancel() {
    serviceLocator<NavigationService>().popAndNavigateTo(routes.AnalysisRoute);
  }

  Future<void> choosePatient() async {
    UserModel choosedPatient = await dialogeService.choosePatientDialoge();
    if (choosedPatient.userID != '') {
      currentEdittingAnalysis.patientID = choosedPatient.userID;
      currentEdittingAnalysis.patientName = choosedPatient.userName;
      patientName.value = choosedPatient.userName;
    }
  }
}