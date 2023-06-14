import 'package:dollar_diary/constants/styles.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'surface_card.dart';
import 'package:dollar_diary/constants/colors.dart';
import 'see_all_transactions_card.dart';

class TransactionCard extends ConsumerStatefulWidget {
  const TransactionCard({
    super.key,
  });

  @override
  ConsumerState<TransactionCard> createState() =>
      _TransactionCardConsumerState();
}

class _TransactionCardConsumerState extends ConsumerState<TransactionCard> {
  static const multiSizeTextRowHeight = 50.0;
  bool noRecurring = false;
  bool noOutlier = false;

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    final chosenUnit = ref.watch(chosenComparisonUnitProvider);

    return SurfaceCard(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transactions',
            style: kHeadingTextStyle,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/MoneyIcon.svg',
                colorFilter: ColorFilter.mode(
                  highlightColor,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'Money Icon',
              ),
              const SizedBox(width: 8.0),
              const Text(
                'No. of Transactions',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          const SizedBox(width: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '127',
                style: TextStyle(
                  height: multiSizeTextRowHeight / 40.0,
                  fontSize: 40.0,
                  color: highlightColor,
                ),
              ),
              const Text(
                'Transactions',
                style: TextStyle(
                  height: multiSizeTextRowHeight / 16.0,
                  fontSize: 16.0,
                  color: kMutedGreyColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/PaperIcon.svg',
                colorFilter: ColorFilter.mode(
                  highlightColor,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'Paper Icon',
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Average Transaction Value',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          const SizedBox(width: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$952.3',
                style: TextStyle(
                  height: multiSizeTextRowHeight / 40.0,
                  fontSize: 40.0,
                  color: highlightColor,
                ),
              ),
              const Text(
                '~ 190',
                style: TextStyle(
                  height: multiSizeTextRowHeight / 16.0,
                  fontSize: 16.0,
                  color: kMutedGreyColor,
                ),
              ),
              const SizedBox(width: 3.0),
              Image.asset(
                chosenUnit.imageAsset,
                height: 40.0,
                width: 15.0,
              ),
              const SizedBox(width: 3.0),
              Text(
                chosenUnit.name,
                style: const TextStyle(
                  height: multiSizeTextRowHeight / 16.0,
                  fontSize: 16.0,
                  color: kMutedGreyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                  value: noRecurring,
                  onChanged: (value) {
                    setState(() {
                      noRecurring = !noRecurring;
                    });
                  },
                ),
              ),
              const SizedBox(width: 5.0),
              const Text(
                'Remove reccurring income',
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                  value: noOutlier,
                  onChanged: (value) {
                    setState(() {
                      noOutlier = !noOutlier;
                    });
                  },
                ),
              ),
              const SizedBox(width: 5.0),
              const Text(
                'Filter Outliers',
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
          const SizedBox(height: 24.0),
          const SeeAllTransactionsCard(),
        ],
      ),
    );
  }
}
