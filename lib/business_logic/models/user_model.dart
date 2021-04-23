enum UserType { notDefined, doctor, patient, radiologist, analysit }

class UserModel {
  String userName;
  String password;
  String mobileNumber;
  String address;
  String email;
  UserType type;
  String token;
  String photo;

  UserModel({
    this.userName = '',
    this.password = '',
    this.mobileNumber = '',
    this.address = '',
    this.email = '',
    this.type = UserType.notDefined,
    this.token = '',
    this.photo = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"UserName"': this.userName,
      '"Password"': this.password,
      '"MobileNumber"': this.mobileNumber,
      '"Email"': this.email,
      '"Address"': this.address,
      '"Type"': this.type.index,
      '"Token"': this.token,
      '"Photo"': this.photo,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json["UserName"] ?? "",
      password: json["Password"] ?? "",
      mobileNumber: json["MobileNumber"] ?? "",
      email: json["Email"] ?? "",
      address: json["Address"] ?? "",
      photo: json["Photo"] ?? "",
      type: UserType.values[json["Type"] ?? 0],
      token: json["Token"] ?? '',
    );
  }
  @override
  String toString() {
    return '{"UserName":"${this.userName}","Password":"${this.password}","Email":"${this.email}","MobileNumber":"${this.mobileNumber}","Address":"${this.address}","Type":${this.type.index},"Token":"${this.token}","Photo":"${this.photo}"}';
  }
}
