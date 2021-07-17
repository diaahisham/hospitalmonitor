import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/models/analysis_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AddEditAnalysisViewModel {
  DialogeService dialogeService = DialogeService();
  AnalysisModel currentEdittingAnalysis = AnalysisModel();
  //  serviceLocator<AnalyzesControlService>().currentEdittingAnaysis;

  // set currentEdittingAnalysis(AnalysisModel newRadio) =>
  //     serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
  //         newRadio;

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  AddEditAnalysisViewModel() {
    currentEdittingAnalysis
        .copy(serviceLocator<AnalyzesControlService>().currentEdittingAnaysis);
  }

  Future<void> submit() async {
    serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
        currentEdittingAnalysis;
    await serviceLocator<AnalyzesControlService>().addEditAnalysis();
    _navigate();
  }

  void cancel() {
    _navigate();
  }

  Future<void> choosePatient() async {
    UserModel choosedPatient = await dialogeService.choosePatientDialoge();
    if (choosedPatient.userID != '') {
      currentEdittingAnalysis.patientID = choosedPatient.userID;
      currentEdittingAnalysis.patientName = choosedPatient.userName;
      patientName.value = choosedPatient.userName;
    }
  }

  void _navigate() {
    if (serviceLocator<CurrentSessionService>().loggedUser.type ==
        UserType.doctor)
      serviceLocator<NavigationService>()
          .popAndNavigateTo(routes.HealthReportRoute);
    else
      serviceLocator<NavigationService>()
          .popAndNavigateTo(routes.AnalysisRoute);
  }
}
