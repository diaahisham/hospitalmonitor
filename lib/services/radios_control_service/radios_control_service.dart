import 'package:hospitalmonitor/business_logic/models/radio_model.dart';

class RadiosControlService {
  List<RadioModel> radioModels = List<RadioModel>.empty(growable: true);

  Future<void> fetchRadioModelsByRadiologistId() async {}

  Future<void> fetchRadioModelsByPatientId() async {}
}
