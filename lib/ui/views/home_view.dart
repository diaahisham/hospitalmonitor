import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/view_models/home_viewModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  Widget _userLoginButton(UserType userType, HomeViewModel model) {
    String buttonText = userType.toString().replaceAll('UserType.', '');
    buttonText =
        buttonText.replaceFirst(buttonText[0], buttonText[0].toUpperCase());

    return TextButton(
      onPressed: () => model.goToLoginPage(userType),
      child: Container(
        height: 50,
        width: 130,
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
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
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
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
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
                _userLoginButton(UserType.doctor, model),
                _userLoginButton(UserType.patient, model),
                _userLoginButton(UserType.analyst, model),
                _userLoginButton(UserType.radiologist, model),
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
      ),
    );
  }
}
