import 'package:core_calculator/tools_module/bloc/debt_to_income_cubit.dart';
import 'package:core_utility/extensions/string_extensions.dart';
import 'package:core_utility/navigation/core_calculator_routes.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/validators/input_formatter/amount_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_builder.dart';
import 'package:validator_forge/validators.dart';

class DebtToIncomeInputView extends StatefulWidget {
  const DebtToIncomeInputView({super.key});

  @override
  State<DebtToIncomeInputView> createState() => _DebtToIncomeInputViewState();
}

class _DebtToIncomeInputViewState extends State<DebtToIncomeInputView> {
  final _formKey = GlobalKey<FormState>();

  late final DebtToIncomeCubit _debtToIncomeCubit;

  final PageController pageView = PageController();
  // Controllers for income fields
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController freelanceController = TextEditingController();
  final TextEditingController rentalController = TextEditingController();
  final TextEditingController businessController = TextEditingController();

  // Controllers for debt fields
  final TextEditingController homeLoanController = TextEditingController();
  final TextEditingController carLoanController = TextEditingController();
  final TextEditingController personalLoanController = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();
  final TextEditingController otherDebtsController = TextEditingController();

  @override
  void initState() {
    _debtToIncomeCubit = BlocProvider.of<DebtToIncomeCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    salaryController.dispose();
    freelanceController.dispose();
    rentalController.dispose();
    businessController.dispose();
    homeLoanController.dispose();
    carLoanController.dispose();
    personalLoanController.dispose();
    creditCardController.dispose();
    otherDebtsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debt-to-Income Calculator")),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: pageView,
          children: [
            _buildIncomeSection(),
            _buildDebtSection(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ElevatedButton(
          onPressed: () {

            if(_formKey.currentState?.validate() == false){
              return;
            }

            if (pageView.page == 0) {
              pageView.nextPage(duration: Durations.medium4, curve: Curves.easeIn);
              return;
            }

            _debtToIncomeCubit.updateIncome(
              business: businessController.text.toAmountFromINR(),
              freelance: freelanceController.text.toAmountFromINR(),
              rental: rentalController.text.toAmountFromINR(),
              salary: salaryController.text.toAmountFromINR(),
            );

            _debtToIncomeCubit.updateDebt(
              carLoan: carLoanController.text.toAmountFromINR(),
              creditCard: creditCardController.text.toAmountFromINR(),
              homeLoan: homeLoanController.text.toAmountFromINR(),
              otherDebts: otherDebtsController.text.toAmountFromINR(),
              personalLoan: personalLoanController.text.toAmountFromINR(),
            );

            _debtToIncomeCubit.calculateDebtToIncomeRatio();

            CoreNavigator.pushNamed(CoreCalculatorRoutes.debtToIncomeResult);
          },
          child: const Text("Next"),
        ),
      ),
    );
  }

  Widget _buildIncomeSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Income Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildNumberInput(
            "Salary Per Month",
            "Enter your monthly salary",
            salaryController,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Freelance Income",
            "Enter your freelance earnings (if any)",
            freelanceController,
            isOptional: true,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Rental Income",
            "Enter your rental income (if any)",
            rentalController,
            isOptional: true,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Business Income",
            "Enter your business income (if any)",
            businessController,
            isOptional: true,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDebtSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNumberInput(
            "Home Loan EMI",
            "Enter your home loan EMI",
            homeLoanController,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Car Loan EMI",
            "Enter your car loan EMI",
            carLoanController,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Personal Loan EMI",
            "Enter your personal loan EMI",
            personalLoanController,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Credit Card Minimum Payments",
            "Enter your credit card dues",
            creditCardController,
          ),
          const SizedBox(height: 12),
          _buildNumberInput(
            "Other Debts",
            "Enter any other debts (if any)",
            otherDebtsController,
            isOptional: true,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildNumberInput(
    String label,
    String hint,
    TextEditingController controller, {
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
      inputFormatters: [AmountInputFormatter()],
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (isOptional) {
          return null;
        }
        final amount = value?.toAmountFromINR();
        return validatorBuilder([
          () => Validators.required(value),
          () => Validators.minimum(amount, 0),
        ]);
      },
    );
  }
}
