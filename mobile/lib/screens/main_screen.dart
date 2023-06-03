import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:dollar_diary/screens/budget_page.dart';
import 'package:dollar_diary/screens/home_page.dart';
import 'package:dollar_diary/screens/diary_page.dart';
import 'package:dollar_diary/screens/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const kMainScreenId = 'mainScreenId';

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DiaryPage(),
    StatisticsPage(),
    BudgetPage(),
  ];

  @override
  void initState() {
    super.initState();
    ref.read(chosenHighlightColorProvider);
  }

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: kOverlaySurfaceColor,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/HomeIcon.svg',
                colorFilter: _selectedIndex == 0
                    ? ColorFilter.mode(highlightColor, BlendMode.srcIn)
                    : const ColorFilter.mode(kMutedGreyColor, BlendMode.srcIn),
                semanticsLabel: 'Home Icon',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/DiaryIcon.svg',
                colorFilter: _selectedIndex == 1
                    ? ColorFilter.mode(highlightColor, BlendMode.srcIn)
                    : const ColorFilter.mode(kMutedGreyColor, BlendMode.srcIn),
                semanticsLabel: 'Diary Icon',
              ),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/StatisticsIcon.svg',
                colorFilter: _selectedIndex == 2
                    ? ColorFilter.mode(highlightColor, BlendMode.srcIn)
                    : const ColorFilter.mode(kMutedGreyColor, BlendMode.srcIn),
                semanticsLabel: 'Statistics Icon',
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/BudgetIcon.svg',
                colorFilter: _selectedIndex == 3
                    ? ColorFilter.mode(highlightColor, BlendMode.srcIn)
                    : const ColorFilter.mode(kMutedGreyColor, BlendMode.srcIn),
                semanticsLabel: 'Budget Icon',
              ),
              label: 'Budget',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
