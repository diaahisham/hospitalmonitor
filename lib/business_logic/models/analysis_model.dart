class AnalysisModel {
  String analysisID = '';
  String analystID = '';
  String analysisName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String analystName = '';
  String analysisUrl = '';
  String labName = '';
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
    this.labName = '',
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
      analysisID: json["id"] ?? '',
      analystID: json["analystId"] ?? '',
      analystName: json["analyst"]["username"] ?? '',
      //
      analysisName: json["analysisName"] ?? '',
      patientID: json["patientId"] ?? '',
      patientName: json["patient"]["name"] ?? '',
      date: json["updatedAt"] ?? '',
      analysisUrl: json["documentURl"] ?? '',
      labName: json["analyst"]["analysisLab"]["name"] ?? '',
      notes: json["note"] ?? '',
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
    this.labName = origin.labName;
  }
}
