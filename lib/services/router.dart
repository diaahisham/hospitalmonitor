import 'package:flutter/material.dart';

import 'package:hospitalmonitor/buisness_logic/utils/route_paths.dart'
    as routes;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
