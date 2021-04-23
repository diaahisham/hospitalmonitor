import 'dart:convert' as json;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/encryption_service/encryption_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class CurrentSessionService {
  UserModel _loggedUser = UserModel();
  final String sessionKey = 'UserType';
  CurrentSessionService() {
    if (!window.sessionStorage.containsKey(this.sessionKey)) {
      String encryptedUserData = serviceLocator<EncryptionService>()
          .encryptDataString(message: _loggedUser.toString());
      window.sessionStorage[this.sessionKey] = encryptedUserData;
    }
  }

  UserModel get loggedUser {
    String? user = window.sessionStorage[this.sessionKey];
    if (user != null) {
      user = serviceLocator<EncryptionService>()
          .decryptDataString(encryptedMessage: user);
      return UserModel.fromJson(json.jsonDecode(user));
    } else
      return _loggedUser;
  }

  set loggedUser(UserModel user) {
    this._loggedUser = user;
    String encryptedUserData = serviceLocator<EncryptionService>()
        .encryptDataString(message: this._loggedUser.toString());
    window.sessionStorage[this.sessionKey] = encryptedUserData;
  }

  void logout() {
    if (!window.sessionStorage.containsKey(this.sessionKey)) {
      window.sessionStorage[this.sessionKey] = '';
      _loggedUser = UserModel();
    }
  }
}
