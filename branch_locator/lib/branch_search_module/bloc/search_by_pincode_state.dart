part of 'search_by_pincode_cubit.dart';

@immutable
sealed class GetBanksInState {}

final class GetBanksInInitial extends GetBanksInState {}

final class GetBanksInLoading extends GetBanksInState {}

final class GetBanksInPincodeSuccess extends GetBanksInState {
  final List<String> banks;
  final PostOfficeModel postOffice;

  GetBanksInPincodeSuccess(this.banks, this.postOffice);
}

final class GetBanksInSuccess extends GetBanksInState {
  final List<String> banks;
  final String query;

  GetBanksInSuccess(this.banks, this.query);
}

final class GetBanksInError extends GetBanksInState {
  final String errorMessage;

  GetBanksInError(this.errorMessage);
}
