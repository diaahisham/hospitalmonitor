import 'dart:convert';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/analysts.dart';
import 'package:hospitalmonitor/business_logic/utils/doctors.dart';
import 'package:hospitalmonitor/business_logic/utils/patients.dart';
import 'package:hospitalmonitor/business_logic/utils/radiologists.dart';

import 'package:http/http.dart' as http;

class LoginService {
  Future<UserModel> login(UserModel userRequest) async {
    return await _checkNameAndPasswordMock(userRequest);
  }

  // ignore: unused_element
  Future<UserModel> _checkNameAndPasswordMock(UserModel userRequest) async {
    List<UserModel> tempSearch = List<UserModel>.empty(growable: true);
    switch (userRequest.type) {
      case UserType.doctor:
        tempSearch.addAll(doctors);
        break;
      case UserType.patient:
        tempSearch.addAll(patients);
        break;
      case UserType.analyst:
        tempSearch.addAll(analysts);
        break;
      case UserType.radiologist:
        tempSearch.addAll(radiologists);
        break;
      default:
        throw Exception('Wrong User Type');
    }
    UserModel testModel = tempSearch.singleWhere(
      (element) => element.userName == userRequest.userName,
      orElse: () => UserModel(),
    );
    if (testModel.userID == '' || testModel.password != userRequest.password)
      throw Exception('Wrong username or wrong password');

    return testModel;
  }

// ignore: unused_element
  // Future<UserModel> _checkNameAndPasswordHttp(UserModel userRequest) async {
  //   final String loginUri =
  //       'https://dr-health.herokuapp.com/api/doctors/authenticate';

  //   final response = await http.post(
  //     loginUri,
  //     headers: {'Content-Type': 'application/json'},
  //     body:
  //         json.encode(RequestModel(userRequest.userName, userRequest.password)),
  //   );

  //   Map<String, dynamic> body = json.decode(response.body);

  //   if (response.statusCode != 200) throw (body['error']['message']);

  //   if (body['statusCode'] != 0) throw (body['message']);

  //   UserModel result = UserModel.fromJson(body['data']['user']);
  // }
}

class RequestModel {
  String username = '';
  String password = '';
  RequestModel(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }
}
