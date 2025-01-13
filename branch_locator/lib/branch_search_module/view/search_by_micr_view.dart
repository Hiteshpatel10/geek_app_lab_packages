import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/navigation/core_navigator.dart';
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
}
