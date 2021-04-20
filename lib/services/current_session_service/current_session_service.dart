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
          .encryptDataString(
              message:
                  '{"Type":${this._loggedUser.type.index},"Token":"${this._loggedUser.token}"}');
      window.sessionStorage[this.sessionKey] = encryptedUserData;
    }
  }

  UserModel get loggedUserType {
    String? user = window.sessionStorage[this.sessionKey];
    if (user != null) {
      user = serviceLocator<EncryptionService>()
          .decryptDataString(encryptedMessage: user);
      return UserModel.fromJson(json.jsonDecode(user));
    } else
      return _loggedUser;
  }

  set loggedUserType(UserModel user) {
    this._loggedUser = user;
    String encryptedUserData = serviceLocator<EncryptionService>()
        .encryptDataString(
            message:
                '{"Type":${this._loggedUser.type.index},"Token":"${this._loggedUser.token}"}');
    window.sessionStorage[this.sessionKey] = encryptedUserData;
  }

  UserModel get loggedUserData => this._loggedUser;
}
