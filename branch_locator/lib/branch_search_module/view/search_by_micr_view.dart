import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';
import 'package:validator_forge/validator_forge.dart';

class SearchByMICRView extends StatefulWidget {
  const SearchByMICRView({super.key});

  @override
  State<SearchByMICRView> createState() => _SearchByMICRViewState();
}

class _SearchByMICRViewState extends State<SearchByMICRView> {
  late final TextEditingController _textFiledController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _textFiledController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search by Micr"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _textFiledController,
              textCapitalization: TextCapitalization.characters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 11,
              decoration: const InputDecoration(
                counterText: '',
                prefixIcon: Icon(Icons.search_rounded, size: 22),
                hintText: 'Enter MICR Code',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {},
              validator: (value) {
                return ValidationBuilder()
                    .required('Enter micr code')
                    .matchRegex(r"^[0-9]{1,9}$", "Invalid micr Code")
                    .build(value);
              },
            ),
            const SizedBox(height: 20), // Spacer between the text field and suggestions

            _buildSuggestion(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == false) {
            return;
          }
          CoreNavigator.pushNamed(
            LocatorRoutePaths.branchDetail,
            arguments: {
              "post_data": {"micr": _textFiledController.text}
            },
          );
        },
        child: const Text("Search"),
      ),
    );
  }

  Widget _buildSuggestion() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "What is MICR?\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                    'Magnetic Ink Character Recognition (MICR) is a 9-digit code used to identify a particular bank branch within the Electronic Clearing System (ECS). It is printed on the cheque leaf issued by the bank and often on the passbook issued to the account holder.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "Where to Find MICR Code?\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                    'The MICR code can be found on the cheque leaf issued by the bank, and it is generally printed on the passbook provided to the account holder.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CoreColors.blackEel),
            children: [
              TextSpan(
                text: "MICR Code Format:\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                    'The 9-digit MICR code is structured as follows:\n1. The first three digits represent the city.\n2. The next three digits indicate the bank code.\n3. The last three digits specify the bank branch code.\nFor example, "700002021" refers to the SBI branch in Kolkata, where "700" identifies the city, "002" is the bank code, and "021" is the branch code.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
