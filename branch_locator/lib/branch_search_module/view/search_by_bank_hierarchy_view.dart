import 'package:branch_locator/branch_search_module/bloc/search_by_bank_hierarchy_cubit.dart';
import 'package:branch_locator/components/locator_searchable_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchByBankHierarchyView extends StatefulWidget {
  const SearchByBankHierarchyView({super.key});

  @override
  State<SearchByBankHierarchyView> createState() => _SearchByBankHierarchyViewState();
}

class _SearchByBankHierarchyViewState extends State<SearchByBankHierarchyView> {
  final _controller = PageController();
  late final SearchByBankHierarchyCubit _searchByBankHierarchyCubit;
  String? _bankName;
  String? _state;
  String? _district;
  String? _branch;
  @override
  void initState() {
    _searchByBankHierarchyCubit = BlocProvider.of<SearchByBankHierarchyCubit>(context);

    _searchByBankHierarchyCubit.getBankHierarchy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchByBankHierarchyCubit, SearchByBankHierarchyState>(
        builder: (context, state) {
          if (state is BankHierarchySuccess) {
            return PageView(
              controller: _controller,
              onPageChanged: (value) {
                _searchByBankHierarchyCubit.getBankHierarchy(
                  bankName: _bankName,
                  district: _district,
                  state: _state,
                  showLoading: false,
                );
              },
              children: [
                StreamBuilder<bool>(
                  stream: _searchByBankHierarchyCubit.isLoading,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return LocatorSearchableSelect(
                      list: state.bankHierarchy.result?.banks ?? [],
                      onTap: (value) {
                        _bankName = value;
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear,
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: _searchByBankHierarchyCubit.isLoading,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return LocatorSearchableSelect(
                      list: state.bankHierarchy.result?.states ?? [],
                      onTap: (value) {
                        _state = value;
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear,
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: _searchByBankHierarchyCubit.isLoading,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return LocatorSearchableSelect(
                      list: state.bankHierarchy.result?.districts ?? [],
                      onTap: (value) {
                        _district = value;
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear,
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: _searchByBankHierarchyCubit.isLoading,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return LocatorSearchableSelect(
                      list: state.bankHierarchy.result?.branch ?? [],
                      onTap: (value) {
                        _branch = value;
                      },
                    );
                  },
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
