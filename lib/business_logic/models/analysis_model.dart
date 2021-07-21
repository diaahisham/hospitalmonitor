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
  bool isDeleted = false;

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
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "analysisName": this.analysisName,
      "patientId": this.patientID,
      "documentURl": this.analysisUrl,
      "note": this.notes,
      "isDeleted": this.isDeleted,
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
      labName: json["analyst"]?["analysisLab"]?["name"] ?? '',
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
