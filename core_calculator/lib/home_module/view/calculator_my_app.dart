import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:core_calculator/utils/core_calculator_bloc_init.dart';
import 'package:core_calculator/utils/core_calculator_route_generator.dart';
import 'package:core_utility/core_utility.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_route_generator.dart';
import 'package:core_utility/navigation/core_route_observer.dart';
import 'package:core_utility/theme/core_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorMyApp extends StatelessWidget {
  const CalculatorMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...coreCalculatorBlocInit(),
      ],
      child: MaterialApp(
        title: 'EMI Calculator',
        scaffoldMessengerKey: globalScaffoldMessengerKey,
        navigatorKey: globalNavigatorKey,
        navigatorObservers: [CoreRouteObserver()],
        debugShowCheckedModeBanner: false,
        initialRoute: CoreCalculatorRoutes.emiHome,
        onGenerateRoute: (settings) {
          return CoreRouteGenerator.buildRouteGenerator(settings, {
            "/calculator": coreCalculatorRouteGenerator(settings),
          });
        },
        theme: CoreAppTheme.theme(context),
      ),
    );
  }
}
