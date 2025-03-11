import 'package:core_calculator/tools_module/bloc/debt_to_income_cubit.dart';
import 'package:core_utility/core_mode.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtToIncomeResultView extends StatefulWidget {
  const DebtToIncomeResultView({super.key});

  @override
  State<DebtToIncomeResultView> createState() => _DebtToIncomeResultViewState();
}

class _DebtToIncomeResultViewState extends State<DebtToIncomeResultView> {
  late final DebtToIncomeCubit _debtToIncomeCubit;

  @override
  void initState() {
    _debtToIncomeCubit = BlocProvider.of<DebtToIncomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "${_debtToIncomeCubit.dtiRatio}%",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: dtiColor(_debtToIncomeCubit.dtiRatio), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              dtiText(_debtToIncomeCubit.dtiRatio),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Income Vs Debt",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CoreColors.oil),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: _debtToIncomeCubit.totalIncome,
                      title: "Income",
                      color: Colors.green,
                      radius: 60,
                    ),
                    PieChartSectionData(
                      value: _debtToIncomeCubit.totalDebt,
                      title: "Debt",
                      color: Colors.red,
                      radius: 60,
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 12),
            debtToIncomeTable(
              debtList: _debtToIncomeCubit.debtList,
              incomeList: _debtToIncomeCubit.incomeList,
              totalDebt: _debtToIncomeCubit.totalDebt,
              totalIncome: _debtToIncomeCubit.totalIncome,
            ),
          ],
        ),
      ),
    );
  }

  Widget debtToIncomeTable({
    required List<CoreKeyValuePairModel<String, double, dynamic>> incomeList,
    required List<CoreKeyValuePairModel<String, double, dynamic>> debtList,
    required double totalIncome,
    required double totalDebt,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          // Income Section Header
          const DataRow(cells: [
            DataCell(
              Text(
                'Income',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
              ),
            ),
            DataCell(
              Text(''),
            ),
          ]),

          // Income Rows
          ...incomeList.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.key)),
                  DataCell(Text(format2INR(item.value))),
                ],
              )),

          // Total Income
          DataRow(
            cells: [
              const DataCell(
                Text(
                  'Total Income',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              DataCell(
                Text(
                  format2INR(totalIncome),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ],
          ),

          // Blank row for separation
          const DataRow(
            cells: [
              DataCell(SizedBox(height: 10)),
              DataCell(
                SizedBox(height: 10),
              ),
            ],
          ),

          // Debt Section Header
          const DataRow(cells: [
            DataCell(
              Text(
                'Debt',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
              ),
            ),
            DataCell(Text('')),
          ]),

          // Debt Rows
          ...debtList.map((item) => DataRow(
                cells: [
                  DataCell(Text(item.key)),
                  DataCell(Text(format2INR(item.value))),
                ],
              )),

          // Total Debt
          DataRow(
            cells: [
              const DataCell(
                Text(
                  'Total Debt',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              DataCell(
                Text(
                  format2INR(totalDebt),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String dtiText(double dtiRatio) {
    if (dtiRatio < 20) {
      return "Excellent! Your debt level is very low.";
    } else if (dtiRatio >= 20 && dtiRatio < 36) {
      return "Good! You have a healthy balance between debt and income.";
    } else if (dtiRatio >= 36 && dtiRatio < 43) {
      return "Caution! Your debt is getting high, consider reducing it.";
    } else if (dtiRatio >= 43 && dtiRatio < 50) {
      return "Risky! Lenders may see this as a red flag.";
    } else {
      return "Critical! Your debt level is too high. Immediate action needed!";
    }
  }

  Color dtiColor(double dtiRatio) {
    if (dtiRatio < 20) {
      return Colors.green;
    } else if (dtiRatio >= 20 && dtiRatio < 36) {
      return Colors.lightGreen;
    } else if (dtiRatio >= 36 && dtiRatio < 43) {
      return Colors.orange;
    } else if (dtiRatio >= 43 && dtiRatio < 50) {
      return Colors.redAccent;
    } else {
      return Colors.red;
    }
  }
}
