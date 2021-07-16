import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/edit_user_service/edit_user_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/report_controll_service/report_controll_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class ProfileViewModel {
  final formKey = GlobalKey<FormState>();
  UserModel currentUser = UserModel();
  ValueNotifier<bool> edittingMode = ValueNotifier<bool>(false);

  ValueNotifier<int> currentWidgetNumber = ValueNotifier<int>(0);
  set widgetNO(int no) => currentWidgetNumber.value = no;

  int get widgetNo => currentWidgetNumber.value;

  List<GenderTypesList> genderTypes = [
    GenderTypesList(0, "Female"),
    GenderTypesList(1, "Male")
  ];
  ValueNotifier<int> genderTypeIndex = ValueNotifier<int>(1);
  GenderTypesList currentGenderType = GenderTypesList(1, "Male");
  HealthReportModel reportModel = HealthReportModel();

  ProfileViewModel() {
    this.currentUser = UserModel.fromJson(jsonDecode(
        serviceLocator<CurrentSessionService>().loggedUser.toString()));
    currentGenderType = genderTypes[1];
    reportModel.copy(serviceLocator<ReportControlService>().reportModels[0]);
  }

  void changeGender(int index) {
    currentGenderType = genderTypes[index];
    genderTypeIndex.value = index;
  }

  void cancelEditting() {
    this.currentUser = UserModel.fromJson(jsonDecode(
        serviceLocator<CurrentSessionService>().loggedUser.toString()));
    edittingMode.value = false;
  }

  Future<void> submitEditting() async {
    if (edittingMode.value) {
      EditUserService editUserService = EditUserService();
      currentUser.genderType = GenterType.values[genderTypeIndex.value];
      await editUserService.editUser(currentUser);
      edittingMode.value = false;
    } else {
      edittingMode.value = true;
    }
  }

  String getUserTypeAsString() {
    return currentUser.type.toString().replaceAll('UserType.', '').replaceFirst(
        currentUser.type.toString()[0],
        currentUser.type.toString()[0].toUpperCase());
  }

  Future<void> changePicture() async {
    EditUserService editUserService = EditUserService();
    await editUserService.changePicture();
    serviceLocator<NavigationService>().popAndNavigateTo(routes.ProfileRoute);
  }
}

class GenderTypesList {
  int index = 1;
  String type = '';
  GenderTypesList(this.index, this.type);
}
