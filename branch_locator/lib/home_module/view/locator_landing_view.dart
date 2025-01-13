import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/core_theme.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:flutter/material.dart';

class LocatorLandingView extends StatelessWidget {
  const LocatorLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            ElevatedButton(
              onPressed: () => CoreNavigator.pushNamed(LocatorRoutePaths.searchByBankHierarchy),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(140),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search, size: 30, color: CoreColors.toryBlue),
                  const SizedBox(height: 8),
                  Text(
                    "Find Branch By Selecting",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: CoreColors.toryBlue),
                  ),
                  Text(
                    "Bank, State, District and Branch",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: CoreColors.toryBlue),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Other Search Methods", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            SizedBox(
              height: 440,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildSearchButton(
                    "By IFSC",
                    Icons.numbers,
                    onTap: () => CoreNavigator.pushNamed(LocatorRoutePaths.searchByIFSC),
                  ),
                  _buildSearchButton(
                    "By MICR",
                    Icons.credit_card,
                    onTap: () => CoreNavigator.pushNamed(LocatorRoutePaths.searchByMICR),
                  ),
                  _buildSearchButton(
                    "By Branch",
                    Icons.location_on,
                    onTap: () => CoreNavigator.pushNamed(LocatorRoutePaths.searchByBranch),
                  ),
                  _buildSearchButton(
                    "By Pincode",
                    Icons.pin_drop,
                    onTap: () => CoreNavigator.pushNamed(LocatorRoutePaths.searchByPincode),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(String label, IconData icon, {required Function() onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundColor: CoreColors.toryBlue,
        padding: const EdgeInsets.symmetric(vertical: 20),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: CoreColors.toryBlue),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
