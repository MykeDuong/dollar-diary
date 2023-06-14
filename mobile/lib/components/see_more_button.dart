import 'package:dollar_diary/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SeeMoreButton extends StatelessWidget {
  final void Function() onPressed;

  const SeeMoreButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/ChevronDownIcon.svg',
            colorFilter: const ColorFilter.mode(
              kMutedGreyColor,
              BlendMode.srcIn,
            ),
            semanticsLabel: 'Chevron Right Icon',
          ),
          const SizedBox(width: 8.0),
          const Text(
            'See more',
            style: TextStyle(
              color: kMutedGreyColor,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
