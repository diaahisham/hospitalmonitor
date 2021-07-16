import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

List<UserModel> analysts = [
  UserModel(
    userID: "0",
    userName: 'Mostafa',
    password: 'analyst',
    address: '5 analyst Street',
    email: 'analyst@gmail.com',
    mobileNumber: '0122',
    type: UserType.analyst,
    token: '',
    photo: profileImages.analyst,
    age: 40,
    nationalID: '0123456789012345',
  ),
  UserModel(
    userID: "1",
    userName: 'Mostafa1',
    password: 'analyst1',
    address: '5 analyst_1 Street',
    email: 'analyst1@gmail.com',
    mobileNumber: '01265465465412',
    type: UserType.analyst,
    token: '',
    photo: profileImages.analyst,
    age: 50,
    nationalID: '0123456788012345',
  ),
  UserModel(
    userID: "2",
    userName: 'Mostafa2',
    password: 'analyst2',
    address: '5 analyst_2 Street',
    email: 'analyst2@gmail.com',
    mobileNumber: '05465465412',
    type: UserType.analyst,
    token: '',
    photo: profileImages.analyst,
    age: 46,
    nationalID: '0123456759012345',
  ),
];
