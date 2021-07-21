class RadioModel {
  String radioID = '';
  String radiologistID = '';
  String radioName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String radiologistName = '';
  String radioUrl = '';
  String notes = '';
  String radioLab = '';

  RadioModel({
    this.radioID = '',
    this.radiologistID = '',
    this.radioName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.radioUrl = '',
    this.notes = '',
    this.radiologistName = '',
    this.radioLab = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"RadioID"': this.radioID,
      '"RadiologistID"': this.radiologistID,
      '"RadiologistName"': this.radioName,
      '"PatientID"': this.patientID,
      '"PatientName"': this.patientName,
      '"Date"': this.date,
      '"LabName"': this.radiologistName,
      '"RadioURL"': this.radioUrl,
      '"Notes"': this.notes,
    };
  }

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      radioID: json["id"] ?? '',
      radiologistID: json["RadiologistID"] ?? '',
      radiologistName: json["radiologist"]["username"] ?? '',
      //
      radioName: json["radiologyName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["patient"]["username"] ?? '',
      date: json["updatedAt"] ?? '',
      radioUrl: json["radiologyURl"] ?? '',
      notes: json["note"] ?? '',
      radioLab: json["radiologist"]?["radiologyLab"]?["name"] ?? '',
    );
  }
  void copy(RadioModel origin) {
    this.radioID = origin.radioID;
    this.radiologistID = origin.radiologistID;
    this.radioName = origin.radioName;
    this.patientID = origin.patientID;
    this.patientName = origin.patientName;
    this.date = origin.date;
    this.radiologistName = origin.radiologistName;
    this.radioUrl = origin.radioUrl;
    this.notes = origin.notes;
    this.radioLab = origin.radioLab;
  }
}
