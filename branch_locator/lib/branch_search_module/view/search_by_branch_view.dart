import 'package:branch_locator/branch_search_module/bloc/search_by_pincode_cubit.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_util.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_forge.dart';

class SearchByBranchView extends StatefulWidget {
  const SearchByBranchView({super.key});

  @override
  State<SearchByBranchView> createState() => _SearchByBranchViewState();
}

class _SearchByBranchViewState extends State<SearchByBranchView> {
  late final TextEditingController _textFiledController;
  late final CoreDebouncer _debouncer;
  late final GetBanksInCubit _searchByPincodeCubit;

  @override
  void initState() {
    _textFiledController = TextEditingController();
    _searchByPincodeCubit = BlocProvider.of<GetBanksInCubit>(context)..onInit();

    _debouncer = CoreDebouncer(milliseconds: 400);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search by Branch"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormField(
              controller: _textFiledController,
              textCapitalization: TextCapitalization.characters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 30,
              decoration: const InputDecoration(
                counterText: '',
                prefixIcon: Icon(Icons.search_rounded, size: 22),
                hintText: 'Enter branch name',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                _debouncer.run(() {
                  _debouncer.run(() async {
                    _searchByPincodeCubit.getBanksInBranch(branch: value);
                  });
                });
              },
              validator: (value) {
                return ValidationBuilder().required('Enter branch code').minLength(4).build(value);
              },
            ),
          ),
          BlocBuilder<GetBanksInCubit, GetBanksInState>(
            builder: (context, state) {
              if (state is GetBanksInSuccess) {
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.banks.length,
                    itemBuilder: (context, index) {
                      final item = state.banks[index];
                      return GestureDetector(
                        onTap: () {
                          CoreNavigator.pushNamed(LocatorRoutePaths.branchList, arguments: {
                            "post_data": {
                              "branch": state.query,
                              "bank": item,
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: CoreBoxDecoration.getBoxDecoration(),
                          child: Text(
                            item ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is GetBanksInLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is GetBanksInError) {
                return const Center(child: Text("Something went wrong"));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
