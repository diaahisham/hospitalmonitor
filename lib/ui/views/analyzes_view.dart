import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/analyzes_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class AnalyzesView extends StatelessWidget {
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
    return Provider<AnalyzesViewModel>(
      create: (context) => AnalyzesViewModel(),
      child: Consumer<AnalyzesViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: (model.loggedUserType != UserType.doctor)
              ? UserAppbar('Analyzes')
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
                        ),
                      ),
                    )
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: model.analysesLength,
                  builder: (context, value, child) => Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1),
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
                            if (model.userIsAnalysit)
                              Center(
                                  child: Text(
                                "Patient name",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            Center(
                                child: Text(
                              "Analysis name",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            Center(
                                child: Text(
                              "Date",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            )),
                            if (!model.userIsAnalysit)
                              Center(
                                  child: Text(
                                "Analyst name",
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
                            if (model.userIsAnalysit)
                              Center(
                                  child: Text(
                                "Edit",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                            if (model.userIsAnalysit)
                              Center(
                                  child: Text(
                                "Delete",
                                textScaleFactor: 1.5,
                                style: TextStyle(color: Colors.white),
                              )),
                          ]),
                      for (int i = 0; i < model.analysisModels.length; i++)
                        if (model.isRowVisible(model.analysisModels[i]))
                          TableRow(
                            decoration: BoxDecoration(
                              color: model.rowColor(),
                            ),
                            children: [
                              if (model.userIsAnalysit)
                                Center(
                                    child: Text(
                                        model.analysisModels[i].patientName,
                                        textScaleFactor: 1.5)),
                              Center(
                                  child: Text(
                                      model.analysisModels[i].analysisName,
                                      textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.analysisModels[i].date,
                                      textScaleFactor: 1.5)),
                              if (!model.userIsAnalysit)
                                Center(
                                    child: Text(
                                        model.analysisModels[i].analystName,
                                        textScaleFactor: 1.5)),
                              Center(
                                  child: Text(model.analysisModels[i].notes,
                                      textScaleFactor: 1.5)),
                              TextButton(
                                onPressed: () => model.launchInBrowser(
                                    model.analysisModels[i].analysisUrl),
                                child: Center(
                                    child: Text(
                                        model.analysisModels[i].analysisUrl,
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.underline,
                                        ),
                                        textScaleFactor: 1.5)),
                              ),
                              if (model.userIsAnalysit)
                                TextButton(
                                  onPressed: () => model
                                      .editAnalysis(model.analysisModels[i]),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              if (model.userIsAnalysit)
                                TextButton(
                                  onPressed: () => model
                                      .deleteAnalysis(model.analysisModels[i]),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      size: 25,
                                    ),
                                  ),
                                ),
                            ],
                          )
                    ],
                  ),
                ),
                if (model.userIsAnalysit)
                  TextButton(
                    onPressed: () => model.addAnalysis(),
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
