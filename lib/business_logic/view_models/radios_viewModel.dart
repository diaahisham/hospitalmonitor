import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/models/radio_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/radios_control_service/radios_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class RadiosviewModel {
  List<RadioModel> get radioModels =>
      serviceLocator<RadiosControlService>().radioModels;
  bool userIsRadiologist = false;
  ValueNotifier<int> radiosLength = ValueNotifier<int>(0);
  DialogeService dialogeService = DialogeService();

  RadiosviewModel() {
    userIsRadiologist =
        (serviceLocator<CurrentSessionService>().loggedUser.type ==
            UserType.radiologist);
  }

  Future<void> deleteRadio(RadioModel radioModel) async {
    radioModels.removeWhere((element) => element.radioID == radioModel.radioID);
    radiosLength.value = radioModels.length;
    sortRadios();
  }

  void addRadio() {
    serviceLocator<RadiosControlService>().currentEdittingRadio = RadioModel();
    serviceLocator<NavigationService>().navigateTo(routes.AddEditRadioRoute);
    sortRadios();
  }

  void editRadio(RadioModel radioModel) {
    serviceLocator<RadiosControlService>().currentEdittingRadio = radioModel;
    serviceLocator<NavigationService>().navigateTo(routes.AddEditRadioRoute);
    sortRadios();
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      dialogeService.showErrorDialoge('Could not launch $url');
    }
  }

  void sortRadios() {
    if (this.userIsRadiologist)
      radioModels.sort((a, b) => a.patientName.compareTo(b.patientName));
    else
      radioModels
          .sort((a, b) => a.radiologistName.compareTo(b.radiologistName));
  }
}
