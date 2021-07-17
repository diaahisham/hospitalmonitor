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
      radioID: json["RadioID"] ?? '',
      radiologistID: json["RadiologistID"] ?? '',
      radioName: json["RadiologistName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      date: json["Date"] ?? '',
      radiologistName: json["LabName"] ?? '',
      radioUrl: json["RadioURL"] ?? '',
      notes: json["Notes"] ?? '',
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
  }
}
