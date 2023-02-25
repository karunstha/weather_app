import 'package:flutter/material.dart';
import 'package:weatherapp/ui/pages/home.dart';

class Routes {
  Routes._();

  static const String initial = '/';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case initial:
        return _getPageRoute(
          routeName: routeSettings.name!,
          viewToShow: const PageHome(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child:
                          Text('No route defined for ${routeSettings.name}')),
                ));
    }
  }

  static PageRoute _getPageRoute(
      {required String routeName, required Widget viewToShow}) {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
    );
  }
}
