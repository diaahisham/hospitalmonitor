import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/profile_viewModel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  Widget _labelWidget(String label) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        label + ' :',
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
    return Provider(
      create: (BuildContext context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('User profile data'),
            actions: [
              GestureDetector(
                onTap: () => model.logout(),
                child: Container(
                  height: 50,
                  width: 100,
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
                      'Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.blue,
            height: 70,
          ),
          backgroundColor: Colors.blue[100],
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ValueListenableBuilder(
                    valueListenable: model.edittingMode,
                    builder: (context, value, child) => Form(
                      key: model.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _labelWidget('User name'),
                          (model.edittingMode.value)
                              ? _dataField(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter user name';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    autofocus: true,
                                    onChanged: (value) =>
                                        model.newUser.userName = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    model.currentUser.userName,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                          _labelWidget('MobileNumber'),
                          (model.edittingMode.value)
                              ? _dataField(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter mobile number';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) =>
                                        model.newUser.mobileNumber = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter valid email';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) =>
                                        model.newUser.email = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) =>
                                        model.newUser.address = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
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
                          (model.edittingMode.value)
                              ? _dataField(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) =>
                                        model.newUser.address = value,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              : Padding(
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
                        ],
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: HtmlElementView(
                //     viewType:
                //         '<img src="https://craftassets-prod.s3.amazonaws.com/Blog/_thumbnail/Know-About-Becoming-a-Doctor.png" alt="Italian Trulli">',
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
