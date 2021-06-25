import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

List<UserModel> analysts = [
  UserModel(
    userID: "0",
    userName: 'Mostafa',
    password: 'analysit',
    address: '5 Analysit Street',
    email: 'analysit@gmail.com',
    mobileNumber: '0122',
    type: UserType.analysit,
    token: '',
    photo: profileImages.analyst,
    age: 40,
    nationalID: '0123456789012345',
  ),
  UserModel(
    userID: "1",
    userName: 'Mostafa1',
    password: 'analysit1',
    address: '5 Analysit_1 Street',
    email: 'analysit1@gmail.com',
    mobileNumber: '01265465465412',
    type: UserType.analysit,
    token: '',
    photo: profileImages.analyst,
    age: 50,
    nationalID: '0123456788012345',
  ),
  UserModel(
    userID: "2",
    userName: 'Mostafa2',
    password: 'analysit2',
    address: '5 Analysit_2 Street',
    email: 'analysit2@gmail.com',
    mobileNumber: '05465465412',
    type: UserType.analysit,
    token: '',
    photo: profileImages.analyst,
    age: 46,
    nationalID: '0123456759012345',
  ),
];
