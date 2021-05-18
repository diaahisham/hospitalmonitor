import 'package:get_it/get_it.dart';
import 'package:hospitalmonitor/services/analyzes_control_service/analyzes_control_service.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/encryption_service/encryption_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/login_service/login_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/report_controll_service/report_controll_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<EncryptionService>(EncryptionService());
  serviceLocator.registerSingleton<LoginService>(LoginService());
  serviceLocator.registerSingleton<NavigationService>(NavigationService());
  serviceLocator
      .registerSingleton<CurrentSessionService>(CurrentSessionService());
  serviceLocator
      .registerSingleton<RadiosControlService>(RadiosControlService());
  serviceLocator
      .registerSingleton<PatientControlService>(PatientControlService());
  serviceLocator
      .registerSingleton<AnalyzesControlService>(AnalyzesControlService());
  serviceLocator.registerSingleton<ExaminationControlService>(
      ExaminationControlService());
  serviceLocator
      .registerSingleton<ReportControlService>(ReportControlService());
}
