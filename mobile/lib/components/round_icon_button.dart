import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dollar_diary/constants/colors.dart';

class RoundIconButton extends StatelessWidget {
  final icon;
  const RoundIconButton({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      elevation: 2.0,
      padding: const EdgeInsets.all(0.0),
      constraints: const BoxConstraints(minWidth: 0),
      fillColor: const Color(0x00000000),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const CircleBorder(),
      child: icon,
    );
  }
}
