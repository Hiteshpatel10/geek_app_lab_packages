import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/navigation/core_navigator.dart';
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
}
