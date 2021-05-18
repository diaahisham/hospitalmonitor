import 'package:flutter/material.dart';

import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/ui/views/add_edit_analysis_view.dart';
import 'package:hospitalmonitor/ui/views/add_edit_radio_view.dart';
import 'package:hospitalmonitor/ui/views/analyzes_view.dart';
import 'package:hospitalmonitor/ui/views/examination_view.dart';
import 'package:hospitalmonitor/ui/views/home_view.dart';
import 'package:hospitalmonitor/ui/views/login_view.dart';
import 'package:hospitalmonitor/ui/views/profile_view.dart';
import 'package:hospitalmonitor/ui/views/radios_view.dart';
import 'package:hospitalmonitor/ui/views/add_edit_exam_view.dart';
import 'package:hospitalmonitor/ui/views/report_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routes.HomeRoute:
        return MaterialPageRoute(
            builder: (_) => HomeView(), settings: settings);
      case routes.LoginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginView(), settings: settings);
      case routes.ProfileRoute:
        return MaterialPageRoute(
            builder: (_) => ProfileView(), settings: settings);
      case routes.RadiosRoute:
        return MaterialPageRoute(
            builder: (_) => RadiosView(), settings: settings);
      case routes.AddEditRadioRoute:
        return MaterialPageRoute(
            builder: (_) => AddEditRadioView(), settings: settings);
      case routes.AnalysisRoute:
        return MaterialPageRoute(
            builder: (_) => AnalyzesView(), settings: settings);
      case routes.AddEditAnalysisRoute:
        return MaterialPageRoute(
            builder: (_) => AddEditAnalysisView(), settings: settings);
      case routes.ExaminationViewRoute:
        return MaterialPageRoute(
            builder: (_) => ExaminationView(), settings: settings);
      case routes.AddEditExamRoute:
        return MaterialPageRoute(
            builder: (_) => AddEditExamView(), settings: settings);
      case routes.HealthReportRoute:
        return MaterialPageRoute(
            builder: (_) => ReportView(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Error: No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
