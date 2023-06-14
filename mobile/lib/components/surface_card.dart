import 'package:dollar_diary/constants/colors.dart';
import 'package:flutter/material.dart';

class SurfaceCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  const SurfaceCard({
    super.key,
    this.child = null,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kMutedSurfaceColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
