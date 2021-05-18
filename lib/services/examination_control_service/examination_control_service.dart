import 'dart:math';

import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/utils/examinations.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class ExaminationControlService {
  List<ExaminationModel> examModels =
      List<ExaminationModel>.empty(growable: true);

  ExaminationModel currentEdittingExam = ExaminationModel();

  Future<void> fetchExamModelsByDoctorId() async {
    String doctorID = serviceLocator<CurrentSessionService>().loggedUser.userID;
    examModels.clear();
    List<ExaminationModel> result =
        examinations.where((element) => element.doctorID == doctorID).toList();
    examModels.addAll(result);
  }

  Future<void> fetchExamModelsByPatientId(String patientID) async {
    examModels.clear();
    List<ExaminationModel> result = examinations
        .where((element) => element.patientID == patientID)
        .toList();
    examModels.addAll(result);
  }

  Future<void> addEditExamination() async {
    currentEdittingExam.date = DateTime.now().toString().substring(0, 10);
    currentEdittingExam.doctorID =
        serviceLocator<CurrentSessionService>().loggedUser.userID;
    currentEdittingExam.doctorName =
        serviceLocator<CurrentSessionService>().loggedUser.userName;
    if (currentEdittingExam.examinationID == '') {
      currentEdittingExam.examinationID = Random().toString();
    } else {
      examinations.removeWhere((element) =>
          element.examinationID == currentEdittingExam.examinationID);
    }
    examinations.add(currentEdittingExam);
    await fetchExamModelsByDoctorId();
  }
}
