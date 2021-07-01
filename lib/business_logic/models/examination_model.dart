class ExaminationModel {
  String examinationID = '';
  String doctorID = '';
  String doctorName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String symptoms = '';
  String description = '';

  ExaminationModel({
    this.examinationID = '',
    this.doctorID = '',
    this.doctorName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.description = '',
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
      '"Description"': this.description,
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
      description: json["Description"] ?? '',
    );
  }
}
