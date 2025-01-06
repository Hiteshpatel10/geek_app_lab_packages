part of 'branch_detail_cubit.dart';

@immutable
sealed class BranchDetailState {}

final class BranchDetailInitial extends BranchDetailState {}

final class BranchDetailLoading extends BranchDetailState {}

final class BranchDetailSuccess extends BranchDetailState {
  final BranchDetailModel branchDetail;

  BranchDetailSuccess(this.branchDetail);
}

final class BranchDetailError extends BranchDetailState {
  final String errorMessage;

  BranchDetailError(this.errorMessage);
}
