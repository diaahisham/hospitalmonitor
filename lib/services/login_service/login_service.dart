import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/analysts.dart';
import 'package:hospitalmonitor/business_logic/utils/doctors.dart';
import 'package:hospitalmonitor/business_logic/utils/patients.dart';
import 'package:hospitalmonitor/business_logic/utils/radiologists.dart';

//import 'package:http/http.dart' as http;

class LoginService {
  UserModel login(UserModel userRequest) {
    return (_checkNameAndPassword(userRequest));
  }

  UserModel _checkNameAndPassword(UserModel userRequest) {
    List<UserModel> tempSearch = List<UserModel>.empty(growable: true);
    switch (userRequest.type) {
      case UserType.doctor:
        tempSearch.addAll(doctors);
        break;
      case UserType.patient:
        tempSearch.addAll(patients);
        break;
      case UserType.analysit:
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
}
