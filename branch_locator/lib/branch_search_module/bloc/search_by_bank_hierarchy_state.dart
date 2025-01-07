part of 'search_by_bank_hierarchy_cubit.dart';

@immutable
sealed class SearchByBankHierarchyState {}

final class SearchByBankHierarchyInitial extends SearchByBankHierarchyState {}

final class BankHierarchyLoading extends SearchByBankHierarchyState {}

final class BankHierarchySuccess extends SearchByBankHierarchyState {
  final BankHierarchyModel bankHierarchy;

  BankHierarchySuccess(this.bankHierarchy);
}

final class BankHierarchyError extends SearchByBankHierarchyState {
  final String errorMessage;

  BankHierarchyError(this.errorMessage);
}
