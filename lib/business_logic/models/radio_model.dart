class RadioModel {
  String radioID = '';
  String radiologistID = '';
  String radiologistName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String labName = '';
  String radioUrl = '';
  String notes = '';

  RadioModel({
    this.radioID = '',
    this.radiologistID = '',
    this.radiologistName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.radioUrl = '',
    this.notes = '',
    this.labName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"RadioID"': this.radioID,
      '"RadiologistID"': this.radiologistID,
      '"RadiologistName"': this.radiologistName,
      '"PatientID"': this.patientID,
      '"PatientName"': this.patientName,
      '"Date"': this.date,
      '"LabName"': this.labName,
      '"RadioURL"': this.radioUrl,
      '"Notes"': this.notes,
    };
  }

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      radioID: json["RadioID"] ?? '',
      radiologistID: json["RadiologistID"] ?? '',
      radiologistName: json["RadiologistName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      date: json["Date"] ?? '',
      labName: json["LabName"] ?? '',
      radioUrl: json["RadioURL"] ?? '',
      notes: json["Notes"] ?? '',
    );
  }
}
