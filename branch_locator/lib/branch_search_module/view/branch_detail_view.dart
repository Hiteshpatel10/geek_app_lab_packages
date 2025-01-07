import 'package:branch_locator/branch_search_module/bloc/branch_detail_cubit.dart';
import 'package:branch_locator/branch_search_module/model/branch_detail_model.dart';
import 'package:core_utility/core_mode.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchDetailView extends StatefulWidget {
  const BranchDetailView({super.key, required this.postData});

  final Map<String, dynamic> postData;

  @override
  State<BranchDetailView> createState() => _BranchDetailViewState();
}

class _BranchDetailViewState extends State<BranchDetailView> {
  List<CoreKeyValuePairModel<String, String?, void>>? _basicInfo;
  List<CoreKeyValuePairModel<String, String?, void>>? _address;
  List<CoreKeyValuePairModel<String, String?, void>>? _bankingFeature;

  @override
  void initState() {
    final branchDetailCubit = BlocProvider.of<BranchDetailCubit>(context);

    branchDetailCubit.getBranchDetail(postData: widget.postData);
    super.initState();
  }

  _buildBranchData(Result? branchDetail) {
    _basicInfo = [
      CoreKeyValuePairModel(key: "IFSC Code", value: branchDetail?.ifsc),
      CoreKeyValuePairModel(key: "MICR Code", value: branchDetail?.micr),
      CoreKeyValuePairModel(key: "Contact Number", value: branchDetail?.contact),
    ];

    _address = [
      CoreKeyValuePairModel(key: "State", value: branchDetail?.state),
      CoreKeyValuePairModel(key: "District", value: branchDetail?.district),
      CoreKeyValuePairModel(key: "City", value: branchDetail?.city),
      CoreKeyValuePairModel(key: "ISO 3166 Code", value: branchDetail?.iso3166),
    ];

    _bankingFeature = [
      CoreKeyValuePairModel(key: "UPI", value: branchDetail?.upi == true ? "Yes" : "No"),
      CoreKeyValuePairModel(key: "NEFT", value: branchDetail?.neft == true ? "Yes" : "No"),
      CoreKeyValuePairModel(key: "RTGS", value: branchDetail?.rtgs == true ? "Yes" : "No"),
      CoreKeyValuePairModel(key: "IMPS", value: branchDetail?.imps == true ? "Yes" : "No"),
      CoreKeyValuePairModel(key: "SWIFT", value: branchDetail?.swift),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branch Detail")),
      body: BlocBuilder<BranchDetailCubit, BranchDetailState>(
        builder: (context, state) {
          if (state is BranchDetailSuccess) {
            _buildBranchData(state.branchDetail.result?.first);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.branchDetail.result?.first.bankName ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.branchDetail.result?.first.address ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  ..._buildInfoCard("Basic Information", _basicInfo),
                  const SizedBox(height: 16),
                  ..._buildInfoCard("Address Details", _address),
                  const SizedBox(height: 16),
                  ..._buildInfoCard("Banking Features", _bankingFeature),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _buildInfoCard(String title, List<CoreKeyValuePairModel<String, String?, void>>? data) {
    if (data == null || data.isEmpty == true) return [];
    return [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      ...List.generate(
        data.length,
        (index) {
          final item = data[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.key,
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: CoreColors.shuttleGrey),
                ),
                Text(
                  item.value ?? "N/A",
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: CoreColors.darkJungleGreen),
                ),
              ],
            ),
          );
        },
      ),
    ];
  }
}
