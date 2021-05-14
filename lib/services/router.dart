import 'package:flutter/material.dart';

import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;
import 'package:hospitalmonitor/ui/views/add_edit_radio_view.dart';
import 'package:hospitalmonitor/ui/views/home_view.dart';
import 'package:hospitalmonitor/ui/views/login_view.dart';
import 'package:hospitalmonitor/ui/views/profile_view.dart';
import 'package:hospitalmonitor/ui/views/radios_view.dart';

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
