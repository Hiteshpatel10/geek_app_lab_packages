import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:branch_locator/branch_search_module/model/branch_detail_model.dart';
import 'package:branch_locator/branch_search_module/model/post_office_model.dart';
import 'package:branch_locator/util/locator_api_endpoints.dart';
import 'package:core_utility/network/dio_request_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'branch_detail_state.dart';

class BranchDetailCubit extends Cubit<BranchDetailState> {
  BranchDetailCubit() : super(BranchDetailInitial());

  getBranchDetail({required Map<String, dynamic> postData}) async {
    try {
      emit(BranchDetailLoading());

      final response = await postRequest(
        postData: postData,
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: LocatorApiEndpoints.getBranchBy,
      );

      final model = BranchDetailModel.fromJson(response);

      emit(BranchDetailSuccess(model));
    } catch (e) {
      emit(BranchDetailError('An error occurred: $e'));
    }
  }

  Future<PostOfficeModel?> getPostOffice({required String pincode}) async {
    try {
      final response = await getRequest(
        requestFrom: RequestFrom.branchLocator,
        apiEndPoint: '${LocatorApiEndpoints.getPostOffice}/$pincode',
      );

      final model = PostOfficeModel.fromJson(response);

      return model;
    } catch (e) {
      return null;
    }
  }

  onInit(){
    emit(BranchDetailInitial());
  }
}
