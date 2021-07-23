import 'dart:convert';

import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/common.dart' as common;
import 'package:http/http.dart' as http;
import 'package:hospitalmonitor/business_logic/utils/profileImages.dart'
    as profileImages;

class PatientControlService {
  List<UserModel> allPatients = List<UserModel>.empty(growable: true);

  UserModel currentPatient = UserModel();

  Future<void> fetchAllPatients() async {
    //UserModel loggedUser = serviceLocator<CurrentSessionService>().loggedUser;
    List<UserModel> result = List<UserModel>.empty(growable: true);
    String url = common.baseURL + "/api/admin/patients";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      Map<String, dynamic> errBody = json.decode(response.body);
      throw (errBody["error"]["message"]);
    }

    List<dynamic> body = json.decode(response.body);

    body.forEach((element) {
      UserModel patientFetched = UserModel.fromJson(element);
      patientFetched.photo = profileImages.patient;
      result.add(patientFetched);
    });

    allPatients.clear();
    allPatients.addAll(result);
    allPatients.sort((a, b) => a.userName.compareTo(b.userName));
  }
}
