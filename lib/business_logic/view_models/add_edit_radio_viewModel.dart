import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/models/radio_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class AddEditRadioViewModel {
  DialogeService dialogeService = DialogeService();
  RadioModel get currentEdittingRadio =>
      serviceLocator<RadiosControlService>().currentEdittingRadio;

  set currentEdittingRadio(RadioModel newRadio) =>
      serviceLocator<RadiosControlService>().currentEdittingRadio = newRadio;

  ValueNotifier<String> patientName = ValueNotifier<String>('');

  Future<void> submit() async {
    await serviceLocator<RadiosControlService>().addEditRadio();
    serviceLocator<NavigationService>().popAndNavigateTo(routes.RadiosRoute);
  }

  void cancel() {
    serviceLocator<NavigationService>().popAndNavigateTo(routes.RadiosRoute);
  }

  Future<void> choosePatient() async {
    UserModel choosedPatient = await dialogeService.choosePatientDialoge();
    if (choosedPatient.userID != '') {
      currentEdittingRadio.patientID = choosedPatient.userID;
      currentEdittingRadio.patientName = choosedPatient.userName;
      patientName.value = choosedPatient.userName;
    }
  }
}
