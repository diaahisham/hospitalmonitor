enum UserType { notDefined, doctor, patient, radiologist, analysit }

class UserModel {
  String userName;
  String password;
  String mobileNumber;
  String address;
  String email;
  UserType type;

  UserModel({
    this.userName = '',
    this.password = '',
    this.mobileNumber = '',
    this.address = '',
    this.email = '',
    this.type = UserType.notDefined,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserName': this.userName,
      'Password': this.password,
      'MobileNumber': this.mobileNumber,
      'Email': this.email,
      'Address': this.address,
      'Type': this.type.index,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json["UserName"] ?? "",
      password: json["Password"] ?? "",
      mobileNumber: json["MobileNumber"] ?? "",
      address: json["Address"] ?? "",
      type: UserType.values[json["Type"] ?? 0],
    );
  }
  @override
  String toString() {
    return '{"UserName":"${this.userName}","Password":"${this.password}","MobileNumber":"${this.mobileNumber}","Address":"${this.address}","Type":${this.type.index}}';
  }
}
