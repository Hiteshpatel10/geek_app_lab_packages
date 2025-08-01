import 'package:flutter/material.dart';

class CoreRouteGenerator {
  static dynamic args;

  static Route<dynamic>? buildRouteGenerator(
    RouteSettings settings,
    Map<String, MaterialPageRoute<dynamic>> routeBuilders,
  ) {
    String? key = settings.name?.split('-').first;
    if (key != null) {
      if (routeBuilders.containsKey(key)) {
        return routeBuilders[key];
      }
      if (routeBuilders.containsKey('/$key')) {
        return routeBuilders['/$key'];
      }
    }

    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Route not found: ${settings.name}'),
        ),
      ),
    );
  }
}
