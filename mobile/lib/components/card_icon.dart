import 'package:dollar_diary/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardIcon extends StatelessWidget {
  final String asset;
  final Color color;

  const CardIcon({
    Key? key,
    required this.asset,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: 36.0,
      decoration: const BoxDecoration(
        color: kAltSectionSurfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          asset,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          semanticsLabel: '$asset Icon',
        ),
      ),
    );
  }
}
