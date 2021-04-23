import 'package:flutter/cupertino.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/login_service/login_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class LoginViewModel {
  final formKey = GlobalKey<FormState>();
  UserModel user = UserModel();
  ValueNotifier<String> wrongCredentialsText = ValueNotifier<String>('');
  String title = '';
  LoginViewModel() {
    user.type = serviceLocator<CurrentSessionService>().loggedUser.type;
    this.title = this.user.type.toString().replaceAll('UserType.', '');
    title = title.replaceFirst(title[0], title[0].toUpperCase());
    wrongCredentialsText.value = '';
  }

  void submitLogin() {
    try {
      serviceLocator<LoginService>().login(this.user);
      serviceLocator<NavigationService>().popAndNavigateTo(routes.ProfileRoute);
    } on Exception catch (e) {
      wrongCredentialsText.value = e.toString().substring(11);
    }
  }
}
