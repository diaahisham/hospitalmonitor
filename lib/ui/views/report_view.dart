import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/report_viewModes.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class ReportView extends StatelessWidget {
  Widget _labelWidget(String label) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dataField({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(1),
      width: 200,
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

  Widget leftSideItem(String title, int index, ReportViewModel model) {
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      color: (index == model.widgetNo) ? Colors.blue[100] : Colors.white,
      child: TextButton(
        onPressed: () => model.widgetNO = index,
        child: Text(title),
      ),
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

  Widget lineSeprator(double width) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: width,
        height: 1,
        color: Colors.black,
      ),
    );
  }

  Widget patientPersonalInfo(ReportViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // name row
            infoColOne("Name:    ", model.currentPatient.userName),
            //age row
            infoColOne("Age:        ", model.currentPatient.age.toString()),
            // Gender row
            infoColOne("Gender:  ",
                model.currentPatient.genderType.toString().substring(11)),
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
            infoColOne("National ID:       ", model.currentPatient.nationalID),
            // phone Row
            infoColOne(
                "Mobile:               ", model.currentPatient.mobileNumber),
          ],
        )
      ],
    );
  }

  Widget patientVitalModifiers(ReportViewModel model) {
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
                  (model.edittingMode.value)
                      ? _dataField(
                          child: TextFormField(
                            controller: TextEditingController(
                                text:
                                    model.reportModel.bloodPressure.toString()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter blood pressure';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            onChanged: (value) => model
                                .reportModel.bloodPressure = int.parse(value),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0.0),
                            ),
                          ),
                        )
                      : Padding(
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

                  //diabetes Rate
                  _labelWidget('Diabetes rate: '),
                  (model.edittingMode.value)
                      ? _dataField(
                          child: TextFormField(
                            controller: TextEditingController(
                                text:
                                    model.reportModel.diabetesRate.toString()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter diabetes Rate';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            onChanged: (value) => model
                                .reportModel.diabetesRate = int.parse(value),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0.0),
                            ),
                          ),
                        )
                      : Padding(
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
                ],
              ),
              Container(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _labelWidget('Blood type: '),
                  (model.edittingMode.value)
                      ? _dataField(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: model.reportModel.bloodType,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter blood type';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            autofocus: true,
                            onChanged: (value) =>
                                model.reportModel.bloodType = value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0.0),
                            ),
                          ),
                        )
                      : Padding(
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
                  // breathing Rate
                  _labelWidget('Breathing rate: '),
                  (model.edittingMode.value)
                      ? _dataField(
                          child: TextFormField(
                            controller: TextEditingController(
                                text:
                                    model.reportModel.breathingRate.toString()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter breathing Rate';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            onChanged: (value) => model
                                .reportModel.breathingRate = int.parse(value),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(0.0),
                            ),
                          ),
                        )
                      : Padding(
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

  Widget chronicDiseases(ReportViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingMode,
      builder: (context, value, child) => Column(
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
          ValueListenableBuilder(
            valueListenable: model.chronicDiseasesLength,
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < model.reportModel.chronicDiseases.length;
                    i++)
                  (model.edittingMode.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _dataField(
                              child: TextFormField(
                                // initialValue:
                                //     model.reportModel.chronicDiseases[i],
                                controller: TextEditingController(
                                    text: model.reportModel.chronicDiseases[i]),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter disease';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) => model
                                    .reportModel.chronicDiseases[i] = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => model.removeChronicDisease(i),
                              ),
                            )
                          ],
                        )
                      : _labelWidget(
                          ' => ' + model.reportModel.chronicDiseases[i]),
                //
                // add
                if (model.edittingMode.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dataField(
                        child: TextFormField(
                          //controller: TextEditingController(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter disease';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          onChanged: (value) => model.newChronicDisease = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0.0),
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(),
                        clipBehavior: Clip.none,
                        onPressed: () =>
                            model.addChronicDisease(model.newChronicDisease),
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
    );
  }

  Widget dangerDiseases(ReportViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingMode,
      builder: (context, value, child) => Column(
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
          ValueListenableBuilder(
            valueListenable: model.dangerDiseasesLength,
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0;
                    i < model.reportModel.dangerDiseases.length;
                    i++)
                  (model.edittingMode.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _dataField(
                              child: TextFormField(
                                // initialValue:
                                //     model.reportModel.dangerDiseases[i],
                                controller: TextEditingController(
                                    text: model.reportModel.dangerDiseases[i]),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter disease';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) =>
                                    model.reportModel.dangerDiseases[i] = value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(0.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => model.removeDangerDisease(i),
                              ),
                            )
                          ],
                        )
                      : _labelWidget(
                          ' => ' + model.reportModel.dangerDiseases[i]),
                //
                // add
                if (model.edittingMode.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dataField(
                        child: TextFormField(
                          //controller: TextEditingController(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter disease';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          onChanged: (value) => model.newDangerDisease = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0.0),
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(),
                        clipBehavior: Clip.none,
                        onPressed: () =>
                            model.addDangerDisease(model.newDangerDisease),
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
    );
  }

  Widget senstivitiesDiseases(ReportViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingMode,
      builder: (context, value, child) => Column(
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
          ValueListenableBuilder(
            valueListenable: model.senstivitiesLength,
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < model.reportModel.sensitivities.length; i++)
                  (model.edittingMode.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _dataField(
                              child: TextFormField(
                                // initialValue:
                                //     model.reportModel.sensitivities[i],
                                controller: TextEditingController(
                                    text: model.reportModel.sensitivities[i]),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter disease';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) =>
                                    model.reportModel.dangerDiseases[i] = value,
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
                                onPressed: () => model.removeSenstivity(i),
                              ),
                            )
                          ],
                        )
                      : _labelWidget(
                          ' => ' + model.reportModel.sensitivities[i]),
                //
                // add
                if (model.edittingMode.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dataField(
                        child: TextFormField(
                          // controller: TextEditingController(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Sensetivity';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          onChanged: (value) => model.newSensetivity = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0.0),
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(),
                        clipBehavior: Clip.none,
                        onPressed: () =>
                            model.addSenstivity(model.newSensetivity),
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
    );
  }

  Widget vaccinationsDiseases(ReportViewModel model) {
    return ValueListenableBuilder(
      valueListenable: model.edittingMode,
      builder: (context, value, child) => Column(
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
          ValueListenableBuilder(
            valueListenable: model.vaccinationsLength,
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < model.reportModel.vaccinations.length; i++)
                  (model.edittingMode.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _dataField(
                              child: TextFormField(
                                //initialValue: model.reportModel.vaccinations[i],
                                controller: TextEditingController(
                                    text: model.reportModel.vaccinations[i]),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Vaccination';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                onChanged: (value) =>
                                    model.reportModel.vaccinations[i] = value,
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
                                onPressed: () => model.removevaccinations(i),
                              ),
                            )
                          ],
                        )
                      : _labelWidget(
                          ' => ' + model.reportModel.vaccinations[i]),
                //
                // add
                if (model.edittingMode.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _dataField(
                        child: TextFormField(
                          // controller: TextEditingController(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Vaccination';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          autofocus: true,
                          onChanged: (value) => model.newVaccination = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0.0),
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(),
                        clipBehavior: Clip.none,
                        onPressed: () =>
                            model.addvaccination(model.newVaccination),
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
    );
  }

  Widget reportWidget(ReportViewModel model, BuildContext context) {
    double width = MediaQuery.of(context).size.width - 200;
    return Container(
      width: width,
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
          patientPersonalInfo(model),
          lineSeprator(width),
          patientVitalModifiers(model),
          lineSeprator(width),
          chronicDiseases(model),
          lineSeprator(width),
          dangerDiseases(model),
          lineSeprator(width),
          senstivitiesDiseases(model),
          lineSeprator(width),
          vaccinationsDiseases(model),
          if (model.userIsDoctor)
            ValueListenableBuilder(
              valueListenable: model.edittingMode,
              builder: (context, value, child) => Row(
                children: [
                  TextButton(
                    onPressed: () => model.submitEditting(),
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
                  if (model.edittingMode.value)
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
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Provider<ReportViewModel>(
      create: (context) => ReportViewModel(),
      child: Consumer<ReportViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: UserAppbar('Patient Profile'),
          bottomNavigationBar: UserNavigationBar(),
          backgroundColor: Colors.white,
          body: Container(
            child: Row(
              children: [
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
                            base64Decode(
                              model.currentPatient.photo,
                            ),
                            scale: 1,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (model.userIsDoctor)
                        ValueListenableBuilder(
                          valueListenable: model.currentWidgetNumber,
                          builder: (context, value, child) => Column(
                            children: [
                              leftSideItem('Profile', 0, model),
                              leftSideItem('Analyzes', 1, model),
                              leftSideItem('Radios', 2, model),
                              leftSideItem('Examinations', 3, model),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: model.currentWidgetNumber,
                  builder: (context, value, child) => Container(
                      width: width - 200,
                      child:
                          model.viewWidget() ?? reportWidget(model, context)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
