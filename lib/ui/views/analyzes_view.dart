import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hospitalmonitor/business_logic/view_models/analyzes_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class AnalyzesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AnalyzesViewModel>(
      create: (context) => AnalyzesViewModel(),
      child: Consumer<AnalyzesViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Analyzes'),
          bottomNavigationBar: UserNavigationBar(),
          backgroundColor: Colors.blue[100],
          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              children: [
                ValueListenableBuilder(
                  valueListenable: model.analysesLength,
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
                            if (!model.userIsAnalysit)
                              Center(
                                  child: Text(
                                "Analyst name",
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
                        TableRow(
                          decoration: BoxDecoration(
                              color: (i % 2 == 1)
                                  ? Colors.grey[350]
                                  : Colors.white),
                          children: [
                            if (!model.userIsAnalysit)
                              Center(
                                  child: Text(
                                      model.analysisModels[i].analystName,
                                      textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.analysisModels[i].patientName,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.analysisModels[i].date,
                                    textScaleFactor: 1.5)),
                            Center(
                                child: Text(model.analysisModels[i].labName,
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
                                onPressed: () =>
                                    model.editAnalysis(model.analysisModels[i]),
                                child: Center(
                                    child: Text("Edit",
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.underline,
                                        ),
                                        textScaleFactor: 1.5)),
                              ),
                            if (model.userIsAnalysit)
                              TextButton(
                                onPressed: () => model
                                    .deleteAnalysis(model.analysisModels[i]),
                                child: Center(
                                    child: Text("Delete",
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          decoration: TextDecoration.underline,
                                        ),
                                        textScaleFactor: 1.5)),
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
