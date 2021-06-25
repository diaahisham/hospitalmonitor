import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

List<UserModel> patients = [
  UserModel(
    userID: "0",
    userName: 'Samy',
    password: 'patient',
    address: '5 Patient Street',
    email: 'patient@gmail.com',
    mobileNumber: '0112',
    type: UserType.patient,
    token: '',
    photo: profileImages.patient,
    age: 20,
    nationalID: '0123456789012345',
  ),
  UserModel(
    userID: "1",
    userName: 'Yehia',
    password: 'patient1',
    address: '5 Patient_1 Street',
    email: 'patient1@gmail.com',
    mobileNumber: '011254654654',
    type: UserType.patient,
    token: '',
    photo: profileImages.patient,
    age: 30,
    nationalID: '0123456789012745',
  ),
  UserModel(
    userID: "2",
    userName: 'Samy2',
    password: 'patient2',
    address: '5 Patient_2 Street',
    email: 'patient2@gmail.com',
    mobileNumber: '011254654654',
    type: UserType.patient,
    token: '',
    photo: profileImages.patient,
    age: 28,
    nationalID: '0120456789012345',
  ),
];
