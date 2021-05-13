class ExaminationModel {
  String examinationID = '';
  String doctorID = '';
  String doctorName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String symptoms = '';
  String examinationResult = '';
  String notes = '';

  ExaminationModel({
    this.examinationID = '',
    this.doctorID = '',
    this.doctorName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.examinationResult = '',
    this.notes = '',
    this.symptoms = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"ExaminationID"': this.examinationID,
      '"DoctorID"': this.doctorID,
      '"DoctorName"': this.doctorName,
      '"PatientID"': this.patientID,
      '"PatientName"': this.patientName,
      '"Date"': this.date,
      '"Symptoms"': this.symptoms,
      '"ExaminationResult"': this.examinationResult,
      '"Notes"': this.notes,
    };
  }

  factory ExaminationModel.fromJson(Map<String, dynamic> json) {
    return ExaminationModel(
      examinationID: json["ExaminationID"] ?? '',
      doctorID: json["DoctorID"] ?? '',
      doctorName: json["DoctorName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      date: json["Date"] ?? '',
      symptoms: json["Symptoms"] ?? '',
      examinationResult: json["ExaminationResult"] ?? '',
      notes: json["Notes"] ?? '',
    );
  }
}
