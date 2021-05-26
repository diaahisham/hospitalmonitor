import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/examination_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class ExaminationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ExaminationViewModel>(
      create: (context) => ExaminationViewModel(),
      child: Consumer<ExaminationViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: (model.loggedUserType != UserType.doctor)
              ? UserAppbar('Examinations')
              : null,
          bottomNavigationBar: (model.loggedUserType != UserType.doctor)
              ? UserNavigationBar()
              : null,
          backgroundColor: Colors.blue[100],
          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              children: [
                ValueListenableBuilder(
                  valueListenable: model.examssLength,
                  builder: (context, value, child) => Table(
                    border: TableBorder.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    children: [
                      TableRow(
                          decoration: BoxDecoration(color: Colors.blueAccent),
                          children: [
                            if (!model.userIsDoctor)
                              Center(
                                  child: Text(
                                "Doctor name",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            Center(
                                child: Text(
                              "Patient name",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Date",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Symptoms",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "ExaminationResult",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Notes",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            if (model.userIsDoctor)
                              Center(
                                  child: Text(
                                "Edit",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            if (model.userIsDoctor)
                              Center(
                                  child: Text(
                                "Delete",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                          ]),
                      for (int i = 0; i < model.examModels.length; i++)
                        TableRow(
                          decoration: BoxDecoration(
                              color: (i % 2 == 1)
                                  ? Colors.grey[350]
                                  : Colors.white),
                          children: [
                            if (!model.userIsDoctor)
                              Center(
                                  child: Text(model.examModels[i].doctorName,
                                      textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.examModels[i].patientName,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.examModels[i].date,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.examModels[i].symptoms,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(
                                    model.examModels[i].examinationResult,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.examModels[i].notes,
                                    textScaleFactor: 1.5)),
                            if (model.userIsDoctor)
                              (model.user.userID ==
                                      model.examModels[i].doctorID)
                                  ? TextButton(
                                      onPressed: () =>
                                          model.editExam(model.examModels[i]),
                                      child: Center(
                                          child: Text("Edit",
                                              style: TextStyle(
                                                color: Colors.blue[900],
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              textScaleFactor: 1.5)),
                                    )
                                  : Text(''),
                            if (model.userIsDoctor)
                              (model.user.userID ==
                                      model.examModels[i].doctorID)
                                  ? TextButton(
                                      onPressed: () =>
                                          model.deleteExam(model.examModels[i]),
                                      child: Center(
                                          child: Text("Delete",
                                              style: TextStyle(
                                                color: Colors.blue[900],
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              textScaleFactor: 1.5)),
                                    )
                                  : Text(''),
                          ],
                        )
                    ],
                  ),
                ),
                if (model.userIsDoctor)
                  TextButton(
                    onPressed: () => model.addExam(),
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
                          "Add",
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
        ),
      ),
    );
  }
}
