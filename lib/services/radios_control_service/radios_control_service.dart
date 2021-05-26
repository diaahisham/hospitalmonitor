import 'dart:math';

import 'package:hospitalmonitor/business_logic/models/radio_model.dart';
import 'package:hospitalmonitor/business_logic/utils/radios.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class RadiosControlService {
  List<RadioModel> radioModels = List<RadioModel>.empty(growable: true);

  RadioModel currentEdittingRadio = RadioModel();

  Future<void> fetchRadioModelsByRadiologistId() async {
    String radiologistID =
        serviceLocator<CurrentSessionService>().loggedUser.userID;
    radioModels.clear();
    List<RadioModel> result = radios
        .where((element) => element.radiologistID == radiologistID)
        .toList();
    radioModels.addAll(result);
  }

  Future<void> fetchRadioModelsByPatientId(String patientID) async {
    radioModels.clear();
    List<RadioModel> result =
        radios.where((element) => element.patientID == patientID).toList();
    radioModels.clear();
    radioModels.addAll(result);
  }

  Future<void> addEditRadio() async {
    currentEdittingRadio.date = DateTime.now().toString().substring(0, 10);
    currentEdittingRadio.radiologistID =
        serviceLocator<CurrentSessionService>().loggedUser.userID;
    currentEdittingRadio.radiologistName =
        serviceLocator<CurrentSessionService>().loggedUser.userName;
    if (currentEdittingRadio.radioID == '') {
      currentEdittingRadio.radioID = Random().toString();
    } else {
      radios.removeWhere(
          (element) => element.radioID == currentEdittingRadio.radioID);
    }
    radios.add(currentEdittingRadio);
    await fetchRadioModelsByRadiologistId();
  }
}
