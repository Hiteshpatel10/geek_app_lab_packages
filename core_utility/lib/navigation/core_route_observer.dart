import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:flutter/cupertino.dart';

class CoreRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  void _sendScreenView(Route<dynamic> route) {
    final screenName = route.settings.name;
    if (screenName != null) Clarity.setCurrentScreenName(screenName);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      // _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      // _sendScreenView(previousRoute);
    }
  }
}
