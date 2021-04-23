import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class ProfileViewModel {
  final formKey = GlobalKey<FormState>();
  UserModel currentUser = UserModel();
  UserModel newUser = UserModel();
  ValueNotifier<bool> edittingMode = ValueNotifier<bool>(false);
  String oldPassword = '';

  ProfileViewModel() {
    this.currentUser = serviceLocator<CurrentSessionService>().loggedUser;
  }

  void cancelEditting() {
    edittingMode.value = false;
    newUser = UserModel();
  }

  void submitEditting() {}

  void logout() {
    serviceLocator<CurrentSessionService>().logout();
    serviceLocator<NavigationService>().goBack();
  }

  String getUserTypeAsString() {
    return currentUser.type.toString().replaceAll('UserType.', '').replaceFirst(
        currentUser.type.toString()[0],
        currentUser.type.toString()[0].toUpperCase());
  }
}
