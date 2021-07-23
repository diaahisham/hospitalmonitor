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
  bool isDeleted = false;

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
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    if (this.isDeleted)
      return {
        "isDeleted": this.isDeleted,
      };
    else
      return {
        "reportURl":
            "https://cdn.services.tra.gov.ae/1547ac06-74ae-4ddd-b8f4-45e98fb0aeb0682b604b-8d9e-4040-94b3-2ad5b42bd0cb04.pdf",
        "radiologyName": this.radioName,
        "patientId": this.patientID,
        "radiologyURl": this.radioUrl,
        "note": this.notes,
      };
  }

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      radioID: json["id"] ?? '',
      radiologistID: json["RadiologistID"] ?? '',
      radiologistName: json["radiologist"]["username"] ?? '',
      //
      radioName: json["radiologyName"] ?? '',
      patientID: json["patientId"] ?? '',
      patientName: json["patient"]?["username"] ?? '',
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
