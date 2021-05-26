import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class ExaminationViewModel {
  List<ExaminationModel> get examModels =>
      serviceLocator<ExaminationControlService>().examModels;
  bool userIsDoctor = false;
  ValueNotifier<int> examssLength = ValueNotifier<int>(0);
  DialogeService dialogeService = DialogeService();

  UserType get loggedUserType =>
      serviceLocator<CurrentSessionService>().loggedUser.type;

  UserModel user = serviceLocator<CurrentSessionService>().loggedUser;

  ExaminationViewModel() {
    userIsDoctor = (serviceLocator<CurrentSessionService>().loggedUser.type ==
        UserType.doctor);
  }

  Future<void> deleteExam(ExaminationModel examModel) async {
    examModels.removeWhere(
        (element) => element.examinationID == examModel.examinationID);
    examssLength.value = examModels.length;
    sortExams();
  }

  void addExam() {
    serviceLocator<ExaminationControlService>().currentEdittingExam =
        ExaminationModel();
    serviceLocator<NavigationService>().navigateTo(routes.AddEditExamRoute);
    sortExams();
  }

  void editExam(ExaminationModel examModel) {
    serviceLocator<ExaminationControlService>().currentEdittingExam = examModel;
    serviceLocator<NavigationService>().navigateTo(routes.AddEditExamRoute);
    sortExams();
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

  void sortExams() {
    if (this.userIsDoctor)
      examModels.sort((a, b) => a.patientName.compareTo(b.patientName));
    else
      examModels.sort((a, b) => a.doctorName.compareTo(b.doctorName));
  }
}
