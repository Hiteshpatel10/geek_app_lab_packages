library core_utility;

import 'package:flutter/material.dart';

late final GlobalKey<NavigatorState> globalNavigatorKey;
late final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey;
late final String globalBaseUrl;
initGlobalKeys(
  GlobalKey<NavigatorState> navigatorKey,
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey, {
  required String baseUrl,
}) async {
  globalNavigatorKey = navigatorKey;
  globalScaffoldMessengerKey = scaffoldMessengerKey;
  globalBaseUrl = baseUrl;

  debugPrint(
      "----------------- initGlobalKeys -----------------\n$navigatorKey - $scaffoldMessengerKey");
}
