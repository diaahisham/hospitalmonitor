import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/buisness_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class LoginViewModel {
  final formKey = GlobalKey<FormState>();
  UserModel user = UserModel();
  String title = '';
  LoginViewModel() {
    user.type = serviceLocator<CurrentSessionService>().loggedUser.type;
    this.title = this.user.type.toString().replaceAll('UserType.', '');
    title = title.replaceFirst(title[0], title[0].toUpperCase());
  }

  void submitLogin() {}
}
