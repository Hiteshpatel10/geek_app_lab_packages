import 'package:branch_locator/branch_search_module/bloc/search_by_bank_hierarchy_cubit.dart';
import 'package:branch_locator/components/locator_searchable_select.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/components/core_skeleton/core_text_skeleton.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/navigation/core_navigator.dart';
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
  int currentPage = 0;

  late final List<String> stepperTitle;
  @override
  void initState() {
    _searchByBankHierarchyCubit = BlocProvider.of<SearchByBankHierarchyCubit>(context);
    stepperTitle = ["Select Bank", "Select State", "Select District", "Select Branch"];
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
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    stepperTitle.length,
                    (index) {
                      bool isActive = index == currentPage;

                      if (isActive) {
                        return Flexible(
                          child: Column(
                            children: [
                              Text(
                                stepperTitle[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: CoreColors.toryBlue),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isActive ? CoreColors.toryBlue : CoreColors.lavenderMist,
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                        height: 6,
                        width: 40,
                        decoration: BoxDecoration(
                          color: isActive ? CoreColors.toryBlue : CoreColors.lavenderMist,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() => currentPage = value.toInt());
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
                            return _buildShimmerList();
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
                            return _buildShimmerList();
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
                            return _buildShimmerList();
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
                            return _buildShimmerList();
                          }
                          return LocatorSearchableSelect(
                            list: state.bankHierarchy.result?.branch ?? [],
                            onTap: (value) {
                              _branch = value;
                              CoreNavigator.pushNamed(LocatorRoutePaths.branchDetail, arguments: {
                                "post_data": {
                                  "bank_name": _bankName,
                                  "state": _state,
                                  "district": _district,
                                  "branch": _branch,
                                }
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is BankHierarchyLoading) {
            return _buildShimmerList();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          const SizedBox(width: 24),
          if (currentPage != 0)
            OutlinedButton(
              onPressed: () {
                _controller.previousPage(duration: Durations.medium4, curve: Curves.easeIn);
              },
              child: const Text("Back"),
            ),
        ],
      ),
    );
  }

  _buildShimmerList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 50, maxHeight: 50),
          margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 50),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: CoreTextSkeleton(
            fontSize: 14,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
        );
      },
    );
  }
}
