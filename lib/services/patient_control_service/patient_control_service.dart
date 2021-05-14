import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/business_logic/utils/patients.dart';

class PatientControlService {
  List<UserModel> allPatients = List<UserModel>.empty(growable: true);

  Future<void> fetchAllPatients() async {
    allPatients.clear();
    allPatients.addAll(patients);
    allPatients.sort((a, b) => a.userName.compareTo(b.userName));
  }
}
