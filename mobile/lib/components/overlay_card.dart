import 'package:dollar_diary/constants/colors.dart';
import 'package:flutter/material.dart';

class OverlayCard extends StatelessWidget {
  final Widget? child;
  final Function() onTap;
  const OverlayCard({
    super.key,
    this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          color: kOverlaySurfaceColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          highlightColor: kMutedSurfaceColor,
          splashColor: kMutedGreyColor,
          splashFactory: InkSplash.splashFactory,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
