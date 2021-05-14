import 'package:flutter/material.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class UserAppbar extends AppBar {
  UserAppbar(String title)
      : super(
          title: Text(title),
          actions: [
            Center(
              child: Text(
                "Welcome " +
                    serviceLocator<CurrentSessionService>()
                        .loggedUser
                        .type
                        .toString()
                        .replaceAll('UserType.', '') +
                    " " +
                    serviceLocator<CurrentSessionService>().loggedUser.userName,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            TextButton(
              style: ButtonStyle(),
              clipBehavior: Clip.none,
              onPressed: () {
                serviceLocator<CurrentSessionService>().logout();
                serviceLocator<NavigationService>()
                    .popAndNavigateTo(routes.HomeRoute);
              },
              child: Container(
                height: 50,
                width: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffEA5B0C),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        );
}
