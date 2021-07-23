import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/add_edit_radio_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:provider/provider.dart';

class AddEditRadioView extends StatelessWidget {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Provider<AddEditRadioViewModel>(
      create: (context) => AddEditRadioViewModel(),
      child: Consumer<AddEditRadioViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Radio Form'),
          backgroundColor: Colors.blue[100],
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                Center(
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
                                    child: Text((model.currentEdittingRadio
                                                .patientName ==
                                            '')
                                        ? 'Choose patient'
                                        : model
                                            .currentEdittingRadio.patientName),
                                  ),
                                ),
                              ),
                            ),
                            _formWidget(
                              initialValue:
                                  model.currentEdittingRadio.radioName,
                              validatorText: 'Please enter radio name',
                              labelText: 'Radio name: ',
                              onChanged: (value) =>
                                  model.currentEdittingRadio.radioName = value,
                            ),
                            _formWidget(
                              initialValue: model.currentEdittingRadio.notes,
                              validatorText: 'Please enter notes',
                              labelText: 'Notes: ',
                              onChanged: (value) =>
                                  model.currentEdittingRadio.notes = value,
                            ),
                            ValueListenableBuilder(
                              valueListenable: model.radioUrlName,
                              builder: (context, value, child) => _formWidget(
                                initialValue:
                                    model.currentEdittingRadio.radioUrl,
                                validatorText: 'Please enter url',
                                labelText: 'Analysis url: ',
                                onChanged: (value) =>
                                    model.currentEdittingRadio.radioUrl = value,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Upload file Button
                      TextButton(
                        onPressed: () => model.pickFile(),
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
                              "Upload file",
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
                ValueListenableBuilder(
                  valueListenable: model.loading,
                  builder: (context, value, child) => (model.loading.value)
                      ? Container(
                          width: screenWidth,
                          height: screenHeight,
                          color: Colors.white70,
                          child: Center(
                            child: Text(
                              "Loading...",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 35),
                            ),
                          ),
                        )
                      : Text(""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
