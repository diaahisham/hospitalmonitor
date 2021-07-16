import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/all_patients_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class AllPatientsView extends StatelessWidget {
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
    return Provider<AllPatientsViewModel>(
      create: (context) => AllPatientsViewModel(),
      child: Consumer<AllPatientsViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('All patients'),
          bottomNavigationBar: UserNavigationBar(),
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
                        initialValue: '',
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
                  valueListenable: model.searchValue,
                  builder: (context, value, child) => Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
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
                              "National ID",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Name",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Age",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Gender",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < model.patients.length; i++)
                        if (model.isRowVisible(model.patients[i].nationalID))
                          TableRow(
                            decoration: BoxDecoration(
                              color: model.rowColor(),
                            ),
                            children: [
                              TextButton(
                                onPressed: () =>
                                    model.viewPatient(model.patients[i]),
                                child: Center(
                                    child: Text(model.patients[i].nationalID,
                                        textScaleFactor: 1.5)),
                              ),
                              TextButton(
                                onPressed: () =>
                                    model.viewPatient(model.patients[i]),
                                child: Center(
                                    child: Text(model.patients[i].userName,
                                        textScaleFactor: 1.5)),
                              ),
                              Center(
                                  child: Text(model.patients[i].age.toString(),
                                      textScaleFactor: 1.5)),
                              Center(
                                  child: Text(
                                      model.patients[i].genderType
                                          .toString()
                                          .substring(11),
                                      textScaleFactor: 1.5)),
                            ],
                          ),
                    ],
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
