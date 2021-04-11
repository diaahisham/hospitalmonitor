import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/buisness_logic/view_models/home_viewModel.dart';
import 'package:provider/provider.dart';

enum UserType { doctor, patient, radiologist, analysit }

class HomeView extends StatelessWidget {
  Widget _userLoginButton(UserType userType) {
    String buttonText = userType.toString().replaceAll('UserType.', '');
    buttonText =
        buttonText.replaceFirst(buttonText[0], buttonText[0].toUpperCase());

    // TODO: make it a GestureDetector
    return Container(
      height: 50,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Provider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Color(0xffF6FEFF),
        appBar: AppBar(
          title: Text('Hospital Monitor'),
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _userLoginButton(UserType.doctor),
              _userLoginButton(UserType.patient),
              _userLoginButton(UserType.analysit),
              _userLoginButton(UserType.radiologist),
            ],
          ),
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, model, child) => Center(
            child: Image.asset(
              'assets/doctors.jpg',
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
