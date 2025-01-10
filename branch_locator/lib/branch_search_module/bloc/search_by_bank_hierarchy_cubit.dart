import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:branch_locator/branch_search_module/model/bank_hierarchy_model.dart';
import 'package:branch_locator/util/locator_api_endpoints.dart';
import 'package:core_utility/network/dio_request_template.dart';
import 'package:meta/meta.dart';

part 'search_by_bank_hierarchy_state.dart';

class SearchByBankHierarchyCubit extends Cubit<SearchByBankHierarchyState> {
  SearchByBankHierarchyCubit() : super(SearchByBankHierarchyInitial()) {
    _loadingController = StreamController<bool>.broadcast();
    isLoading = _loadingController.stream;
  }

  late final StreamController<bool> _loadingController;
  late final Stream<bool> isLoading;

  Future<void> getBankHierarchy({String? bankName, String? state, String? district, bool showLoading = true}) async {
    try {
      _loadingController.add(true);
      if(showLoading) emit(BankHierarchyLoading());

      final postData = {
        if (bankName != null) "bank": bankName,
        if (bankName != null && state != null) "state": state,
        if (bankName != null && state != null && district != null) "district": district,
      };

      final response = await postRequest(
        postData: postData,
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: LocatorApiEndpoints.bankingHierarchy,
      );

      final model = BankHierarchyModel.fromJson(response);

      emit(BankHierarchySuccess(model));
    } catch (e) {
      emit(BankHierarchyError('An error occurred: $e'));
    } finally {
      _loadingController.add(false);
    }
  }

  @override
  Future<void> close() {
    _loadingController.close();
    return super.close();
  }
}
