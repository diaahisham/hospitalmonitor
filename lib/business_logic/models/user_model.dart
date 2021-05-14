enum UserType { notDefined, doctor, patient, radiologist, analysit }

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
  String birthDate;

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
    this.birthDate = '',
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
      '"BirthDate"': this.birthDate,
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
      birthDate: json["BirthDate"] ?? '',
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

    String birthDateString = ',"BirthDate":"${this.birthDate}"';

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
        '$birthDateString' +
        '}';
  }
}
