import 'package:hospitalmonitor/buisness_logic/models/user_model.dart';

class CurrentSessionService {
  UserModel _loggedUser = UserModel();

  UserModel get loggedUser => this._loggedUser;
  set loggedUser(UserModel user) => this._loggedUser = user;
}
