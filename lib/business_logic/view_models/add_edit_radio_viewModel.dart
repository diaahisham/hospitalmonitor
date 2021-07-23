import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/radio_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/services/upload_file_service/upload_file_service.dart';

class AddEditRadioViewModel {
  DialogeService dialogeService = DialogeService();
  RadioModel currentEdittingRadio = RadioModel();
  FilePickerResult? radioFile;
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  ValueNotifier<String> radioUrlName = ValueNotifier<String>("");

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  AddEditRadioViewModel() {
    currentEdittingRadio
        .copy(serviceLocator<RadiosControlService>().currentEdittingRadio);
    radioUrlName.value = currentEdittingRadio.radioUrl;
  }

  Future<void> submit() async {
    try {
      loading.value = true;
      if (radioFile != null) {
        currentEdittingRadio.radioUrl = await _uploadFile();
      }
      serviceLocator<RadiosControlService>().currentEdittingRadio =
          currentEdittingRadio;
      await serviceLocator<RadiosControlService>().addEditRadio();
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
        currentEdittingRadio.patientID = choosedPatient.userID;
        currentEdittingRadio.patientName = choosedPatient.userName;
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
      serviceLocator<NavigationService>().popAndNavigateTo(routes.RadiosRoute);
  }

  Future<void> pickFile() async {
    radioFile = await FilePicker.platform.pickFiles();
    if (radioFile != null) {
      currentEdittingRadio.radioUrl = radioFile!.names.first!;
      radioUrlName.value = currentEdittingRadio.radioUrl;
    }
  }

  Future<String> _uploadFile() async {
    FileUploadService uploadService = FileUploadService();
    String result = await uploadService.uploadFile(
        radioFile!.names.first!, radioFile!.files.first.bytes!.toList());
    return result;
  }
}
