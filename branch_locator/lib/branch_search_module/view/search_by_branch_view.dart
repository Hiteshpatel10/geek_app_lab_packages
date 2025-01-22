import 'package:branch_locator/branch_search_module/bloc/search_by_pincode_cubit.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_util.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
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
                text: "What is a Bank Branch?\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    'A bank branch is a physical location where a bank or financial institution offers services to customers. These services can be in-person or automated.',
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
                text: "How to Find a Bank Branch?\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text:
                    'To find a bank branch location, you can use a bank\'s branch locator tool, search online directories, or use Google Maps.\n\n'
                    '**Use a bank\'s branch locator tool:**\n'
                    'Many banks have branch locator tools on their websites. You can search for branches by name, address, state, district, or other parameters.\n\n'
                    '**Search online directories:**\n'
                    'Online directories often have databases of banks and public offices. These directories can provide information about branches, including contact information and the names of senior officials.\n\n'
                    '**Use Google Maps:**\n'
                    'You can search for a bank branch on Google Maps to find its location, directions, and contact information. Google Maps can also provide information about traffic and public transportation.',
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
                text: "Using IFSC or MICR Code to Find a Bank Branch:\n",
                style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                  text: 'You can also use the IFSC or MICR code to find a bank branch.\n\n'
                      '**IFSC Code:**\n'
                      'The IFSC code is an 11-character code that can be used to find a bank branch\'s details, including its address.\n\n'
                      '**MICR Code:**\n'
                      'The MICR code is a 9-digit code that can be used to identify a specific bank branch.\n'),
            ],
          ),
        ),
      ],
    );
  }
}
