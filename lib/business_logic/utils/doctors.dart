import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

List<UserModel> doctors = [
  UserModel(
    userID: "0",
    userName: 'doctor',
    password: 'doctor',
    address: '5 Doctor Street',
    email: 'doctor@gmail.com',
    mobileNumber: '0111',
    type: UserType.doctor,
    token: '',
    photo: profileImages.doctor,
  ),
  UserModel(
    userID: "1",
    userName: 'doctor1',
    password: 'doctor1',
    address: '5 Doctor_1 Street',
    email: 'doctor1@gmail.com',
    mobileNumber: '01135415211',
    type: UserType.doctor,
    token: '',
    photo: profileImages.doctor,
  ),
  UserModel(
    userID: "2",
    userName: 'doctor2',
    password: 'doctor2',
    address: '5 Doctor_2 Street',
    email: 'doctor2@gmail.com',
    mobileNumber: '01146541',
    type: UserType.doctor,
    token: '',
    photo: profileImages.doctor,
  ),
];
