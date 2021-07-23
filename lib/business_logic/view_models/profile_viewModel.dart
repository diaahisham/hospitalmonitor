import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/day_dates_model.dart';
import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
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

  //
  ValueNotifier<bool> edittingDayDates = ValueNotifier<bool>(false);
  ValueNotifier<int> dayDatesListLength = ValueNotifier<int>(0);
  DayDatesModel newDayDates = DayDatesModel();

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
  DialogeService dialogeService = DialogeService();

  ProfileViewModel() {
    this.currentUser = UserModel.fromJson(jsonDecode(
        serviceLocator<CurrentSessionService>().loggedUser.toString()));
    currentGenderType = genderTypes[1];
    if (currentUser.type == UserType.patient)
      reportModel.copy(serviceLocator<ReportControlService>().reportModels[0]);
    else {
      this.currentUser.dayDates = List<DayDatesModel>.empty(growable: true);
      serviceLocator<CurrentSessionService>()
          .nonPatientUser
          .dayDates
          .forEach((element) {
        this.currentUser.dayDates.add(element.duplicate());
      });
      // this.currentUser.dayDates = List<DayDatesModel>.from(
      //     serviceLocator<CurrentSessionService>().nonPatientUser.dayDates);
      dayDatesListLength.value = this.currentUser.dayDates.length;
    }
  }

  void changeGender(int index) {
    currentGenderType = genderTypes[index];
    genderTypeIndex.value = index;
  }

  void cancelEditting() {
    this.currentUser = UserModel.fromJson(jsonDecode(
        serviceLocator<CurrentSessionService>().loggedUser.toString()));

    this.currentUser.dayDates = List<DayDatesModel>.empty(growable: true);
    serviceLocator<CurrentSessionService>()
        .nonPatientUser
        .dayDates
        .forEach((element) {
      this.currentUser.dayDates.add(element.duplicate());
    });
    // this.currentUser.dayDates = List<DayDatesModel>.from(
    //     serviceLocator<CurrentSessionService>().nonPatientUser.dayDates);
    edittingMode.value = false;
    edittingDayDates.value = false;
  }

  Future<void> submitEditDayDates() async {
    try {
      if (edittingDayDates.value) {
        if (this.currentUser.password == "")
          throw Exception("Password cant be empty");
        EditUserService editUserService = EditUserService();
        currentUser.genderType = GenderType.values[genderTypeIndex.value];
        await editUserService.editUser(currentUser);

        edittingMode.value = false;
        edittingDayDates.value = false;
        dialogeService.showInfoDialoge("Updated succesfully");
      } else {
        edittingDayDates.value = true;
      }
    } catch (e) {
      dialogeService.showErrorDialoge("Error in updating: $e");
    }
  }

  Future<void> submitEditting() async {
    try {
      if (edittingMode.value) {
        if (this.currentUser.password == "")
          throw Exception("Password cant be empty");
        EditUserService editUserService = EditUserService();
        currentUser.genderType = GenderType.values[genderTypeIndex.value];
        await editUserService.editUser(currentUser);

        edittingMode.value = false;
        edittingDayDates.value = false;
        dialogeService.showInfoDialoge("Updated succesfully");
      } else {
        edittingMode.value = true;
      }
    } catch (e) {
      dialogeService.showErrorDialoge("Error in updating: $e");
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

  void addDayDate() {
    this.currentUser.dayDates.add(newDayDates);
    this.dayDatesListLength.value = this.currentUser.dayDates.length;
  }

  void removeDayDate(int index) {
    this.currentUser.dayDates.removeAt(index);
    this.dayDatesListLength.value = this.currentUser.dayDates.length;
  }

  Color? rowColor(int rowNumber) {
    //rowNumber += 1;
    if (rowNumber % 2 == 1)
      return Colors.grey[350];
    else
      return Colors.white;
  }
}

class GenderTypesList {
  int index = 1;
  String type = '';
  GenderTypesList(this.index, this.type);
}
