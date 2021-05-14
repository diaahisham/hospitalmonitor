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
  ),
  UserModel(
    userID: "1",
    userName: 'Samy1',
    password: 'patient1',
    address: '5 Patient_1 Street',
    email: 'patient1@gmail.com',
    mobileNumber: '011254654654',
    type: UserType.patient,
    token: '',
    photo: profileImages.patient,
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
  ),
];
