import 'package:branch_locator/util/locator_bloc_init.dart';
import 'package:branch_locator/util/locator_route_generator.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_utility.dart';
import 'package:core_utility/navigation/core_route_generator.dart';
import 'package:core_utility/theme/core_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchLocatorApp extends StatelessWidget {
  const BranchLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...locatorBlocInit(),
      ],
      child: MaterialApp(
        title: 'IFSC FINDER',
        scaffoldMessengerKey: globalScaffoldMessengerKey,
        navigatorKey: globalNavigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: LocatorRoutePaths.landing,
        onGenerateRoute: (settings) {
          return CoreRouteGenerator.buildRouteGenerator(settings, {
            "/locator": locatorRouteGenerator(settings),
          });
        },
        theme: CoreAppTheme.theme(context),
      ),
    );
  }
}
