import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/ui/widgets/analyst_navigation_bar.dart';
import 'package:hospitalmonitor/ui/widgets/patient_navigation_bar.dart';
import 'package:hospitalmonitor/ui/widgets/radiologist_navigation_bar.dart';

class UserNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    switch (loggedUser.type) {
      case UserType.radiologist:
        return RadiologistNavigationBar();
      case UserType.analysit:
        return AnalystNavigationBar();
      case UserType.patient:
        return PatientNavigationBar();
      default:
        return Container(
          color: Colors.blue,
          height: 70,
        );
    }
  }
}
