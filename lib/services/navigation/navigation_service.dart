import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void popAndNavigateTo(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments);
  }
}
