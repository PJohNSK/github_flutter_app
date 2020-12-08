import 'package:flutter/material.dart';
import 'package:github/screens/main/dashboard.dart';
import 'package:github/screens/main/file.dart';
import 'package:github/screens/main/history.dart';
import 'package:github/screens/main/tree.dart';
import 'package:github/screens/main/login.dart';

class Routes {
  static const String login = "screens/main/login";
  static const String dashboard = "screens/main/dashbord";
  static const String tree = "screens/main/tree";
  static const String history = "screens/main/history";
  static const String file = "screens/main/file";

}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());

      case Routes.tree:
        final  Map<String, Object>rcvdData = settings.arguments;
        return MaterialPageRoute(builder: (_) => TreePage(rcvdData['repo'], rcvdData['branch']));

      case Routes.history:
        final  Map<String, Object>rcvdData = settings.arguments;
        return MaterialPageRoute(builder: (_) => HistoryPage(rcvdData['repo'], rcvdData['branch']));

      case Routes.file:
        final  Map<String, Object>rcvdData = settings.arguments;
        return MaterialPageRoute(builder: (_) => FilePage(rcvdData['content'], rcvdData['fileName']));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
