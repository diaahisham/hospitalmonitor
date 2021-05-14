class AnalysisModel {
  String analysisID = '';
  String analystID = '';
  String analystName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String labName = '';
  String analysisUrl = '';
  String notes = '';

  AnalysisModel({
    this.analysisID = '',
    this.analystID = '',
    this.analystName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.analysisUrl = '',
    this.notes = '',
    this.labName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"AnalysisID"': this.analysisID,
      '"AnalystID"': this.analystID,
      '"AnalystName"': this.analystName,
      '"PatientID"': this.patientID,
      '"PatientName"': this.patientName,
      '"Date"': this.date,
      '"LabName"': this.labName,
      '"AnalysisURL"': this.analysisUrl,
      '"Notes"': this.notes,
    };
  }

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      analysisID: json["AnalysisID"] ?? '',
      analystID: json["AnalystID"] ?? '',
      analystName: json["AnalystName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      date: json["Date"] ?? '',
      labName: json["LabName"] ?? '',
      analysisUrl: json["AnalysisURL"] ?? '',
      notes: json["Notes"] ?? '',
    );
  }
}
