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

  @override
  void initState() {
    final searchByBankHierarchyCubit = BlocProvider.of<SearchByBankHierarchyCubit>(context);

    searchByBankHierarchyCubit.getBankHierarchy();
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
                final searchByBankHierarchyCubit =
                    BlocProvider.of<SearchByBankHierarchyCubit>(context);

                searchByBankHierarchyCubit.getBankHierarchy(
                  bankName: "HDFC Bank",
                );
              },
              children: [
                LocatorSearchableSelect(list: state.bankHierarchy.result?.banks ?? []),
                LocatorSearchableSelect(list: state.bankHierarchy.result?.states ?? []),
                LocatorSearchableSelect(list: state.bankHierarchy.result?.districts ?? []),
                LocatorSearchableSelect(list: state.bankHierarchy.result?.branch ?? []),
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
