import 'dart:ui';

import 'package:dollar_diary/screens/main_screen.dart';
import 'package:dollar_diary/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'constants/colors.dart';

part 'main.g.dart';

@riverpod
Color chosenHighlightColor(ChosenHighlightColorRef ref) {
  return kHighlightCyan;
}

enum Gender { male, female }

@riverpod
Gender gender(GenderRef ref) {
  return Gender.male;
}

class ComparisonUnit {
  final String name;
  final double value;
  final String imageAsset;

  const ComparisonUnit(
      {required this.name, required this.value, required this.imageAsset});
}

@riverpod
class ChosenComparisonUnit extends _$ChosenComparisonUnit {
  @override
  ComparisonUnit build() {
    return const ComparisonUnit(
      name: 'Starbucks drinks',
      value: 5.0,
      imageAsset: 'assets/images/StarbucksCoffee.png',
    );
  }

  void changeUnit({
    required String name,
    required double value,
    required String imageAsset,
  }) {
    state = ComparisonUnit(name: name, value: value, imageAsset: imageAsset);
  }
}

void main() {
  runApp(
    const ProviderScope(
      child: DollarDiary(),
    ),
  );
}

class DollarDiary extends ConsumerWidget {
  const DollarDiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color highlightColor = ref.watch(chosenHighlightColorProvider);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: kMutedSurfaceColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kOverlaySurfaceColor,
          selectedItemColor: highlightColor,
          unselectedLabelStyle: const TextStyle(color: kMutedGreyColor),
          unselectedItemColor: kMutedGreyColor,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent, // <- Here
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: kAppSurfaceColor,
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          checkColor: MaterialStateProperty.resolveWith((state) {
            return kMutedSurfaceColor;
          }),
          fillColor: MaterialStateProperty.resolveWith((states) {
            return Colors.white;
          }),
        ),
        fontFamily: 'NunitoSans',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontVariations: [
            FontVariation('wdth', 102.0),
            FontVariation('wght', 400.0)
          ]),
          labelLarge: TextStyle(fontVariations: [
            FontVariation('wdth', 102.0),
            FontVariation('wght', 400.0)
          ]),
        ).apply(
          bodyColor: kCoolGreyColor,
        ),
      ),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        SettingScreen.id: (context) => const SettingScreen(),
      },
    );
  }
}
