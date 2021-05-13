import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

List<UserModel> radiologists = [
  UserModel(
    userID: "0",
    userName: 'radiologist',
    password: 'radiologist',
    address: '5 Radiologist Street',
    email: 'radiologist@gmail.com',
    mobileNumber: '0222',
    type: UserType.radiologist,
    token: '',
    photo: profileImages.radio,
  ),
  UserModel(
    userID: "1",
    userName: 'radiologist1',
    password: 'radiologist1',
    address: '5 Radiologist_1 Street',
    email: 'radiologist1@gmail.com',
    mobileNumber: '0226542',
    type: UserType.radiologist,
    token: '',
    photo: profileImages.radio,
  ),
  UserModel(
    userID: "2",
    userName: 'radiologist2',
    password: 'radiologist2',
    address: '5 Radiologist_2 Street',
    email: 'radiologist2@gmail.com',
    mobileNumber: '022654542',
    type: UserType.radiologist,
    token: '',
    photo: profileImages.radio,
  ),
];
