import 'package:dollar_diary/components/income_card.dart';
import 'package:dollar_diary/components/period_picker.dart';
import 'package:dollar_diary/components/screen_safe_area.dart';
import 'package:dollar_diary/main.dart';
import 'package:dollar_diary/components/spending_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dollar_diary/components/transaction_card.dart';

import '../components/round_icon_button.dart';
import '../constants/colors.dart';

class DiaryPage extends ConsumerStatefulWidget {
  static const id = 'diaryPageId';

  const DiaryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DiaryPage> createState() => _DiaryPageConsumerState();
}

class _DiaryPageConsumerState extends ConsumerState<DiaryPage> {
  PeriodType periodType = PeriodType.month;
  static const multiSizeTextRowHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    final chosenUnit = ref.watch(chosenComparisonUnitProvider);

    return Scaffold(
      body: ScreenSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Diary',
                  style: TextStyle(fontSize: 32.0),
                ),
                RoundIconButton(
                  icon: SvgPicture.asset(
                    'assets/images/SettingIcon.svg',
                    colorFilter: const ColorFilter.mode(
                      kMutedGreyColor,
                      BlendMode.srcIn,
                    ),
                    semanticsLabel: 'Setting Icon',
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 40.0,
              ),
              child: PeriodPicker(
                defaultPeriod: periodType,
                onTabChanged: (PeriodType type) {
                  setState(() {
                    periodType = type;
                  });
                },
              ),
            ),
            const TransactionCard(),
            const SizedBox(height: 24.0),
            const SpendingCard(),
            const SizedBox(height: 24.0),
            const IncomeCard(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
