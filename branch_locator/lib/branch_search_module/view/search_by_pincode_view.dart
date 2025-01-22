import 'package:branch_locator/branch_search_module/bloc/search_by_pincode_cubit.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_util.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
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
      appBar: AppBar(
        title: const Text("Search by Pincode"),
      ),
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
                hintText: 'Enter Postal Code (PIN Code)',
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
                return ValidationBuilder().required('Enter pincode code').minLength(4).build(value);
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

              if (state is GetBanksInLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is GetBanksInError) {
                return const Center(child: Text("Something went wrong"));
              }
              return Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: _buildSuggestion(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "What is an Indian Postal Code (PIN Code)?\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    'The Postal Index Number (PIN) is a unique 6-digit code used by India Post to identify specific locations for mail delivery. It helps to organize and simplify the delivery of letters and packages across India.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "How to Find a Postal Code (PIN Code)?\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: 'To find a postal code (PIN code), you can use the following methods:\n\n'
                    '**Use the India Post Website:**\n'
                    'The official India Post website allows you to search for PIN codes by entering a location, district, or state.\n\n'
                    '**Search online directories:**\n'
                    'Many websites and online directories list the PIN codes for various locations across India. You can search by area name, city, or state.\n\n'
                    '**Use Google Maps or Google Search:**\n'
                    'You can find the PIN code by searching the location name or area on Google. Google often displays the corresponding PIN code in search results.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "Postal Code Format:\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    'The format for the Indian Postal Code (PIN) is a 6-digit code. The first digit represents the region, the second digit represents the sub-region, the third digit indicates the sorting district, and the last three digits identify the specific post office.\n\n'
                    'For example, a code like "110001" refers to a specific location in New Delhi, where "110" is the code for the region, "00" is for the sub-region, and "1" identifies the specific post office.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//