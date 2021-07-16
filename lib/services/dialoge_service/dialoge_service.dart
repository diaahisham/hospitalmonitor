import 'dart:async';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/ui/widgets/analyst_navigation_bar.dart';
import 'package:hospitalmonitor/ui/widgets/radiologist_navigation_bar.dart';

class DialogeService {
  void showErrorDialoge(String errorText) {
    showDialog(
      context:
          (serviceLocator<NavigationService>().navigatorKey.currentContext)!,
      builder: (context) => AlertDialog(
        title: Container(
          width: 200,
          height: 50,
          color: Colors.red,
          child: Center(child: Text("Error")),
        ),
        content: Container(
          width: 200,
          height: 100,
          color: Colors.white,
          child: Center(
            child: Text(errorText),
          ),
        ),
      ),
    );
  }

  Future<bool> showConfirmDialoge(String confirmText) async {
    bool result = false;
    await showDialog<bool>(
      context:
          (serviceLocator<NavigationService>().navigatorKey.currentContext)!,
      builder: (context) => AlertDialog(
        title: Container(
          width: 200,
          height: 50,
          color: Colors.blueGrey,
          child: Center(child: Text("Confirm")),
        ),
        content: Container(
          width: 200,
          height: 100,
          color: Colors.white,
          child: Center(
            child: Text(confirmText),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              result = true;
              serviceLocator<NavigationService>().goBack();
            },
            child: Container(
              height: 50,
              width: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              result = false;
              serviceLocator<NavigationService>().goBack();
            },
            child: Container(
              height: 50,
              width: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  void showInfoDialoge(String infoText) {
    showDialog(
      context:
          (serviceLocator<NavigationService>().navigatorKey.currentContext)!,
      builder: (context) => AlertDialog(
        title: Container(
          width: 200,
          height: 50,
          color: Colors.blue,
          child: Center(child: Text("Info")),
        ),
        content: Container(
          width: 200,
          height: 100,
          color: Colors.white,
          child: Center(
            child: Text(infoText),
          ),
        ),
      ),
    );
  }

  Widget _dataField({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: child,
    );
  }

  Future<UserModel> choosePatientDialoge() async {
    serviceLocator<PatientControlService>().fetchAllPatients();
    List<UserModel> allPatients =
        serviceLocator<PatientControlService>().allPatients;
    UserModel result = UserModel();

    ValueNotifier<String> searchValue = ValueNotifier<String>('');
    int rowNumber = -1;

    bool isRowVisible(String name) {
      if (searchValue.value == '') return true;

      if (name.length < searchValue.value.length) return false;

      return (searchValue.value.toLowerCase() ==
          name.substring(0, searchValue.value.length).toLowerCase());
    }

    void searchValueChange(String search) {
      rowNumber = -1;
      searchValue.value = search;
    }

    Color? rowColor() {
      rowNumber += 1;
      if (rowNumber % 2 == 1)
        return Colors.grey[350];
      else
        return Colors.white;
    }

    await showDialog(
      context:
          (serviceLocator<NavigationService>().navigatorKey.currentContext)!,
      builder: (context) => AlertDialog(
        title: Container(
          width: 350,
          height: 50,
          color: Colors.green,
          child: Center(child: Text("Patients")),
        ),
        content: Container(
          width: 350,
          height: 500,
          child: ListView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _dataField(
                    child: TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.name,
                      onChanged: (value) => searchValueChange(value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  )
                ],
              ),
              ValueListenableBuilder(
                valueListenable: searchValue,
                builder: (context, value, child) => Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  children: [
                    for (int i = 0; i < allPatients.length; i++)
                      if (isRowVisible(allPatients[i].userName))
                        TableRow(
                          decoration: BoxDecoration(
                            color: rowColor(),
                          ),
                          children: [
                            TextButton(
                              onPressed: () {
                                result = allPatients[i];
                                RadiologistNavigationBar.selectedIndex = 1;
                                AnalystNavigationBar.selectedIndex = 1;
                                serviceLocator<NavigationService>().goBack();
                              },
                              child: Center(
                                child: Text(allPatients[i].userName,
                                    textScaleFactor: 1.5),
                              ),
                            )
                          ],
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return result;
  }

  Future<void> showDataDialogue(String title, Widget data) async {
    showDialog(
      context:
          (serviceLocator<NavigationService>().navigatorKey.currentContext)!,
      builder: (context) => AlertDialog(
        title: Container(
          width: 200,
          height: 50,
          color: Colors.blue,
          child: Center(child: Text(title)),
        ),
        content: data,
      ),
    );
  }
}
