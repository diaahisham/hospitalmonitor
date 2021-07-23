import 'package:flutter/foundation.dart';

class DayDatesModel {
  String dayName = '';
  String fromHour = '';
  String toHour = '';

  DayDatesModel({
    this.dayName = '',
    this.fromHour = '',
    this.toHour = '',
  });

  factory DayDatesModel.fromJson(Map<String, dynamic> json) {
    return DayDatesModel(
      dayName: json["day"],
      fromHour: json["from"],
      toHour: json["to"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "day": this.dayName,
      "from": this.fromHour,
      "to": this.toHour,
    };
  }

  DayDatesModel duplicate() {
    return DayDatesModel(
      dayName: this.dayName,
      fromHour: this.fromHour,
      toHour: this.toHour,
    );
  }
}
