import 'package:bloc/bloc.dart';
import 'package:branch_locator/branch_search_module/model/bank_hierarchy_model.dart';
import 'package:branch_locator/util/locator_api_endpoints.dart';
import 'package:core_utility/network/dio_request_template.dart';
import 'package:meta/meta.dart';

part 'search_by_bank_hierarchy_state.dart';

class SearchByBankHierarchyCubit extends Cubit<SearchByBankHierarchyState> {
  SearchByBankHierarchyCubit() : super(SearchByBankHierarchyInitial());


  getBankHierarchy({String? bankName, String? state, String? district}) async {
    try {
      // emit(BankHierarchyLoading());

      final postData = {
        if (bankName != null) "bank_name": bankName,
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
    }
  }
}
