import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/all_patients_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class AllPatientsView extends StatelessWidget {
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
                Table(
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
                      TableRow(
                        decoration: BoxDecoration(
                            color:
                                (i % 2 == 1) ? Colors.grey[350] : Colors.white),
                        children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
