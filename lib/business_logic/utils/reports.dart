import 'package:hospitalmonitor/business_logic/models/health_report_model.dart';

List<HealthReportModel> healthReports = [
  HealthReportModel(
    reportID: '0',
    patientID: '0',
    patientName: 'Samy',
    bloodPressure: 100,
    bloodType: 'A',
    // pulseRate: '100/100',
    breathingRate: 100,
    diabetesRate: 100,
    chronicDiseases: ['mafesh', 'mango'],
    dangerDiseases: ['mafesh', 'koha'],
    sensitivities: ['manga', 'watermelon'],
    vaccinations: ['nothing'],
  ),
  HealthReportModel(
    reportID: '10',
    patientID: '1',
    patientName: 'Yehia',
    bloodPressure: 200,
    bloodType: 'B',
    //pulseRate: '200/100',
    breathingRate: 200,
    diabetesRate: 200,
    chronicDiseases: ['heart'],
    dangerDiseases: ['gooooood'],
    sensitivities: ['manga', 'gwafa'],
    vaccinations: ['nothing'],
  ),
  HealthReportModel(
    reportID: '20',
    patientID: '2',
    patientName: 'Samy2',
    bloodPressure: 300,
    bloodType: '300',
    //pulseRate: '100/300',
    breathingRate: 300,
    diabetesRate: 300,
    chronicDiseases: [],
    dangerDiseases: ['koha'],
    sensitivities: ['chicken', 'manga', 'fish'],
    vaccinations: ['all of them'],
  ),
];
