import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavBarItem {
  final String asset;
  final String title;

  CustomNavBarItem({
    required this.asset,
    required this.title,
  });
}

class CustomNavBarWidget extends ConsumerWidget {
  final int selectedIndex;
  final List<CustomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    Key? key,
    this.selectedIndex = 0,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(
    CustomNavBarItem item,
    bool isSelected,
    Color highlightColor,
  ) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: SvgPicture.asset(
              item.asset,
              colorFilter: ColorFilter.mode(
                isSelected ? highlightColor : kMutedGreyColor,
                BlendMode.srcIn,
              ),
              semanticsLabel: item.asset,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: isSelected ? highlightColor : kMutedGreyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    return Container(
      color: kOverlaySurfaceColor,
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index, highlightColor),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
