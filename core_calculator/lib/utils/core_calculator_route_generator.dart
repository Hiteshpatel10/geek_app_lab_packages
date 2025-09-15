import 'package:core_calculator/home_module/view/calculator_home_view.dart';
import 'package:core_calculator/loan_calculator/view/car_loan/car_buying_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/car_loan/car_loan_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_calculator_result_view.dart';
import 'package:core_calculator/loan_calculator/view/emi_calculator/emi_tenure_calculator_input_view.dart';
import 'package:core_calculator/loan_calculator/view/flat_vs_reducing_rate/flat_vs_reducing_rate_input_view.dart';
import 'package:core_calculator/loan_calculator/view/flat_vs_reducing_rate/flat_vs_reducing_rate_result_view.dart';
import 'package:core_calculator/loan_calculator/view/home_loan/home_loan_calculator_input_view.dart';
import 'package:core_calculator/tools_module/view/debt_to_income/debt_to_income_input_view.dart';
import 'package:core_calculator/tools_module/view/debt_to_income/debt_to_income_result_view.dart';
import 'package:core_calculator/tools_module/view/loan_eligibility/loan_affordability_input_view.dart';
import 'package:core_calculator/tools_module/view/loan_eligibility/loan_affordability_result_view.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:flutter/material.dart';

MaterialPageRoute coreCalculatorRouteGenerator(RouteSettings settings) {
  switch (settings.name) {
    case CoreCalculatorRoutes.emiHome:
      return MaterialPageRoute(
        builder: (_) => const CalculatorHomeView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.emiHome),
      );
    case CoreCalculatorRoutes.emiInput:
      return MaterialPageRoute(
        builder: (_) => const EmiCalculatorInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.emiInput),
      );
    case CoreCalculatorRoutes.emiResult:
      return MaterialPageRoute(
        builder: (_) => const EmiResultView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.emiResult),
      );
    case CoreCalculatorRoutes.emiTenureInput:
      return MaterialPageRoute(
        builder: (_) => const EmiTenureCalculatorInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.emiTenureInput),
      );
    case CoreCalculatorRoutes.carLoanInput:
      return MaterialPageRoute(
        builder: (_) => const CarLoanCalculatorInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.carLoanInput),
      );
    case CoreCalculatorRoutes.carBuyingLoanInput:
      return MaterialPageRoute(
        builder: (_) => const CarBuyingCalculatorInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.carBuyingLoanInput),
      );
    case CoreCalculatorRoutes.homeLoanInput:
      return MaterialPageRoute(
        builder: (_) => const HomeLoanCalculatorInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.homeLoanInput),
      );
    case CoreCalculatorRoutes.flatVsReducingInput:
      return MaterialPageRoute(
        builder: (_) => const FlatVsReducingRateInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.flatVsReducingInput),
      );
    case CoreCalculatorRoutes.flatVsReducingResult:
      return MaterialPageRoute(
        builder: (_) => const FlatVsReducingRateResultView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.flatVsReducingResult),
      );
    case CoreCalculatorRoutes.debtToIncomeInput:
      return MaterialPageRoute(
        builder: (_) => const DebtToIncomeInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.debtToIncomeInput),
      );
    case CoreCalculatorRoutes.debtToIncomeResult:
      return MaterialPageRoute(
        builder: (_) => const DebtToIncomeResultView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.debtToIncomeResult),
      );
    case CoreCalculatorRoutes.loanAffordabilityInput:
      return MaterialPageRoute(
        builder: (_) => const LoanAffordabilityInputView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.loanAffordabilityInput),
      );
    case CoreCalculatorRoutes.loanAffordabilityResult:
      return MaterialPageRoute(
        builder: (_) => const LoanAffordabilityResultView(),
        settings: const RouteSettings(name: CoreCalculatorRoutes.loanAffordabilityResult),
      );
    default:
      return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
              centerTitle: true,
            ),
            body: const Center(
              child: Text(
                'Error ! Something went wrong ',
                style: TextStyle(color: Colors.red, fontSize: 18.0),
              ),
            ),
          );
        },
        settings: const RouteSettings(name: 'error'),
      );
  }
}