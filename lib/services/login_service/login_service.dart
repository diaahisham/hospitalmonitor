import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';

class LoginService {
  UserModel _doctor = UserModel(
    userName: 'doctor',
    password: 'doctor',
    address: '5 Doctor Street',
    email: 'doctor@gmail.com',
    mobileNumber: '0111',
    type: UserType.doctor,
    token: '',
  );

  UserModel _patient = UserModel(
    userName: 'patient',
    password: 'patient',
    address: '5 Patient Street',
    email: 'patient@gmail.com',
    mobileNumber: '0112',
    type: UserType.patient,
    token: '',
  );

  UserModel _analysit = UserModel(
    userName: 'analysit',
    password: 'analysit',
    address: '5 Analysit Street',
    email: 'analysit@gmail.com',
    mobileNumber: '0122',
    type: UserType.analysit,
    token: '',
  );

  UserModel _radiologist = UserModel(
    userName: 'radiologist',
    password: 'radiologist',
    address: '5 Radiologist Street',
    email: 'radiologist@gmail.com',
    mobileNumber: '0222',
    type: UserType.radiologist,
    token: '',
  );

  UserModel login(UserModel userRequest) {
    switch (userRequest.type) {
      case UserType.doctor:
        return (_checkNameAndPassword(this._doctor, userRequest));
      case UserType.analysit:
        return (_checkNameAndPassword(this._analysit, userRequest));
      case UserType.patient:
        return (_checkNameAndPassword(this._patient, userRequest));
      case UserType.radiologist:
        return (_checkNameAndPassword(this._radiologist, userRequest));
      default:
        throw Exception('Wrong username or wrong password');
    }
  }

  UserModel _checkNameAndPassword(UserModel fromData, UserModel userRequest) {
    if ((fromData.userName == userRequest.userName) &&
        (fromData.password == userRequest.password)) {
      // save the token to be used in further requests
      serviceLocator<CurrentSessionService>().loggedUserType = fromData;
      return fromData;
    } else
      throw Exception('Wrong username or wrong password');
  }
}
