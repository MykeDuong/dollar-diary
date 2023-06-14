import 'package:dollar_diary/components/custom_nav_bar.dart';
import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:dollar_diary/screens/budget_page.dart';
import 'package:dollar_diary/screens/home_page.dart';
import 'package:dollar_diary/screens/diary_page.dart';
import 'package:dollar_diary/screens/statistics_page.dart';
import 'package:dollar_diary/screens/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const id = 'mainScreenId';

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late PersistentTabController _controller;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DiaryPage(),
    StatisticsPage(),
    BudgetPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    ref.read(chosenHighlightColorProvider);
  }

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);

    return Container(
      color: kOverlaySurfaceColor,
      child: SafeArea(
        top: false,
        child: PersistentTabView.custom(
          context,
          controller: _controller,
          itemCount: _widgetOptions
              .length, // This is required in case of custom style! Pass the number of items for the nav bar.
          screens: _widgetOptions,
          handleAndroidBackButtonPress: true,
          onWillPop: (int) async {
            return true;
          },
          customWidget: CustomNavBarWidget(
            // Your custom widget goes here
            items: [
              CustomNavBarItem(
                asset: 'assets/images/HomeIcon.svg',
                title: 'Home',
              ),
              CustomNavBarItem(
                asset: 'assets/images/DiaryIcon.svg',
                title: 'Diary',
              ),
              CustomNavBarItem(
                asset: 'assets/images/StatisticsIcon.svg',
                title: 'Statistics',
              ),
              CustomNavBarItem(
                asset: 'assets/images/BudgetIcon.svg',
                title: 'Budget',
              ),
            ],
            selectedIndex: _controller.index,
            onItemSelected: (index) {
              setState(() {
                _controller.index =
                    index; // NOTE: THIS IS CRITICAL!! Don't miss it!
              });
            },
          ),
        ),
      ),
    );
  }
}
