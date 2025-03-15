import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:core_calculator/loan_calculator/functions/emi_function.dart';
import 'package:meta/meta.dart';

part 'loan_affordability_state.dart';

class LoanAffordabilityCubit extends Cubit<LoanAffordabilityState> {
  LoanAffordabilityCubit() : super(LoanAffordabilityInitial());

  void calculateLoanAffordability({
    required double loanAmount,
    required double monthlyIncome,
    required double monthlyDebt,
    required double interestRate,
    required int tenureMonths,
  }) {
    try {
      // Calculate EMI
      double monthlyRate = interestRate / 12 / 100;
      double emi = _calculateEMI(loanAmount, monthlyRate, tenureMonths);

      final emiModel = performEMICalculation(
        principal: loanAmount,
        annualInterestRate: interestRate,
        emi: emi,
        numberOfMonths: tenureMonths,
      );
      double dti = ((monthlyDebt + emi) / monthlyIncome) * 100;

      // Determine safe loan limit
      double maxAffordableLoan = _calculateMaxAffordableLoan(
        monthlyIncome,
        monthlyDebt,
        interestRate,
        tenureMonths,
      );

      // Emit results to update UI
      emit(LoanAffordabilityCalculated(
        emi: emiModel,
        dti: dti,
        maxAffordableLoan: maxAffordableLoan,
        status: _determineAffordability(dti),
        monthlyDebt: monthlyDebt,
        monthlyIncome: monthlyIncome,
      ));
    } catch (e) {
      emit(LoanAffordabilityError(message: "Invalid input values!"));
    }
  }

  double _calculateEMI(double principal, double rate, int months) {
    if (rate == 0) return principal / months;
    return (principal * rate * pow(1 + rate, months)) / (pow(1 + rate, months) - 1);
  }

  double _calculateMaxAffordableLoan(
    double grossMonthlyIncome,
    double monthlyDebt,
    double rate,
    int months,
  ) {
    double maxDTI = 0.35; // 35% ideal limit
    double maxEMI = maxDTI * grossMonthlyIncome;
    double low = 0, high = 2e8; // Arbitrary upper limit
    double mid, calculatedEMI;

    while (high - low > 1000) {
      // Precision limit
      mid = (low + high) / 2;
      calculatedEMI = _calculateEMI(mid, rate, months);
      if (calculatedEMI > maxEMI) {
        high = mid;
      } else {
        low = mid;
      }
    }
    return high;
  }

  String _determineAffordability(double dti) {
    if (dti <= 35) return "Affordable";
    if (dti <= 40) return "Manageable but Risky";
    return "Too High";
  }
}
