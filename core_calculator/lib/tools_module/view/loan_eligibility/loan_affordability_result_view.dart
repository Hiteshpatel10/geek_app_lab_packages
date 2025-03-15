import 'package:core_calculator/loan_calculator/functions/emi_function.dart';
import 'package:core_calculator/tools_module/bloc/loan_affordability/loan_affordability_cubit.dart';
import 'package:core_utility/core_model/core_key_value_pair_model.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:core_utility/extensions/num_extensions.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanAffordabilityResultView extends StatelessWidget {
  const LoanAffordabilityResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loan Affordability Result")),
      body: BlocBuilder<LoanAffordabilityCubit, LoanAffordabilityState>(
        builder: (context, state) {
          if (state is LoanAffordabilityCalculated) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  _buildInfoTile(
                    context,
                    title: "Loan Affordability",
                    value: state.status,
                    valueColor: state.dti >= 40 ? CoreColors.cadmiumRed : CoreColors.toryBlue,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    context,
                    title: "Maximum Affordable EMI",
                    value: format2INR(state.maxAffordableLoan),
                  ),
                  if (state.dti > 40) ...[
                    const SizedBox(height: 16),
                    _buildWarning(
                      context,
                      title: "⚠️ High DTI Alert!",
                      message: "Your DTI is too high, consider reducing your loan amount.",
                    ),
                  ],
                  const SizedBox(height: 20),
                  _buildEMISummary(context, state.emi),
                  const SizedBox(height: 24),
                  _buildIncomeVsDebtChart(context, state),
                ],
              ),
            );
          } else if (state is LoanAffordabilityError) {
            return _buildWarning(
              context,
              title: "❌ Error",
              message: state.message,
            );
          }
          return const SizedBox(); // Default empty UI
        },
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, {required String title, required String value, Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: CoreBoxDecoration.getBoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: valueColor ?? CoreColors.oil,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEMISummary(BuildContext context, CoreEMIModel state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("EMI Summary", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: CoreBoxDecoration.getBoxDecoration(color: CoreColors.hintOfGreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Monthly EMI", style: Theme.of(context).textTheme.titleSmall),
                  Text(
                    format2INR(state.emi),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: CoreColors.oil.withOpacity(0.2)),
              const SizedBox(height: 12),
              _buildDetailRow("Loan Amount", format2INR(state.loanAmount)),
              _buildDetailRow("Interest Rate", state.interestRate.toPercent()),
              _buildDetailRow("Tenure", "${state.tenure} Months"),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailTile(context, "Total Interest Paid", format2INR(state.interestPaid)),
        _buildDetailTile(context, "Total Repayment", format2INR(state.totalRepayment)),
      ],
    );
  }

  Widget _buildDetailRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(color: CoreColors.oil.withOpacity(0.7))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDetailTile(BuildContext context, String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 8),
      decoration: CoreBoxDecoration.getBoxDecoration(),
      child: Row(
        children: [
          Text(key, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildIncomeVsDebtChart(BuildContext context, LoanAffordabilityCalculated state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Income vs Debt", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: state.monthlyIncome,
                  title: "Income",
                  color: Colors.green.shade400,
                  radius: 70,
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                ),
                PieChartSectionData(
                  value: state.monthlyDebt,
                  title: "Debt",
                  color: Colors.red.shade400,
                  radius: 70,
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWarning(BuildContext context, {required String title, required String message}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: CoreBoxDecoration.getBoxDecoration(
        addBorder: true,
        border: Border.all(color: CoreColors.cadmiumRed),
        color: CoreColors.forgotMeNot,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CoreColors.cadmiumRed)),
          const SizedBox(height: 4),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
