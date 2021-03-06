import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/profile_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class UpdatedProfileView extends StatelessWidget {
  Widget _labelWidget(String label) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftSideItem(String title, int index, ProfileViewModel model) {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      color: (index == model.widgetNo) ? Colors.blue[100] : Colors.white,
      child: TextButton(
        onPressed: () => model.changePicture(),
        child: Text(title),
      ),
    );
  }

  Widget _dataField({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(1),
      width: 250,
      height: 42,
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

  Widget _lineSeprator(double width) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: width,
        height: 1,
        color: Colors.black,
      ),
    );
  }

  Widget personalInfo(ProfileViewModel model, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // name row
                infoColOne("Name:    ", model.currentUser.userName),
                //age row
                infoColOne("Age:        ", model.currentUser.age.toString()),
                // Gender row
                infoColOne("Gender:  ",
                    model.currentUser.genderType.toString().substring(11)),
              ],
            ),
            Container(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // national ID
                infoColOne("National ID:       ", model.currentUser.nationalID),
                // phone Row
                infoColOne(
                    "Mobile:               ", model.currentUser.mobileNumber),
                TextButton(
                    onPressed: () => model.edittingMode.value = true,
                    child: Text("Edit"))
              ],
            )
          ],
        ),
        _lineSeprator(screenWidth)
      ],
    );
  }

  Widget infoColOne(String label, String info) {
    return Row(children: [
      Text(
        label,
        style: TextStyle(color: Color(0xffEA5B0C)),
      ),
      Text(info)
    ]);
  }
//

  Widget patientVitalModifiers(ProfileViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingMode,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Vital modifiers: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffEA5B0C),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //blood pressure
                  _labelWidget('Blood pressure: '),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      model.reportModel.bloodPressure.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  //
                  //blood Type
                  _labelWidget('Blood type: '),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      model.reportModel.bloodType,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  //
                ],
              ),
              Container(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //diabetes Rate
                  _labelWidget('Diabetes rate: '),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      model.reportModel.diabetesRate.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  //
                  // breathing Rate
                  _labelWidget('Breathing rate: '),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      model.reportModel.breathingRate.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  //
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget chronicDiseases(ProfileViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Chronic diseases: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffEA5B0C),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < model.reportModel.chronicDiseases.length; i++)
              _labelWidget(' => ' + model.reportModel.chronicDiseases[i]),
          ],
        ),
      ],
    );
  }

  Widget dangerDiseases(ProfileViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Danger diseases & Surgiries: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffEA5B0C),
            ),
          ),
        ),
        for (int i = 0; i < model.reportModel.dangerDiseases.length; i++)
          _labelWidget(' => ' + model.reportModel.dangerDiseases[i]),
      ],
    );
  }

  Widget senstivitiesDiseases(ProfileViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            'Senstivities: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffEA5B0C),
            ),
          ),
        ),

        for (int i = 0; i < model.reportModel.sensitivities.length; i++)
          _labelWidget(' => ' + model.reportModel.sensitivities[i]),
        //
      ],
    );
  }

  Widget vaccinationsDiseases(ProfileViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        for (int i = 0; i < model.reportModel.vaccinations.length; i++)
          _labelWidget(' => ' + model.reportModel.vaccinations[i]),
        //
        // add
      ],
    );
  }

  Widget nonPatientDayDates(ProfileViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingDayDates,
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Working hours: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffEA5B0C),
              ),
            ),
          ),
          (!model.edittingDayDates.value)
              ? Table(
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
                              "Day",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "From",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "To",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                    for (int i = 0; i < model.currentUser.dayDates.length; i++)
                      TableRow(
                        decoration: BoxDecoration(
                          color: model.rowColor(i),
                        ),
                        children: [
                          Center(
                              child: Text(model.currentUser.dayDates[i].dayName,
                                  textScaleFactor: 1.5)),
                          Center(
                              child: Text(
                                  model.currentUser.dayDates[i].fromHour,
                                  textScaleFactor: 1.5)),
                          Center(
                              child: Text(model.currentUser.dayDates[i].toHour,
                                  textScaleFactor: 1.5)),
                        ],
                      ),
                  ],
                )
              : ValueListenableBuilder(
                  valueListenable: model.dayDatesListLength,
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < model.currentUser.dayDates.length;
                          i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Day
                            _dataField(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text:
                                        model.currentUser.dayDates[i].dayName),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Day';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) => model
                                    .currentUser.dayDates[i].dayName = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0.0),
                                ),
                              ),
                            ),
                            // From
                            _dataField(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text:
                                        model.currentUser.dayDates[i].fromHour),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Hour';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) => model
                                    .currentUser.dayDates[i].fromHour = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0.0),
                                ),
                              ),
                            ),
                            // To
                            _dataField(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: model.currentUser.dayDates[i].toHour),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Hour';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) => model
                                    .currentUser.dayDates[i].toHour = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => model.removeDayDate(i),
                              ),
                            ),
                          ],
                        ),
                      // Add new Day date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Day
                          _dataField(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: model.newDayDates.dayName),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Day';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              onChanged: (value) =>
                                  model.newDayDates.dayName = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(0.0),
                              ),
                            ),
                          ),
                          // From
                          _dataField(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: model.newDayDates.fromHour),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Hour';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              onChanged: (value) =>
                                  model.newDayDates.fromHour = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(0.0),
                              ),
                            ),
                          ),
                          // To
                          _dataField(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: model.newDayDates.toHour),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Hour';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              autofocus: true,
                              onChanged: (value) =>
                                  model.newDayDates.toHour = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(0.0),
                              ),
                            ),
                          ),
                          // add Button
                          TextButton(
                            style: ButtonStyle(),
                            clipBehavior: Clip.none,
                            onPressed: () => model.addDayDate(),
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
                      )
                    ],
                  ),
                ),
          Row(
            children: [
              // submit Button
              TextButton(
                onPressed: () => model.submitEditDayDates(),
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
                      (model.edittingMode.value) ? "Done" : "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              // cancel Button
              if (model.edittingDayDates.value)
                TextButton(
                  onPressed: () => model.cancelEditting(),
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
        ],
      ),
    );
  }

//
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Provider(
        create: (BuildContext context) => ProfileViewModel(),
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) => Scaffold(
            appBar: UserAppbar('Profile'),
            bottomNavigationBar: UserNavigationBar(),
            backgroundColor: Colors.white,
            body: Container(
              child: Row(
                children: [
                  // image column
                  Container(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            padding: EdgeInsets.all(20),
                            child: Image.memory(
                              base64Decode(model.currentUser.photo),
                              scale: 1,
                            ),
                          ),
                        ),
                        //leftSideItem('Change picture', 0, model),
                      ],
                    ),
                  ),
                  // data Column
                  ValueListenableBuilder(
                    valueListenable: model.edittingMode,
                    builder: (context, value, child) => Container(
                      width: screenWidth - 200,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
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
                      child: ListView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        children: [
                          personalInfo(model, screenWidth),
                          (model.edittingMode.value)
                              ? Form(
                                  key: model.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _labelWidget('User name'),

                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model.currentUser.userName),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter user name';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          autofocus: true,
                                          onChanged: (value) => model
                                              .currentUser.userName = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),

                                      //
                                      _labelWidget('Gender'),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 250,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0.0, 1.0), //(x,y)
                                              blurRadius: 6.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                        ),
                                        child: ValueListenableBuilder(
                                          valueListenable:
                                              model.genderTypeIndex,
                                          builder: (context, value, child) =>
                                              DropdownButton<GenderTypesList>(
                                            hint: Text('Please choose gender'),
                                            isExpanded: true,
                                            value: model.currentGenderType,
                                            onChanged: (value) => (value !=
                                                    null)
                                                ? model
                                                    .changeGender(value.index)
                                                : model.changeGender(1),
                                            items: model.genderTypes
                                                .map<
                                                        DropdownMenuItem<
                                                            GenderTypesList>>(
                                                    (e) => DropdownMenuItem(
                                                          child: Text(e.type),
                                                          value: e,
                                                        ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                      //password

                                      _labelWidget('Password'),

                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model.currentUser.password),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter password';
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          keyboardType: TextInputType.name,
                                          autofocus: true,
                                          onChanged: (value) => model
                                              .currentUser.password = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),
                                      // Age
                                      _labelWidget('Age'),

                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model.currentUser.age
                                                  .toString()),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter age';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) => model
                                              .currentUser
                                              .age = int.parse(value),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),
                                      //
                                      _labelWidget('MobileNumber'),
                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model
                                                  .currentUser.mobileNumber),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter mobile number';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) => model
                                              .currentUser.mobileNumber = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),
                                      _labelWidget('Email'),
                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model.currentUser.email),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter valid email';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          onChanged: (value) =>
                                              model.currentUser.email = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),
                                      _labelWidget('Address'),
                                      _dataField(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: model.currentUser.address),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter address';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          onChanged: (value) =>
                                              model.currentUser.address = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          // submit Button
                                          TextButton(
                                            onPressed: () =>
                                                model.submitEditting(),
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xffEA5B0C),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                        0.0, 1.0), //(x,y)
                                                    blurRadius: 6.0,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  (model.edittingMode.value)
                                                      ? "Done"
                                                      : "Edit",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // cancel Button
                                          TextButton(
                                            onPressed: () =>
                                                model.cancelEditting(),
                                            child: Container(
                                              height: 50,
                                              width: 200,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xffEA5B0C),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                        0.0, 1.0), //(x,y)
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
                                    ],
                                  ),
                                )
                              : (model.currentUser.type == UserType.patient)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        patientVitalModifiers(model),
                                        _lineSeprator(screenWidth),
                                        chronicDiseases(model),
                                        _lineSeprator(screenWidth),
                                        dangerDiseases(model),
                                        _lineSeprator(screenWidth),
                                        senstivitiesDiseases(model),
                                        _lineSeprator(screenWidth),
                                        vaccinationsDiseases(model),
                                      ],
                                    )
                                  : nonPatientDayDates(model),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
