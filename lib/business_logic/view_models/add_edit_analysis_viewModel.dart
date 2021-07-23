import 'package:file_picker/file_picker.dart';
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
import 'package:hospitalmonitor/services/upload_file_service/upload_file_service.dart';

class AddEditAnalysisViewModel {
  DialogeService dialogeService = DialogeService();
  AnalysisModel currentEdittingAnalysis = AnalysisModel();
  FilePickerResult? analysisFile;

  ValueNotifier<String> patientName = ValueNotifier<String>('');
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  ValueNotifier<String> analysisUrlName = ValueNotifier<String>("");

  AddEditAnalysisViewModel() {
    currentEdittingAnalysis
        .copy(serviceLocator<AnalyzesControlService>().currentEdittingAnaysis);
    analysisUrlName.value = currentEdittingAnalysis.analysisUrl;
  }

  Future<void> submit() async {
    try {
      loading.value = true;
      if (analysisFile != null) {
        currentEdittingAnalysis.analysisUrl = await _uploadFile();
      }
      serviceLocator<AnalyzesControlService>().currentEdittingAnaysis =
          currentEdittingAnalysis;
      await serviceLocator<AnalyzesControlService>().addEditAnalysis();
      _navigate();
    } catch (e) {
      loading.value = false;
      dialogeService.showErrorDialoge("$e");
    }
  }

  void cancel() {
    _navigate();
  }

  Future<void> choosePatient() async {
    try {
      UserModel choosedPatient = await dialogeService.choosePatientDialoge();
      if (choosedPatient.userID != '') {
        currentEdittingAnalysis.patientID = choosedPatient.userID;
        currentEdittingAnalysis.patientName = choosedPatient.userName;
        patientName.value = choosedPatient.userName;
      }
    } catch (e) {
      dialogeService.showErrorDialoge("$e");
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

  Future<void> pickFile() async {
    analysisFile = await FilePicker.platform.pickFiles();
    if (analysisFile != null) {
      currentEdittingAnalysis.analysisUrl = analysisFile!.names.first!;
      analysisUrlName.value = currentEdittingAnalysis.analysisUrl;
    }
  }

  Future<String> _uploadFile() async {
    FileUploadService uploadService = FileUploadService();
    String result = await uploadService.uploadFile(
        analysisFile!.names.first!, analysisFile!.files.first.bytes!.toList());
    return result;
  }
}
