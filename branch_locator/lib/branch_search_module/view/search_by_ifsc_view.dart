import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';
import 'package:validator_forge/validator_forge.dart';

class SearchByIfscView extends StatefulWidget {
  const SearchByIfscView({super.key});

  @override
  State<SearchByIfscView> createState() => _SearchByIfscViewState();
}

class _SearchByIfscViewState extends State<SearchByIfscView> {
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
        title: const Text("Search by IFSC"),
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
                hintText: 'Enter IFSC Code',
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                return ValidationBuilder()
                    .required('Enter ifsc code')
                    .matchRegex(r"^[A-Za-z]{4}0[A-Z0-9a-z]{6}$", "Invalid IFSC Code")
                    .build(value);
              },
            ),
            const SizedBox(height: 20), // Spacer between the text field and suggestions
            _buildSuggestion(),
            const SizedBox(height: 100), // Spacer between the text field and suggestions

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
              "post_data": {"ifsc": _textFiledController.text}
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
                text: "What is IFSC Code?\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                'IFSC (Indian Financial System Code) is a unique 11-character code used to identify a specific branch of a bank for electronic payment applications like NEFT, IMPS, and RTGS.\n'
                    'It helps facilitate secure and efficient money transfers between banks and their branches across India.',
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
                text: "How to Find IFSC code?\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                '1. Can be found on bank passbook and cheque leaf of the respective bank.\n'
                    '2. From Reserve Bank of India’s website, the list of IFSC codes of banks and their respective branches can be obtained.\n'
                    '3. Bank customers can also visit the banks’ official website to find the IFSC code of a particular bank.',
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
                text: "Bank IFSC Code Format:\n",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const TextSpan(
                text:
                'The IFSC Code follows this format:\n'
                    '1. The first character represents the bank code.\n'
                    '2. The fourth character is always 0.\n'
                    '3. The next four characters represent the branch code.\n\n'
                    'For example, "SBIN0001123" refers to the SBI bank, where "SBIN" is the bank code, "0" is fixed, and "001123" is the branch code.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
