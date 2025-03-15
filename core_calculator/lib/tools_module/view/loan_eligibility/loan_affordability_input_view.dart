import 'package:core_calculator/components/core_tenure_selector.dart';
import 'package:core_calculator/tools_module/bloc/loan_affordability/loan_affordability_cubit.dart';
import 'package:core_calculator/utils/calculator_enums.dart';
import 'package:core_utility/core_validators.dart';
import 'package:core_utility/extensions/string_extensions.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_builder.dart';
import 'package:validator_forge/validators.dart';

class LoanAffordabilityInputView extends StatefulWidget {
  const LoanAffordabilityInputView({super.key});

  @override
  State<LoanAffordabilityInputView> createState() => _LoanAffordabilityInputViewState();
}

class _LoanAffordabilityInputViewState extends State<LoanAffordabilityInputView> {
  final _amountController = TextEditingController(text: '5,00,000');
  final _incomeController = TextEditingController(text: '1,00,000');
  final _monthlyDebtController = TextEditingController(text: '15,000');
  final _interestRateController = TextEditingController(text: '8.5%');
  final _tenureController = TextEditingController(text: '15');

  TenureType _selectedTenureType = TenureType.years;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ..._buildForm(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == false) {
                return;
              }

              int duration = int.tryParse((_tenureController.text)) ?? 0;

              if (_selectedTenureType == TenureType.years) {
                duration = duration * 12;
              }

              BlocProvider.of<LoanAffordabilityCubit>(context).calculateLoanAffordability(
                monthlyIncome: _incomeController.text.toAmountFromINR(),
                interestRate: _interestRateController.text.toRate(),
                loanAmount: _amountController.text.toAmountFromINR(),
                monthlyDebt: _monthlyDebtController.text.toAmountFromINR(),
                tenureMonths: duration,
              );

              CoreNavigator.pushNamed(CoreCalculatorRoutes.loanAffordabilityResult);
            },
            child: const Text("Calculate"),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildForm() {
    return [
      TextFormField(
        controller: _amountController,
        decoration: const InputDecoration(
          labelText: 'Loan Amount',
          hintText: 'Enter your loan amount',
        ),
        inputFormatters: [
          AmountInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) {
          final amount = value.toAmountFromINR();

          final error = validatorBuilder([
            () => Validators.required(value),
            () => Validators.minimum(amount, 5000),
            () => Validators.maximum(amount, 20000000),
          ]);

          return error;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _incomeController,
        decoration: const InputDecoration(
          labelText: 'Monthly Income',
          hintText: 'Enter your monthly income',
        ),
        inputFormatters: [
          AmountInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) {
          final income = value.toAmountFromINR();

          final error = validatorBuilder([
            () => Validators.required(value),
            () => Validators.minimum(income, 10000),
          ]);

          return error;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _monthlyDebtController,
        decoration: const InputDecoration(
          labelText: 'Monthly Debt Payment',
          hintText: 'Enter your monthly debt payment',
        ),
        inputFormatters: [
          AmountInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) {
          final debt = value.toAmountFromINR();

          final error = validatorBuilder([
            () => Validators.required(value),
            () => Validators.minimum(debt, 0),
          ]);

          return error;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _interestRateController,
        decoration: const InputDecoration(
          labelText: 'Interest rate',
          hintText: 'Enter your interest rate',
        ),
        inputFormatters: [
          PercentageInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) {
          final rate = num.tryParse((value ?? '').replaceAll('%', ''));
          final error = validatorBuilder([
            () => Validators.required(value),
            () => Validators.minimum(rate, 6),
            () => Validators.maximum(rate, 40),
          ]);
          return error;
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        controller: _tenureController,
        decoration: InputDecoration(
          labelText: 'Interest tenure',
          hintText: 'Enter your loan tenure',
          suffixIcon: getTenureSelector(
            context,
            selectedTenure: _selectedTenureType,
            onTenureChange: (tenureType) {
              setState(() {
                _selectedTenureType = tenureType;
              });
            },
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        validator: (String? value) {
          final duration = num.tryParse((value ?? ''));
          String? error;
          if (_selectedTenureType == TenureType.years) {
            error = validatorBuilder([
              () => Validators.required(value),
              () => Validators.minimum(duration, 1),
              () => Validators.maximum(duration, 40),
            ]);
          } else {
            error = validatorBuilder([
              () => Validators.required(value),
              () => Validators.minimum(duration, 12),
              () => Validators.maximum(duration, 480),
            ]);
          }

          return error;
        },
      ),
    ];
  }
}
