import 'package:get_it/get_it.dart';
import 'package:hospitalmonitor/services/current_session_service/current_session_service.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<NavigationService>(NavigationService());
  serviceLocator
      .registerSingleton<CurrentSessionService>(CurrentSessionService());
}
