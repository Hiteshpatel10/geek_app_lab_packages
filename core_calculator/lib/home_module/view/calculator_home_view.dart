import 'package:core_calculator/utils/calculator_assets.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorHomeView extends StatefulWidget {
  const CalculatorHomeView({super.key});

  @override
  State<CalculatorHomeView> createState() => _CalculatorHomeViewState();
}

class _CalculatorHomeViewState extends State<CalculatorHomeView> {
  late final List<GridData> _grid;
  @override
  void initState() {
    _grid = [
      GridData(
        title: "EMI\nCalculator",
        background: CalculatorAssets.emiCalculatorBg,
        crossAxisCellCount: 4,
        mainAxisCellCount: 1.8,
        titleAlign: Alignment.centerLeft,
        path: CoreCalculatorRoutes.emiInput,
        style: const TextStyle(fontSize: 24, color: CoreColors.oil, fontWeight: FontWeight.w700),
      ),
      GridData(
        title: "Loan\nTenure\nCalculator",
        background: CalculatorAssets.loanTenureBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.topLeft,
        path: CoreCalculatorRoutes.emiTenureInput,
      ),
      GridData(
        title: "Flat\nVs\nReducing",
        background: CalculatorAssets.flatVsReducingBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.topLeft,
        path: CoreCalculatorRoutes.flatVsReducingInput,
      ),
      GridData(
        title: "Loan\nAffordability\nCalculator",
        background: CalculatorAssets.loanAffordabilityBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.topLeft,
        path: CoreCalculatorRoutes.loanAffordabilityInput,
      ),
      GridData(
        title: "Debt\nto\nIncome\nCalculator",
        background: CalculatorAssets.debtToIncomeBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.bottomLeft,
        path: CoreCalculatorRoutes.debtToIncomeInput,
      ),
      GridData(
        title: "Home\nLoan\nCalculator",
        background: CalculatorAssets.homeLoanBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.topLeft,
        path: CoreCalculatorRoutes.homeLoanInput,
      ),
      GridData(
        title: "Car\nLoan\nCalculator",
        background: CalculatorAssets.carLoanBg,
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        titleAlign: Alignment.topLeft,
        path: CoreCalculatorRoutes.carLoanInput,
      ),
      GridData(
        title: "Car\nAffordability\nCalculator",
        background: CalculatorAssets.carAffordabilityBg,
        crossAxisCellCount: 4,
        mainAxisCellCount: 1.8,
        titleAlign: Alignment.centerLeft,
        path: CoreCalculatorRoutes.carBuyingLoanInput,
        style: const TextStyle(fontSize: 24, color: CoreColors.oil, fontWeight: FontWeight.w700),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 40),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(
            _grid.length,
            (index) {
              final item = _grid[index];
              return StaggeredGridTile.count(
                crossAxisCellCount: item.crossAxisCellCount,
                mainAxisCellCount: item.mainAxisCellCount,
                child: GestureDetector(
                  onTap: () {
                    CoreNavigator.pushNamed(item.path);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: CoreBoxDecoration.getSmoothBoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(item.background),
                      ),
                    ),
                    child: Align(
                      alignment: item.titleAlign,
                      child: Text(
                        item.title,
                        style: item.style ??
                            Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: CoreColors.oil, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GridData {
  GridData({
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.background,
    required this.title,
    required this.titleAlign,
    required this.path,
    this.style,
  });

  final int crossAxisCellCount;
  final double mainAxisCellCount;
  final String background;
  final String title;
  final TextStyle? style;
  final Alignment titleAlign;
  final String path;
}
