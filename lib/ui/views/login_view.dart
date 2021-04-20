import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/view_models/login_viewModel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Provider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Welcome ' + model.title)),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  child: Image.asset(
                    'assets/loginBackground.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 250,
                          height: 50,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter user name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            autofocus: true,
                            onChanged: (value) => model.user.userName = value,
                            decoration: InputDecoration(
                              labelText: 'username: ',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.all(10),
                          width: 250,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            onChanged: (value) => model.user.password = value,
                            decoration: InputDecoration(
                              labelText: 'password: ',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => model.submitLogin(),
                          child: Container(
                            height: 50,
                            width: 250,
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
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: model.wrongCredentialsText,
                              builder: (context, value, child) => Text(
                                model.wrongCredentialsText.value,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
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
