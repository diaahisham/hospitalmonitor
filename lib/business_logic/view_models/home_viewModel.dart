import 'package:hospitalmonitor/business_logic/models/user_model.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/business_logic/utils/route_paths.dart'
    as routes;

class HomeViewModel {
  void goToLoginPage(UserType user) {
    serviceLocator<CurrentSessionService>().loggedUserType =
        UserModel(type: user);
    serviceLocator<NavigationService>().navigateTo(routes.LoginRoute);
  }
}
