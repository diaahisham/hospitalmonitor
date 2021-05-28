import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/radios_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class RadiosView extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Provider<RadiosviewModel>(
      create: (context) => RadiosviewModel(),
      child: Consumer<RadiosviewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: (model.loggedUserType != UserType.doctor)
              ? UserAppbar('Radios')
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
                        initialValue: '',
                        keyboardType: TextInputType.name,
                        onChanged: (value) => model.searchValueChange(value),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    )
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: model.radiosLength,
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
                            if (!model.userIsRadiologist)
                              Center(
                                  child: Text(
                                "Radiologist name",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            if (model.userIsRadiologist)
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
                              "Lab name",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Notes",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Url",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            if (model.userIsRadiologist)
                              Center(
                                  child: Text(
                                "Edit",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            if (model.userIsRadiologist)
                              Center(
                                  child: Text(
                                "Delete",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                          ]),
                      for (int i = 0; i < model.radioModels.length; i++)
                        if (model.isRowVisible(model.radioModels[i]))
                          TableRow(
                            decoration: BoxDecoration(
                              color: model.rowColor(),
                            ),
                            children: [
                              if (!model.userIsRadiologist)
                                Center(
                                    child: Text(
                                        model.radioModels[i].radiologistName,
                                        textScaleFactor: 1.5)),
                              if (model.userIsRadiologist)
                                Center(
                                    child: Text(
                                        model.radioModels[i].patientName,
                                        textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.radioModels[i].date,
                                      textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.radioModels[i].labName,
                                      textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.radioModels[i].notes,
                                      textScaleFactor: 1.5)),
                              TextButton(
                                onPressed: () => model.launchInBrowser(
                                    model.radioModels[i].radioUrl),
                                child: Center(
                                    child: Text(model.radioModels[i].radioUrl,
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.underline,
                                        ),
                                        textScaleFactor: 1.5)),
                              ),
                              if (model.userIsRadiologist)
                                TextButton(
                                  onPressed: () =>
                                      model.editRadio(model.radioModels[i]),
                                  child: Center(
                                      child: Text("Edit",
                                          style: TextStyle(
                                            color: Colors.blue[900],
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          textScaleFactor: 1.5)),
                                ),
                              if (model.userIsRadiologist)
                                TextButton(
                                  onPressed: () =>
                                      model.deleteRadio(model.radioModels[i]),
                                  child: Center(
                                      child: Text("Delete",
                                          style: TextStyle(
                                            color: Colors.blue[900],
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          textScaleFactor: 1.5)),
                                ),
                            ],
                          )
                    ],
                  ),
                ),
                if (model.userIsRadiologist)
                  TextButton(
                    onPressed: () => model.addRadio(),
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
