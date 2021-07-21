enum UserType { notDefined, doctor, patient, analyst, radiologist }
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
  //
  // Patient vital modifiers
  int bloodPressure = 0;
  String bloodType = '';
  int breathingRate = 0;
  int diabetesRate = 0;
  List<String> chronicDiseases = List<String>.empty(growable: true);
  List<String> dangerDiseases = List<String>.empty(growable: true);
  List<String> sensitivities = List<String>.empty(growable: true);
  List<String> vaccinations = List<String>.empty(growable: true);

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
    // patient vital modifier
    this.bloodPressure = 0,
    this.bloodType = '',
    this.breathingRate = 0,
    this.diabetesRate = 0,
    this.chronicDiseases = const [],
    this.dangerDiseases = const [],
    this.sensitivities = const [],
    this.vaccinations = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.userID,
      "username": this.userName,
      //"password": this.password, // TODO: remove the comment when the backend finishes the error
      "phone": this.mobileNumber,
      "email": this.email,
      "address": this.address,
      "role": this.type.index - 1,
      //"token": this.token,
      //'"photo"': this.photo,
      //"nationalID": this.nationalID,
      "age": this.age,
      "gender": this.genderType.index,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json["id"] ?? "",
      userName: json["username"] ?? "",
      password: json["password"] ?? "",
      mobileNumber: json["phone"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      photo: json["photo"] ?? "",
      type: UserType.values[(json["role"] ?? 0) + 1],
      token: json["token"] ?? '',
      nationalID: json["nationalId"] ?? '',
      age: json["age"] ?? 0,
      genderType: GenterType.values[json["gender"] ?? 1],
      //
      // patient vital modifiers
      bloodPressure: json["vitalModifiers"]?["bloodPressure"] ?? 0,
      bloodType: json["vitalModifiers"]?["bloodType"]?.toString() ?? '',

      breathingRate: json["vitalModifiers"]?["breathingRate"] ?? 0,
      diabetesRate: json["vitalModifiers"]?["diabetesRate"] ?? 0,
      chronicDiseases:
          List<String>.from(json["chronicDiseases"] ?? [], growable: true),
      dangerDiseases:
          List<String>.from(json["dangerousDiseases"] ?? [], growable: true),
      sensitivities:
          List<String>.from(json["sensitivities"] ?? [], growable: true),
      vaccinations:
          List<String>.from(json["vaccination"] ?? [], growable: true),
    );
  }
  @override
  String toString() {
    String userIdString = '"id":"${this.userID}"';

    String userNameString = ',"username":"${this.userName}"';

    String passwordString = ',"password":"${this.password}"';

    String mobileString = ',"phone":"${this.mobileNumber}"';

    String emailString = ',"email":"${this.email}"';

    String addressString = ',"address":"${this.address}"';

    String photoString = ',"photo":"${this.photo}"';

    String tokenString = ',"token":"${this.token}"';

    String typeString = ',"role":${this.type.index - 1}';

    String nationalIDString = ',"nationalId":"${this.nationalID}"';

    String ageString = ',"age":${this.age}';

    String genderString = ',"gender":${this.genderType.index}';

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
        '}';
  }
}
