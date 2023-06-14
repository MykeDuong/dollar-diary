import 'package:dollar_diary/constants/styles.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overlay_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'card_icon.dart';
import 'package:dollar_diary/constants/colors.dart';

class TransactionCategoryCard extends ConsumerWidget {
  final Color iconColor;
  final String category;
  final double percentage;
  final double amount;

  const TransactionCategoryCard({
    super.key,
    required this.iconColor,
    required this.category,
    required this.percentage,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);

    return OverlayCard(
      onTap: () {
        print('Things happend');
      },
      child: Row(
        children: [
          CardIcon(
            asset: 'assets/images/BookIcon.svg',
            color: highlightColor,
          ),
          const SizedBox(width: kCardIconToTextLength),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(2)}% of Spend',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: kMutedGreyColor,
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
