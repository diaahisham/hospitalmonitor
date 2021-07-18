class HealthReportModel {
  String reportID = '';
  String patientID = '';
  String patientName = '';
  int bloodPressure = 0;
  String bloodType = '';
  //String pulseRate = '';
  int breathingRate = 0;
  int diabetesRate = 0;
  List<String> chronicDiseases = List<String>.empty(growable: true);
  List<String> dangerDiseases = List<String>.empty(growable: true);
  List<String> sensitivities = List<String>.empty(growable: true);
  List<String> vaccinations = List<String>.empty(growable: true);

  HealthReportModel({
    this.reportID = '',
    this.patientID = '',
    this.patientName = '',
    this.bloodPressure = 0,
    this.bloodType = '',
    //this.pulseRate = '',
    this.breathingRate = 0,
    this.diabetesRate = 0,
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
      //"PulseRate": this.pulseRate,
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
      //pulseRate: json["PulseRate"] ?? '',
      breathingRate: json["BreathingRate"] ?? '',
      diabetesRate: json["DiabetesRate"] ?? '',
      chronicDiseases:
          List<String>.from(json["ChronicDiseases"] ?? [], growable: true),
      dangerDiseases:
          List<String>.from(json["DangerDiseases"] ?? [], growable: true),
      sensitivities:
          List<String>.from(json["Sensitivities"] ?? [], growable: true),
      vaccinations:
          List<String>.from(json["Vaccinations"] ?? [], growable: true),
    );
  }

  void copy(HealthReportModel origin) {
    this.reportID = origin.reportID;
    this.patientID = origin.patientID;
    this.patientName = origin.patientName;
    this.bloodPressure = origin.bloodPressure;
    this.bloodType = origin.bloodType;
    //this.pulseRate = origin.pulseRate;
    this.breathingRate = origin.breathingRate;
    this.diabetesRate = origin.diabetesRate;

    this.chronicDiseases = origin.chronicDiseases.toList(growable: true);
    this.dangerDiseases = origin.dangerDiseases.toList(growable: true);
    this.sensitivities = origin.sensitivities.toList(growable: true);
    this.vaccinations = origin.vaccinations.toList(growable: true);
  }

  @override
  String toString() {
    String reportIDString = '"ReportID":"${this.reportID}"';
    String patientIDString = ',"PatientID":"${this.patientID}"';
    String patientNameString = ',"PatientName":"${this.patientName}"';
    String bloodPressureString = ',"BloodPressure":"${this.bloodPressure}"';
    String bloodTypeString = ',"BloodType":"${this.bloodType}"';
    //String pulseRateString = ',"PulseRate":"${this.pulseRate}"';
    String breathingRateString = ',"BreathingRate":"${this.breathingRate}"';
    String diabetesRateString = ',"DiabetesRate":"${this.diabetesRate}"';
    String chronicDiseasesString = ',"ChronicDiseases":${this.chronicDiseases}';
    String dangerDiseasesString = ',"DangerDiseases":${this.dangerDiseases}';
    String sensitivitiesString = ',"Sensitivities":${this.sensitivities}';
    String vaccinationsString = ',"Vaccinations":${this.vaccinations}';

    return '{' +
        '$reportIDString' +
        '$patientIDString' +
        '$patientNameString' +
        '$bloodPressureString' +
        '$bloodTypeString' +
        //'$pulseRateString' +
        '$breathingRateString' +
        '$diabetesRateString' +
        '$chronicDiseasesString' +
        '$dangerDiseasesString' +
        '$sensitivitiesString' +
        '$vaccinationsString' +
        '}';
  }
}
