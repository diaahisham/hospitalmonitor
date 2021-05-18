import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/report_viewModes.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class ReportView extends StatelessWidget {
  Widget leftSideItem(String title, int index, ReportViewModel model) {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      color: (index == model.widgetNo) ? Colors.blue[100] : Colors.white,
      child: TextButton(
        onPressed: () => model.widgetNO = index,
        child: Text(title),
      ),
    );
  }

  Widget infoColOne(String label, String info) {
    return Row(children: [
      Text(
        label,
        style: TextStyle(color: Color(0xffEA5B0C)),
      ),
      Text(info)
    ]);
  }

  Widget lineSeprator(double width) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        width: width,
        height: 1,
        color: Colors.black,
      ),
    );
  }

  Widget reportWidget(ReportViewModel model, BuildContext context) {
    double width = MediaQuery.of(context).size.width - 200;
    return Container(
      width: width,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.blue[100],
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
      child: ListView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // name row
                  infoColOne("Name:    ", model.currentPatient.userName),
                  //age row
                  infoColOne(
                      "Age:        ", model.currentPatient.age.toString()),
                  // Gender row
                  infoColOne("Gender:  ",
                      model.currentPatient.genderType.toString().substring(11)),
                ],
              ),
              Container(
                width: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // marital row
                  infoColOne(
                      "Marital status:  ",
                      model.currentPatient.maritalStatus
                          .toString()
                          .substring(14)),
                  // national ID
                  infoColOne(
                      "National ID:       ", model.currentPatient.nationalID),
                  // phone Row
                  infoColOne("Mobile:               ",
                      model.currentPatient.mobileNumber),
                ],
              )
            ],
          ),
          lineSeprator(width),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ReportViewModel>(
      create: (context) => ReportViewModel(),
      child: Consumer<ReportViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Health report'),
          bottomNavigationBar: UserNavigationBar(),
          backgroundColor: Colors.white,
          body: Container(
            child: Row(
              children: [
                Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          padding: EdgeInsets.all(20),
                          child: Image.memory(
                            base64Decode(
                              model.currentPatient.photo,
                            ),
                            scale: 1,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (model.userIsDoctor)
                        ValueListenableBuilder(
                          valueListenable: model.currentWidgetNumber,
                          builder: (context, value, child) => Column(
                            children: [
                              leftSideItem('Health report', 0, model),
                              leftSideItem('Analyzes', 1, model),
                              leftSideItem('Radios', 2, model),
                              leftSideItem('Examinations', 3, model),
                              TextButton(
                                onPressed: () => model.goToAllPatients(),
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xffEA5B0C),
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
                                      "All patients",
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
                        ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: model.currentWidgetNumber,
                  builder: (context, value, child) =>
                      model.viewWidget() ?? reportWidget(model, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
