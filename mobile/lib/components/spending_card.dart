import 'package:dollar_diary/components/circle_percentage_chart.dart';
import 'package:dollar_diary/components/see_more_button.dart';
import 'package:dollar_diary/components/surface_card.dart';
import 'package:dollar_diary/components/transaction_category_card.dart';
import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/constants/styles.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'see_all_transactions_card.dart';

class SpendingCard extends ConsumerWidget {
  const SpendingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Spending',
                style: kHeadingTextStyle,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Text(
                      'Circle Chart',
                      style: TextStyle(
                        color: kMutedGreyColor,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    SvgPicture.asset(
                      'assets/images/TriangleDownIcon.svg',
                      colorFilter: const ColorFilter.mode(
                        kMutedGreyColor,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: 'Triangle Down Icon',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 200.0,
            child: CirclePercentageChart(
              observations: [
                CirclePercentageChartObservation.create(
                  value: 1234.3,
                  label: 'Foods',
                  assetName: 'assets/images/FoodIcon.svg',
                ),
                CirclePercentageChartObservation.create(
                  value: 3948.2,
                  label: 'Foods',
                  assetName: 'assets/images/SpendIcon.svg',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          TransactionCategoryCard(
            iconColor: highlightColor,
            category: 'Total',
            percentage: 100,
            amount: 160.23,
          ),
          const SizedBox(height: 12.0),
          const SeeAllTransactionsCard(),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 100.0,
            ),
            child: SeeMoreButton(onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
