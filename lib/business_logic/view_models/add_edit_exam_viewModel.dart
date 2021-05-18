import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class AddEditExamViewModel {
  DialogeService dialogeService = DialogeService();
  ExaminationModel get currentEdittingExamination =>
      serviceLocator<ExaminationControlService>().currentEdittingExam;

  set currentEdittingExamination(ExaminationModel newRadio) =>
      serviceLocator<ExaminationControlService>().currentEdittingExam =
          newRadio;

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  Future<void> submit() async {
    await serviceLocator<ExaminationControlService>().addEditExamination();
    serviceLocator<NavigationService>()
        .popAndNavigateTo(routes.ExaminationViewRoute);
  }

  void cancel() {
    serviceLocator<NavigationService>()
        .popAndNavigateTo(routes.ExaminationViewRoute);
  }

  Future<void> choosePatient() async {
    UserModel choosedPatient = await dialogeService.choosePatientDialoge();
    if (choosedPatient.userID != '') {
      currentEdittingExamination.patientID = choosedPatient.userID;
      currentEdittingExamination.patientName = choosedPatient.userName;
      patientName.value = choosedPatient.userName;
    }
  }
}