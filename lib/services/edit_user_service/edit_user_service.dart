import 'dart:convert';
import 'dart:typed_data';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:http/http.dart' as http;

class EditUserService {
  Future<void> editUser(UserModel user) async {
    String url = common.baseURL;
    switch (user.type) {
      case UserType.doctor:
        url += "/api/doctors/update";
        break;

      case UserType.patient:
        url += "/api/patients/update";
        break;

      case UserType.radiologist:
        url += "/api/radiologists/update";
        break;

      case UserType.analyst:
        url += "/api/analysts/update";
        break;

      default:
        break;
    }
    print(json.encode(user));
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${user.token}'
      },
      body: json.encode(user),
    );
    Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode != 200) throw (body["error"]["message"]);

    serviceLocator<CurrentSessionService>().loggedUser = user;
  }

  // void _tempEditUser(List<UserModel> users, UserModel user) {
  //   users.removeWhere((element) => element.userID == user.userID);
  //   users.add(user);
  // }

  Future<void> changePicture() async {
    var fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    var buffer = fromPicker.buffer;
    String m = base64.encode(Uint8List.view(buffer));
    UserModel user = serviceLocator<CurrentSessionService>().loggedUser;
    user.photo = m;
    editUser(user);
  }
}
