import 'package:flutter/material.dart';
import 'package:hospitalmonitor/services/navigation/navigation_service.dart';
import 'package:hospitalmonitor/services/service_locator.dart';
import 'package:hospitalmonitor/ui/views/widgets/home_view.dart';
import 'package:hospitalmonitor/services/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await serviceLocator.allReady();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      onGenerateRoute: router.Router.generateRoute,
      navigatorKey: serviceLocator<NavigationService>().navigatorKey,
    );
  }
}
