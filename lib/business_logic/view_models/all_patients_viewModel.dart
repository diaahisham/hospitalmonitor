import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/report_controll_service/report_controll_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AllPatientsViewModel {
  List<UserModel> patients =
      serviceLocator<PatientControlService>().allPatients;

  Future<void> viewPatient(UserModel patient) async {
    await serviceLocator<ReportControlService>()
        .fetchReportModelsByPatientId(patient.userID);
    serviceLocator<PatientControlService>().currentPatient = patient;
    await serviceLocator<AnalyzesControlService>()
        .fetchAnalysesModelsByPatientId(patient.userID);
    await serviceLocator<RadiosControlService>()
        .fetchRadioModelsByPatientId(patient.userID);
    await serviceLocator<ExaminationControlService>()
        .fetchExamModelsByPatientId(patient.userID);
    serviceLocator<NavigationService>().navigateTo(routes.HealthReportRoute);
  }
}
