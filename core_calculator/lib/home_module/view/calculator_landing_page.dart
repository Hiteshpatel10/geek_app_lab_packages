import 'package:core_utility/core_model/core_key_value_pair_model.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:flutter/material.dart';

class CalculatorLandingView extends StatelessWidget {
  const CalculatorLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            Text(
              "EMI Calculator",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            ...List.generate(
              data.length,
              (index) {
                final item = data[index];
                return _buildMainCard(
                  context,
                  route: item.value,
                  title: item.key,
                  asset: item.extra!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context, {
    required String route,
    required String title,
    required String asset,
  }) {
    return GestureDetector(
      onTap: () {
        CoreNavigator.pushNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: CoreBoxDecoration.getBoxDecoration(
          addBorder: true,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Image.asset(
              asset,
              width: 100,
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

final List<CoreKeyValuePairModel<String, String, String>> data = [
  CoreKeyValuePairModel(
    key: "EMI Calculator",
    value: CoreCalculatorRoutes.emiInput,
    extra: 'assets/icons/emi.png',
  ),
  CoreKeyValuePairModel(
    key: "EMI Tenure Calculator",
    value: CoreCalculatorRoutes.emiTenureInput,
    extra: 'assets/icons/tenure.png',
  ),
  CoreKeyValuePairModel(
    key: "Flat Vs Reducing",
    value: CoreCalculatorRoutes.flatVsReducingInput,
    extra: 'assets/icons/coin_stack.png',
  ),
  CoreKeyValuePairModel(
    key: "Home Loan Calculator",
    value: CoreCalculatorRoutes.homeLoanInput,
    extra: 'assets/icons/home_loan.png',
  ),
  CoreKeyValuePairModel(
    key: "Car Loan Calculator",
    value: CoreCalculatorRoutes.carLoanInput,
    extra: 'assets/icons/car_loan.png',
  ),
  CoreKeyValuePairModel(
    key: "Car Affordability",
    value: CoreCalculatorRoutes.carBuyingLoanInput,
    extra: 'assets/icons/car_cart.png',
  ),
];
