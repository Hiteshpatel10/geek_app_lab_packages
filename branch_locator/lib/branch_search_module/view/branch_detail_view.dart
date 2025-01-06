import 'package:branch_locator/branch_search_module/model/branch_detail_model.dart';
import 'package:flutter/material.dart';

class BranchDetailView extends StatelessWidget {
  const BranchDetailView({
    super.key,
    required this.branchDetail,
  });

  final Result branchDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branch Detail")),
      body:  SingleChildScrollView(
        child: Column(
          children: [

            Text(branchDetail.bankName ?? ''),

            


          ],
        ),
      ),
    );
  }
}
