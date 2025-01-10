import 'package:bloc/bloc.dart';
import 'package:branch_locator/branch_search_module/model/post_office_model.dart';
import 'package:branch_locator/util/locator_api_endpoints.dart';
import 'package:core_utility/network/dio_request_template.dart';
import 'package:meta/meta.dart';

part 'search_by_pincode_state.dart';

class GetBanksInCubit extends Cubit<GetBanksInState> {
  GetBanksInCubit() : super(GetBanksInInitial());

  getBanksInPincode({required String pincode}) async {
    try {
      emit(GetBanksInLoading());

      final pinCodeResponse = await getRequest(
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: '${LocatorApiEndpoints.getPostOffice}/$pincode',
      );

      final model = PostOfficeModel.fromJson(pinCodeResponse);

      final response = await postRequest(
        postData: {
          "state": model.result?.stateName,
        },
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: LocatorApiEndpoints.getBanksIn,
      );

      List<String> banks = [];
      if (response['result'] != null) {
        banks = [];
        response['result'].forEach((v) {
          banks.add(v);
        });
      }

      emit(GetBanksInPincodeSuccess(banks, model));
    } catch (e) {
      emit(GetBanksInError('An error occurred: $e'));
    }
  }

  getBanksInBranch({required String branch}) async {
    try {
      emit(GetBanksInLoading());

      final response = await postRequest(
        postData: {
          "branch": branch,
        },
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: LocatorApiEndpoints.getBanksIn,
      );

      List<String> banks = [];
      if (response['result'] != null) {
        banks = [];
        response['result'].forEach((v) {
          banks.add(v);
        });
      }

      emit(GetBanksInSuccess(banks, branch));
    } catch (e) {
      emit(GetBanksInError('An error occurred: $e'));
    }
  }
}
