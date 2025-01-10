import 'package:branch_locator/branch_search_module/model/branch_detail_model.dart';
import 'package:branch_locator/branch_search_module/view/branch_detail_view.dart';
import 'package:branch_locator/branch_search_module/view/branch_list_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_bank_hierarchy_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_branch_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_ifsc_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_micr_view.dart';
import 'package:branch_locator/branch_search_module/view/search_by_pincode_view.dart';
import 'package:branch_locator/home_module/view/locator_landing_view.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:flutter/material.dart';

MaterialPageRoute locatorRouteGenerator(RouteSettings settings) {
  dynamic args = settings.arguments;

  switch (settings.name) {
    case LocatorRoutePaths.landing:
      return MaterialPageRoute(builder: (_) => const LocatorLandingView());

    case LocatorRoutePaths.searchByBranch:
      return MaterialPageRoute(builder: (_) => const SearchByBranchView());

      case LocatorRoutePaths.searchByBankHierarchy:
      return MaterialPageRoute(builder: (_) => const SearchByBankHierarchyView());

    case LocatorRoutePaths.searchByPincode:
      return MaterialPageRoute(builder: (_) => const SearchByPincodeView());

    case LocatorRoutePaths.searchByIFSC:
      return MaterialPageRoute(builder: (_) => const SearchByIfscView());

    case LocatorRoutePaths.searchByMICR:
      return MaterialPageRoute(builder: (_) => const SearchByMICRView());

    case LocatorRoutePaths.branchList:
      final arguments = args as Map<String, dynamic>?;
      final postData = arguments?['post_data'] as Map<String, dynamic>;
      return MaterialPageRoute(builder: (_) => BranchListView(postData: postData));

    case LocatorRoutePaths.branchDetail:
      final arguments = args as Map<String, dynamic>?;
      final postData = arguments?['post_data'] as Map<String, dynamic>? ?? {};
      final branchDetail = arguments?['branch_detail'] as BranchDetail?;
      return MaterialPageRoute(
        builder: (_) => BranchDetailView(postData: postData, branchDetail: branchDetail),
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
