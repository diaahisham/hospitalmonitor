class ExaminationModel {
  String examinationID = '';
  String doctorID = '';
  String doctorName = '';
  String patientID = '';
  String patientName = '';
  String date = '';
  String symptoms = '';
  String disease = '';
  String description = '';
  List<String> drugs = List<String>.empty(growable: true);
  bool isDeleted = false;

  ExaminationModel({
    this.examinationID = '',
    this.doctorID = '',
    this.doctorName = '',
    this.patientID = '',
    this.disease = '',
    this.patientName = '',
    this.date = '',
    this.description = '',
    this.symptoms = '',
    this.drugs = const [],
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    if (this.isDeleted)
      return {
        "isDeleted": this.isDeleted,
      };
    else
      return {
        "drugs": this.drugs,
        "patientId": this.patientID,
        "disease": this.disease,
        "symproms": this.symptoms,
        "description": this.description,
      };
  }

  factory ExaminationModel.fromJson(Map<String, dynamic> json) {
    return ExaminationModel(
      examinationID: json["id"] ?? '',
      doctorID: json["doctorId"] ?? '',
      doctorName: json["doctor"]["username"] ?? '',
      patientID: json["patientId"] ?? '',
      patientName: json["patient"]["username"] ?? '',
      date: json["updatedAt"] ?? '',
      symptoms: json["symproms"] ?? '',
      description: json["description"] ?? '',
      disease: json["disease"] ?? "",
      drugs: List<String>.from(json["drugs"] ?? [], growable: true),
    );
  }

  void copy(ExaminationModel origin) {
    this.examinationID = origin.examinationID;
    this.doctorID = origin.doctorID;
    this.doctorName = origin.doctorName;
    this.patientID = origin.patientID;
    this.patientName = origin.patientName;
    this.date = origin.date;
    this.symptoms = origin.symptoms;
    this.description = origin.description;
    this.disease = origin.disease;
    this.drugs = origin.drugs.toList(growable: true);
  }
}
