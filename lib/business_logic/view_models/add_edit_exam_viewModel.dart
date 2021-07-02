import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class AddEditExamViewModel {
  DialogeService dialogeService = DialogeService();
  ExaminationModel get currentEdittingExamination =>
      serviceLocator<ExaminationControlService>().currentEdittingExam;

  List<ExaminationModel> get examModels =>
      serviceLocator<ExaminationControlService>().examModels;

  set currentEdittingExamination(ExaminationModel newRadio) =>
      serviceLocator<ExaminationControlService>().currentEdittingExam =
          newRadio;

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  Future<void> submit() async {
    await serviceLocator<ExaminationControlService>().addEditExamination();
    _navigate();
  }

  Future<void> deleteExam() async {
    examModels.removeWhere((element) =>
        element.examinationID == currentEdittingExamination.examinationID);
    _navigate();
  }

  void cancel() {
    _navigate();
  }

  Future<void> choosePatient() async {
    UserModel choosedPatient = await dialogeService.choosePatientDialoge();
    if (choosedPatient.userID != '') {
      currentEdittingExamination.patientID = choosedPatient.userID;
      currentEdittingExamination.patientName = choosedPatient.userName;
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
          .popAndNavigateTo(routes.ExaminationViewRoute);
  }
}
