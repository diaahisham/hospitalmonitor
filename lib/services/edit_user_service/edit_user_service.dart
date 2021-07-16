import 'dart:convert';
import 'dart:typed_data';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/analysts.dart';
import 'package:hospitalmonitor/business_logic/utils/doctors.dart';
import 'package:hospitalmonitor/business_logic/utils/patients.dart';
import 'package:hospitalmonitor/business_logic/utils/radiologists.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:image_picker_web/image_picker_web.dart';

class EditUserService {
  Future<void> editUser(UserModel user) async {
    switch (user.type) {
      case UserType.doctor:
        _tempEditUser(doctors, user);
        break;

      case UserType.patient:
        _tempEditUser(patients, user);
        break;

      case UserType.radiologist:
        _tempEditUser(radiologists, user);
        break;

      case UserType.analyst:
        _tempEditUser(analysts, user);
        break;

      default:
        break;
    }
    serviceLocator<CurrentSessionService>().loggedUser = user;
  }

  void _tempEditUser(List<UserModel> users, UserModel user) {
    users.removeWhere((element) => element.userID == user.userID);
    users.add(user);
  }

  Future<void> changePicture() async {
    var fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    var buffer = fromPicker.buffer;
    String m = base64.encode(Uint8List.view(buffer));
    UserModel user = serviceLocator<CurrentSessionService>().loggedUser;
    user.photo = m;
    editUser(user);
  }
}
