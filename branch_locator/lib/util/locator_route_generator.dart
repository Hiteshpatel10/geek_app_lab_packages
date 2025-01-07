import 'package:branch_locator/branch_search_module/view/branch_detail_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_bank_hierarchy_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_ifsc_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_micr_view.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:flutter/material.dart';

MaterialPageRoute locatorRouteGenerator(RouteSettings settings) {
  dynamic args = settings.arguments;

  switch (settings.name) {
    case LocatorRoutePaths.searchByBankHierarchy:
      return MaterialPageRoute(builder: (_) => const SearchByBankHierarchyView());

    case LocatorRoutePaths.searchByIFSC:
      return MaterialPageRoute(builder: (_) => const SearchByIfscView());

    case LocatorRoutePaths.searchByMICR:
      return MaterialPageRoute(builder: (_) => const SearchByMicrView());

    case LocatorRoutePaths.branchDetail:
      final arguments = args as Map<String, dynamic>?;
      final postData = arguments?['post_data'] as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => BranchDetailView(postData: postData),
      );

    default:
      return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
              centerTitle: true,
            ),
            body: const Center(
              child: Text(
                'Error ! Something went wrong ',
                style: TextStyle(color: Colors.red, fontSize: 18.0),
              ),
            ),
          );
        },
      );
  }
}
