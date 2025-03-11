part of 'debt_to_income_cubit.dart';

@immutable
sealed class DebtToIncomeState {}

final class DebtToIncomeInitial extends DebtToIncomeState {}

class DebtToIncomeCalculated extends DebtToIncomeState {
  final double ratio;
  DebtToIncomeCalculated(this.ratio);
}