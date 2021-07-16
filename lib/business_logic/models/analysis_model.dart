class AnalysisModel {
  String analysisID = '';
  String analystID = '';
  String analysisName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String analystName = '';
  String analysisUrl = '';
  String notes = '';

  AnalysisModel({
    this.analysisID = '',
    this.analystID = '',
    this.analysisName = '',
    this.patientID = '',
    this.patientName = '',
    this.date = '',
    this.analysisUrl = '',
    this.notes = '',
    this.analystName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      '"AnalysisID"': this.analysisID,
      '"AnalystID"': this.analystID,
      '"AnalystName"': this.analysisName,
      '"PatientID"': this.patientID,
      '"PatientName"': this.patientName,
      '"Date"': this.date,
      '"LabName"': this.analystName,
      '"AnalysisURL"': this.analysisUrl,
      '"Notes"': this.notes,
    };
  }

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      analysisID: json["AnalysisID"] ?? '',
      analystID: json["AnalystID"] ?? '',
      analysisName: json["AnalystName"] ?? '',
      patientID: json["PatientID"] ?? '',
      patientName: json["PatientName"] ?? '',
      date: json["Date"] ?? '',
      analystName: json["LabName"] ?? '',
      analysisUrl: json["AnalysisURL"] ?? '',
      notes: json["Notes"] ?? '',
    );
  }
  void copy(AnalysisModel origin) {
    this.analysisID = origin.analysisID;
    this.analystID = origin.analystID;
    this.analysisName = origin.analysisName;
    this.patientID = origin.patientID;
    this.patientName = origin.patientName;
    this.date = origin.date;
    this.analystName = origin.analystName;
    this.analysisUrl = origin.analysisUrl;
    this.notes = origin.notes;
  }
}
