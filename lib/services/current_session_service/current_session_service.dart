import 'dart:convert' as json;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:hospitalmonitor/buisness_logic/models/user_model.dart';

class CurrentSessionService {
  UserModel _loggedUser = UserModel();
  final String sessionKey = 'UserType';
  CurrentSessionService() {
    if (!window.sessionStorage.containsKey(this.sessionKey)) {
      window.sessionStorage[this.sessionKey] =
          '{"Type":${this._loggedUser.type.index}}';
    }
  }

  UserModel get loggedUser {
    var user = window.sessionStorage[this.sessionKey];
    if (user != null)
      return UserModel.fromJson(json.jsonDecode(user));
    else
      return _loggedUser;
  }

  set loggedUser(UserModel user) {
    this._loggedUser = user;
    window.sessionStorage[this.sessionKey] =
        '{"Type":${this._loggedUser.type.index}}';
  }
}
