import 'package:branch_locator/branch_search_module/bloc/branch_detail_cubit.dart';
import 'package:branch_locator/util/locator_route_paths.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchListView extends StatefulWidget {
  const BranchListView({super.key, this.postData});
  final Map<String, dynamic>? postData;

  @override
  State<BranchListView> createState() => _BranchListViewState();
}

class _BranchListViewState extends State<BranchListView> {
  late final BranchDetailCubit _branchDetailCubit;
  @override
  void initState() {
    _branchDetailCubit = BlocProvider.of<BranchDetailCubit>(context);
    _branchDetailCubit.getBranchDetail(postData: widget.postData ?? {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<BranchDetailCubit, BranchDetailState>(
        builder: (context, state) {
          if (state is BranchDetailSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.branchDetail.result?.length ?? 0,
              itemBuilder: (context, index) {
                final item = state.branchDetail.result?[index];
                return GestureDetector(
                  onTap: () {
                    CoreNavigator.pushNamed(LocatorRoutePaths.branchDetail, arguments: {
                      "branch_detail": item,
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: CoreBoxDecoration.getBoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.bankName ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          item?.address ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
