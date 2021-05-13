class HealthReportModel {
  String reportID = '';
  String patientID = '';
  String patientName = '';
  String bloodPressure = '';
  String bloodType = '';
  String pulseRate = '';
  String breathingRate = '';
  String diabetesRate = '';
  List<String> chronicDiseases = List<String>.empty(growable: true);
  List<String> dangerDiseases = List<String>.empty(growable: true);
  List<String> sensitivities = List<String>.empty(growable: true);
  List<String> vaccinations = List<String>.empty(growable: true);

  HealthReportModel({
    this.reportID = '',
    this.patientID = '',
    this.patientName = '',
    this.bloodPressure = '',
    this.bloodType = '',
    this.pulseRate = '',
    this.breathingRate = '',
    this.diabetesRate = '',
    this.chronicDiseases = const [],
    this.dangerDiseases = const [],
    this.sensitivities = const [],
    this.vaccinations = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      "ReportID": this.reportID,
      "PatientID": this.patientID,
      "PatientName": this.patientName,
      "BloodPressure": this.bloodPressure,
      "BloodType": this.bloodType,
      "PulseRate": this.pulseRate,
      "BreathingRate": this.breathingRate,
      "DiabetesRate": this.diabetesRate,
      "ChronicDiseases": this.chronicDiseases,
      "DangerDiseases": this.dangerDiseases,
      "Sensitivities": this.sensitivities,
      "Vaccinations": this.vaccinations
    };
  }

  factory HealthReportModel.fromJson(Map<String, dynamic> json) {
    return HealthReportModel(
      reportID: json["ReportID"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      bloodPressure: json["BloodPressure"] ?? '',
      bloodType: json["BloodType"] ?? '',
      pulseRate: json["PulseRate"] ?? '',
      breathingRate: json["BreathingRate"] ?? '',
      diabetesRate: json["DiabetesRate"] ?? '',
      chronicDiseases:
          List<String>.from(json["DiabetesRate"] ?? [], growable: true),
      dangerDiseases:
          List<String>.from(json["DangerDiseases"] ?? [], growable: true),
      sensitivities:
          List<String>.from(json["Sensitivities"] ?? [], growable: true),
      vaccinations:
          List<String>.from(json["Vaccinations"] ?? [], growable: true),
    );
  }
}
