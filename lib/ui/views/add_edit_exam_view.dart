import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:hospitalmonitor/business_logic/view_models/add_edit_exam_viewModel.dart';

class AddEditExamView extends StatelessWidget {
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
        initialValue: initialValue,
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
    Widget _dataField({required Widget child}) {
      return Container(
        padding: EdgeInsets.all(10),
        width: 200,
        height: 40,
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

    return Provider<AddEditExamViewModel>(
      create: (context) => AddEditExamViewModel(),
      child: Consumer<AddEditExamViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Examination Form'),
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
                              child: Text((model.currentEdittingExamination
                                          .patientName ==
                                      '')
                                  ? 'Choose patient'
                                  : model
                                      .currentEdittingExamination.patientName),
                            ),
                          ),
                        ),
                      ),
                      _formWidget(
                        initialValue: model.currentEdittingExamination.symptoms,
                        validatorText: 'Please enter Symptoms',
                        labelText: 'Symptoms: ',
                        onChanged: (value) =>
                            model.currentEdittingExamination.symptoms = value,
                      ),
                      _formWidget(
                        initialValue: model.currentEdittingExamination.symptoms,
                        validatorText: 'Please enter Disease',
                        labelText: 'Disease: ',
                        onChanged: (value) =>
                            model.currentEdittingExamination.disease = value,
                      ),
                      _formWidget(
                        initialValue:
                            model.currentEdittingExamination.description,
                        validatorText: 'Please enter result',
                        labelText: 'Result: ',
                        onChanged: (value) => model
                            .currentEdittingExamination.description = value,
                      ),
                      // ******** //
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Vaccination: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffEA5B0C),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: model.drugLength,
                        builder: (context, value, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i <
                                    model.currentEdittingExamination.drugs
                                        .length;
                                i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _dataField(
                                    child: TextFormField(
                                      initialValue: model
                                          .currentEdittingExamination.drugs[i],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Drug';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                      autofocus: true,
                                      onChanged: (value) => model
                                          .currentEdittingExamination
                                          .drugs[i] = value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () => model.removeDrug(i),
                                    ),
                                  )
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _dataField(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Drug';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    onChanged: (value) => model.newDrug = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(),
                                  clipBehavior: Clip.none,
                                  onPressed: () => model.addDrug(model.newDrug),
                                  child: Container(
                                    height: 40,
                                    width: 75,
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
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // DeleteButton
                TextButton(
                  onPressed: () => model.deleteExam(),
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
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
