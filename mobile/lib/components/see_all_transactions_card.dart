import 'package:dollar_diary/main.dart';
import 'package:dollar_diary/screens/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overlay_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'card_icon.dart';
import 'package:dollar_diary/constants/colors.dart';

class SeeAllTransactionsCard extends ConsumerWidget {
  const SeeAllTransactionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);

    return OverlayCard(
      onTap: () {
        Navigator.pushNamed(context, TransactionPage.kTransactionPageId);
      },
      child: Row(
        children: [
          CardIcon(
            asset: 'assets/images/BookIcon.svg',
            color: highlightColor,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'See all transactions',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Expanded(child: Container()),
          SvgPicture.asset(
            'assets/images/ChevronRightIcon.svg',
            colorFilter: const ColorFilter.mode(
              kMutedGreyColor,
              BlendMode.srcIn,
            ),
            semanticsLabel: 'Chevron Icon',
          ),
        ],
      ),
    );
  }
}
