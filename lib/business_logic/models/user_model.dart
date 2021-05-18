enum UserType { notDefined, doctor, patient, radiologist, analysit }
enum GenterType { female, male }
enum MaritalStatus { single, married }

class UserModel {
  String userID = '';
  String userName;
  String password;
  String mobileNumber;
  String address;
  String email;
  UserType type;
  String token;
  String photo;

  String nationalID;
  int age;
  GenterType genderType;
  MaritalStatus maritalStatus;

  UserModel({
    this.userID = '',
    this.userName = '',
    this.password = '',
    this.mobileNumber = '',
    this.address = '',
    this.email = '',
    this.type = UserType.notDefined,
    this.token = '',
    this.photo = '',
    this.nationalID = '',
    this.age = 0,
    this.genderType = GenterType.male,
    this.maritalStatus = MaritalStatus.married,
  });

  Map<String, dynamic> toJson() {
    return {
      "UserID": this.userID,
      '"UserName"': this.userName,
      '"Password"': this.password,
      '"MobileNumber"': this.mobileNumber,
      '"Email"': this.email,
      '"Address"': this.address,
      '"Type"': this.type.index,
      '"Token"': this.token,
      '"Photo"': this.photo,
      '"NationalID': this.nationalID,
      '"Age"': this.age,
      '"GenterType"': this.genderType.index,
      '"MaritalStatus"': this.maritalStatus.index,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json["UserID"] ?? "",
      userName: json["UserName"] ?? "",
      password: json["Password"] ?? "",
      mobileNumber: json["MobileNumber"] ?? "",
      email: json["Email"] ?? "",
      address: json["Address"] ?? "",
      photo: json["Photo"] ?? "",
      type: UserType.values[json["Type"] ?? 0],
      token: json["Token"] ?? '',
      nationalID: json["NationalID"] ?? '',
      age: int.parse(json["Age"]),
      genderType: GenterType.values[json["GenterType"] ?? 1],
      maritalStatus: MaritalStatus.values[json["MaritalStatus"] ?? 1],
    );
  }
  @override
  String toString() {
    String userIdString = '"UserID":"${this.userID}"';

    String userNameString = ',"UserName":"${this.userName}"';

    String passwordString = ',"Password":"${this.password}"';

    String mobileString = ',"MobileNumber":"${this.mobileNumber}"';

    String emailString = ',"Email":"${this.email}"';

    String addressString = ',"Address":"${this.address}"';

    String photoString = ',"Photo":"${this.photo}"';

    String tokenString = ',"Token":"${this.token}"';

    String typeString = ',"Type":${this.type.index}';

    String nationalIDString = ',"NationalID":"${this.nationalID}"';

    String ageString = ',"Age":"${this.age}"';

    String genderString = ',"GenterType":${this.genderType.index}';

    String maritalString = ',"MaritalStatus":${this.maritalStatus.index}';

    return '{' +
        '$userIdString' +
        '$userNameString' +
        '$passwordString' +
        '$mobileString' +
        '$emailString' +
        '$addressString' +
        '$photoString' +
        '$tokenString' +
        '$typeString' +
        '$ageString' +
        '$nationalIDString' +
        '$genderString' +
        '$maritalString' +
        '}';
  }
}
