import 'package:branch_locator/branch_search_module/bloc/branch_detail_cubit.dart';
import 'package:branch_locator/branch_search_module/bloc/search_by_pincode_cubit.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_util.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validator_forge/validator_forge.dart';

class SearchByPincodeView extends StatefulWidget {
  const SearchByPincodeView({super.key});

  @override
  State<SearchByPincodeView> createState() => _SearchByPincodeViewState();
}

class _SearchByPincodeViewState extends State<SearchByPincodeView> {
  late final TextEditingController _textFiledController;
  late final GetBanksInCubit _searchByPincodeCubit;
  late final CoreDebouncer _debouncer;

  @override
  void initState() {
    _textFiledController = TextEditingController();
    _searchByPincodeCubit = BlocProvider.of<GetBanksInCubit>(context);
    _debouncer = CoreDebouncer(milliseconds: 400);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormField(
              controller: _textFiledController,
              textCapitalization: TextCapitalization.characters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 6,
              decoration: const InputDecoration(
                counterText: '',
                prefixIcon: Icon(Icons.search_rounded, size: 22),
                hintText: 'Enter branch name',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                if (value.length != 6) return;

                _debouncer.run(() async {
                  _searchByPincodeCubit.getBanksInPincode(pincode: value);
                });
              },
              validator: (value) {
                return ValidationBuilder().required('Enter branch code').minLength(4).build(value);
              },
            ),
          ),
          BlocBuilder<GetBanksInCubit, GetBanksInState>(
            builder: (context, state) {
              if (state is GetBanksInPincodeSuccess) {
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
                              "district": state.postOffice.result?.districtName,
                              "bank": item,
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: CoreBoxDecoration.getBoxDecoration(),
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
