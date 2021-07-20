import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/examination_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class ExaminationView extends StatelessWidget {
  Widget _dataField({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(1),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _dataField(
                      child: TextFormField(
                        //initialValue: '',
                        controller: TextEditingController(text: ''),
                        keyboardType: TextInputType.name,
                        onChanged: (value) => model.searchValueChange(value),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          contentPadding: const EdgeInsets.all(0.0),
                        ),
                      ),
                    )
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: model.examsLength,
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
                            Center(
                                child: Text(
                              "Doctor name",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Date",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            // Center(
                            //     child: Text(
                            //   "Symptoms",
                            //   textScaleFactor: 1.5,
                            //   style: TextStyle(color: Colors.white),
                            // )),
                            // Center(
                            //     child: Text(
                            //   "Description",
                            //   textScaleFactor: 1.5,
                            //   style: TextStyle(color: Colors.white),
                            // )),
                            Center(
                                child: Text(
                              "Disease",
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
                            Center(
                                child: Text(
                              "More info",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                          ]),
                      for (int i = 0; i < model.examModels.length; i++)
                        if (model.isRowVisible(model.examModels[i].doctorName))
                          TableRow(
                            decoration: BoxDecoration(
                              color: model.rowColor(),
                            ),
                            children: [
                              Center(
                                  child: Text(model.examModels[i].doctorName,
                                      textScaleFactor: 1.5)),
                              Center(
                                  child: Text(
                                      model.examModels[i].date.substring(0, 10),
                                      textScaleFactor: 1.5)),
                              // Center(
                              //     child: Text(model.examModels[i].symptoms,
                              //         textScaleFactor: 1.5)),
                              // Center(
                              //     child: Text(model.examModels[i].description,
                              //         textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.examModels[i].disease,
                                      textScaleFactor: 1.5)),
                              if (model.userIsDoctor)
                                (model.user.userID ==
                                        model.examModels[i].doctorID)
                                    ? TextButton(
                                        onPressed: () =>
                                            model.editExam(model.examModels[i]),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            size: 25,
                                          ),
                                        ),
                                      )
                                    : Text(''),
                              if (model.userIsDoctor)
                                (model.user.userID ==
                                        model.examModels[i].doctorID)
                                    ? TextButton(
                                        onPressed: () => model
                                            .deleteExam(model.examModels[i]),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            size: 25,
                                          ),
                                        ),
                                      )
                                    : Text(''),
                              TextButton(
                                onPressed: () =>
                                    model.showMore(model.examModels[i]),
                                child: Center(
                                  child: Icon(
                                    Icons.more_horiz,
                                    size: 25,
                                  ),
                                ),
                              ),
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
