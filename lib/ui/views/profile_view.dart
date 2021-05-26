import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/profile_viewModel.dart';
import 'package:hospitalmonitor/ui/widgets/user_app_bar.dart';
import 'package:hospitalmonitor/ui/widgets/user_navigation_bar.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  Widget _labelWidget(String label) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        label + ': ',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dataField({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 250,
      height: 30,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // String buttonText = userType.toString().replaceAll('UserType.', '');
    // buttonText =
    //     buttonText.replaceFirst(buttonText[0], buttonText[0].toUpperCase());
    return WillPopScope(
      onWillPop: () async => false,
      child: Provider(
        create: (BuildContext context) => ProfileViewModel(),
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) => Scaffold(
            appBar: UserAppbar('Profile'),
            bottomNavigationBar: UserNavigationBar(),
            backgroundColor: Colors.blue[100],
            body: Container(
              width: screenWidth,
              height: screenHeight,
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ValueListenableBuilder(
                      valueListenable: model.edittingMode,
                      builder: (context, value, child) => ListView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        children: [
                          Form(
                            key: model.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelWidget('User name'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue:
                                              model.currentUser.userName,
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
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.userName,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                //
                                _labelWidget('Gender'),
                                (model.edittingMode.value)
                                    ? Container(
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
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.genderType
                                              .toString()
                                              .substring(11),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                //password
                                if (model.edittingMode.value)
                                  _labelWidget('Password'),
                                if (model.edittingMode.value)
                                  _dataField(
                                    child: TextFormField(
                                      initialValue: model.currentUser.password,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      keyboardType: TextInputType.name,
                                      autofocus: true,
                                      onChanged: (value) =>
                                          model.currentUser.password = value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                // Age
                                _labelWidget('Age'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue:
                                              model.currentUser.age.toString(),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter age';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) => model
                                              .currentUser.mobileNumber = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.age.toString(),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                //

                                // National ID
                                _labelWidget('National ID'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue:
                                              model.currentUser.nationalID,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter national id';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) => model
                                              .currentUser.nationalID = value,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.nationalID,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                //
                                _labelWidget('MobileNumber'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue:
                                              model.currentUser.mobileNumber,
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
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.mobileNumber,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                _labelWidget('Email'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue: model.currentUser.email,
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
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.email,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                _labelWidget('Address'),
                                (model.edittingMode.value)
                                    ? _dataField(
                                        child: TextFormField(
                                          initialValue:
                                              model.currentUser.address,
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
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          model.currentUser.address,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                _labelWidget('User Type'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    model.getUserTypeAsString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () => model.submitEditting(),
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
                                              offset: Offset(0.0, 1.0), //(x,y)
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
                                    if (model.edittingMode.value)
                                      TextButton(
                                        onPressed: () => model.cancelEditting(),
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
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Image.memory(
                            base64Decode(model.currentUser.photo),
                            scale: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: () => model.changePicture(),
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
                                'Change picture',
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
