part of 'loan_affordability_cubit.dart';

@immutable
abstract class LoanAffordabilityState {}

class LoanAffordabilityInitial extends LoanAffordabilityState {}

class LoanAffordabilityCalculated extends LoanAffordabilityState {
  final CoreEMIModel emi;
  final double dti;
  final double maxAffordableLoan;
  final double monthlyDebt;
  final double monthlyIncome;
  final String status;

  LoanAffordabilityCalculated({
    required this.emi,
    required this.dti,
    required this.maxAffordableLoan,
    required this.status,
    required this.monthlyDebt,
    required this.monthlyIncome,
  });
}

class LoanAffordabilityError extends LoanAffordabilityState {
  final String message;

  LoanAffordabilityError({required this.message});
}
