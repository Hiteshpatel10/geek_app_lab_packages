import 'package:branch_locator/branch_search_module/bloc/branch_detail_cubit.dart';
import 'package:branch_locator/branch_search_module/bloc/search_by_bank_hierarchy_cubit.dart';
import 'package:branch_locator/branch_search_module/bloc/search_by_pincode_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List locatorBlocInit(){
  return [
    BlocProvider<BranchDetailCubit>(create: (context) => BranchDetailCubit()),
    BlocProvider<SearchByBankHierarchyCubit>(create: (context) => SearchByBankHierarchyCubit()),
    BlocProvider<GetBanksInCubit>(create: (context) => GetBanksInCubit()),
  ];
}