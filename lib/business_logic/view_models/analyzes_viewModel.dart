import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/analysis_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AnalyzesViewModel {
  List<AnalysisModel> get analysisModels =>
      serviceLocator<AnalyzesControlService>().analysisModels;
  bool userIsAnalysit = false;
  ValueNotifier<int> analysesLength = ValueNotifier<int>(0);
  DialogeService dialogeService = DialogeService();

  AnalyzesViewModel() {
    userIsAnalysit = (serviceLocator<CurrentSessionService>().loggedUser.type ==
        UserType.analysit);
    sortAnalyzes();
  }

  Future<void> deleteAnalysis(AnalysisModel radioModel) async {
    analysisModels
        .removeWhere((element) => element.analysisID == radioModel.analysisID);
    analysesLength.value = analysisModels.length;
    sortAnalyzes();
  }

  void addAnalysis() {
    serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
        AnalysisModel();
    serviceLocator<NavigationService>().navigateTo(routes.AddEditAnalysisRoute);
    sortAnalyzes();
  }

  void editAnalysis(AnalysisModel analysisModel) {
    serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
        analysisModel;
    serviceLocator<NavigationService>().navigateTo(routes.AddEditAnalysisRoute);
    sortAnalyzes();
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      dialogeService.showErrorDialoge('Could not launch $url');
    }
  }

  void sortAnalyzes() {
    if (this.userIsAnalysit)
      analysisModels.sort((a, b) => a.patientName.compareTo(b.patientName));
    else
      analysisModels.sort((a, b) => a.analystName.compareTo(b.analystName));
  }
}
