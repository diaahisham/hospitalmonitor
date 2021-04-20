import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/profile_viewModel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Provider(
      create: (BuildContext context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
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
          backgroundColor: Colors.blue[100],
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  child: Image.asset(
                    'assets/hospital.png',
                    fit: BoxFit.contain,
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
