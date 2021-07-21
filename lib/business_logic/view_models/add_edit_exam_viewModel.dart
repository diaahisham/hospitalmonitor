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
  ExaminationModel currentEdittingExamination = ExaminationModel();

  List<ExaminationModel> get examModels =>
      serviceLocator<ExaminationControlService>().examModels;

  ValueNotifier<String> patientName = ValueNotifier<String>('');
  ValueNotifier<int> drugLength = ValueNotifier<int>(0);

  AddEditExamViewModel() {
    currentEdittingExamination
        .copy(serviceLocator<ExaminationControlService>().currentEdittingExam);
  }

  Future<void> submit() async {
    try {
      serviceLocator<ExaminationControlService>().currentEdittingExam =
          currentEdittingExamination;
      await serviceLocator<ExaminationControlService>().addEditExamination();
      _navigate();
    } catch (e) {
      dialogeService.showErrorDialoge("$e");
    }
  }

  String newDrug = "";

  void addDrug(String drug) {
    currentEdittingExamination.drugs.add(drug);
    drugLength.value = currentEdittingExamination.drugs.length;
  }

  void removeDrug(int index) {
    currentEdittingExamination.drugs.removeAt(index);
    drugLength.value = currentEdittingExamination.drugs.length;
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
