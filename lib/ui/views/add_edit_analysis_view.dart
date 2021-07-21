import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/add_edit_analysis_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:provider/provider.dart';

class AddEditAnalysisView extends StatelessWidget {
  Widget _formWidget(
      {required initialValue,
      required String validatorText,
      required void Function(String) onChanged,
      required String labelText}) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(10),
      width: 300,
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
      child: TextFormField(
        controller: TextEditingController(text: initialValue),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AddEditAnalysisViewModel>(
      create: (context) => AddEditAnalysisViewModel(),
      child: Consumer<AddEditAnalysisViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Analysis Form'),
          backgroundColor: Colors.blue[100],
          body: Center(
            child: ListView(
              children: [
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // patient
                      ValueListenableBuilder(
                        valueListenable: model.patientName,
                        builder: (context, value, child) => TextButton(
                          onPressed: () => model.choosePatient(),
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(10),
                            width: 300,
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
                            child: Center(
                              child: Text((model.currentEdittingAnalysis
                                          .patientName ==
                                      '')
                                  ? 'Choose patient'
                                  : model.currentEdittingAnalysis.patientName),
                            ),
                          ),
                        ),
                      ),
                      _formWidget(
                        initialValue:
                            model.currentEdittingAnalysis.analysisName,
                        validatorText: 'Please enter analysis name',
                        labelText: 'analysis name: ',
                        onChanged: (value) =>
                            model.currentEdittingAnalysis.analysisName = value,
                      ),
                      _formWidget(
                        initialValue: model.currentEdittingAnalysis.notes,
                        validatorText: 'Please enter notes',
                        labelText: 'Notes: ',
                        onChanged: (value) =>
                            model.currentEdittingAnalysis.notes = value,
                      ),
                      _formWidget(
                        initialValue: model.currentEdittingAnalysis.analysisUrl,
                        validatorText: 'Please enter url',
                        labelText: 'Radio url: ',
                        onChanged: (value) =>
                            model.currentEdittingAnalysis.analysisUrl = value,
                      ),
                    ],
                  ),
                ),
                // Submit Button
                TextButton(
                  onPressed: () => model.submit(),
                  child: Container(
                    height: 50,
                    width: 300,
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
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                //cancel button
                TextButton(
                  onPressed: () => model.cancel(),
                  child: Container(
                    height: 50,
                    width: 300,
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
          ),
        ),
      ),
    );
  }
}
