import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalmonitor/business_logic/models/examination_model.dart';
import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/dialoge_service/dialoge_service.dart';
import 'package:hospitalmonitor/services/examination_control_service/examination_control_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/patient_control_service/patient_control_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class ExaminationViewModel {
  List<ExaminationModel> get examModels =>
      serviceLocator<ExaminationControlService>().examModels;
  bool userIsDoctor = false;
  ValueNotifier<int> examsLength = ValueNotifier<int>(0);
  DialogeService dialogeService = DialogeService();

  UserType get loggedUserType =>
      serviceLocator<CurrentSessionService>().loggedUser.type;

  UserModel user = serviceLocator<CurrentSessionService>().loggedUser;

  ExaminationViewModel() {
    userIsDoctor = (serviceLocator<CurrentSessionService>().loggedUser.type ==
        UserType.doctor);
  }

  String searchValue = '';
  int rowNumber = -1;

  bool isRowVisible(String name) {
    if (searchValue == '') return true;

    if (name.length < searchValue.length) return false;

    return (searchValue.toLowerCase() ==
        name.substring(0, searchValue.length).toLowerCase());
  }

  void searchValueChange(String search) {
    rowNumber = -1;
    searchValue = search;
    examsLength.value += 1;
  }

  Color? rowColor() {
    rowNumber += 1;
    if (rowNumber % 2 == 1)
      return Colors.grey[350];
    else
      return Colors.white;
  }

  Future<void> deleteExam(ExaminationModel examModel) async {
    examModels.removeWhere(
        (element) => element.examinationID == examModel.examinationID);
    examsLength.value = examModels.length;
    sortExams();
  }

  void addExam() {
    UserModel currentpatient =
        serviceLocator<PatientControlService>().currentPatient;
    serviceLocator<ExaminationControlService>().currentEdittingExam =
        ExaminationModel(patientID: currentpatient.userID);
    serviceLocator<NavigationService>().navigateTo(routes.AddEditExamRoute);
    sortExams();
  }

  void editExam(ExaminationModel examModel) {
    serviceLocator<ExaminationControlService>().currentEdittingExam = examModel;
    serviceLocator<NavigationService>().navigateTo(routes.AddEditExamRoute);
    sortExams();
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      dialogeService.showErrorDialoge('Could not launch $url');
    }
  }

  void sortExams() {
    if (this.userIsDoctor)
      examModels.sort((a, b) => a.patientName.compareTo(b.patientName));
    else
      examModels.sort((a, b) => a.doctorName.compareTo(b.doctorName));
  }

  void showMore(ExaminationModel model) {
    DialogeService dialogeService = DialogeService();
    dialogeService.showDataDialogue(
      "More info",
      Container(
        width: 400,
        height: 600,
        color: Colors.blue[100],
        padding: EdgeInsets.all(15),
        child: ListView(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          children: [
            _labelWidget("Symptomps"),
            _dataField(text: model.symptoms),
            _lineSeprator(10),
            _labelWidget("Description"),
            _dataField(text: model.description),
            _lineSeprator(10),
            _labelWidget("Drugs"),
            for (String drug in model.drugs) _dataField(text: "  * " + drug),
          ],
        ),
      ),
    );
  }

  Widget _labelWidget(String label) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        label + ': ',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dataField({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _lineSeprator(double width) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: width,
        height: 1,
        color: Colors.black,
      ),
    );
  }
}
