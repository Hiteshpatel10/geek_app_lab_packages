import 'package:alphabet_navigation/alphabet_navigation.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

typedef AlphabetSelectCallback = void Function(String value);

class LocatorSearchableSelect extends StatelessWidget {
  const LocatorSearchableSelect({super.key, required this.list, required this.onTap});

  final List<String> list;
  final AlphabetSelectCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty == true) {
      return Text("dsfsd");
    }
    return AlphabetNavigation(
      stringList: list,
      dynamicList: list,
      showSearchField: false,
      dynamicListHeight: 60,
      listDirection: ListDirection.right,
      alphabetListBackgroundColor: CoreColors.aliceBlue,
      selectedColor: Colors.white,
      unselectedColor: CoreColors.blackEel,
      circleSelectedBackgroundColor: Colors.blue,
      circleSelectedLetter: true,
      circleBorderRadius: 10.0,
      scrollAnimationCurve: Curves.ease,
      itemBuilder: (context, index, dynamicList) {
        return GestureDetector(
          onTap: () {
            onTap(dynamicList[index]);
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Text(
              dynamicList[index],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
