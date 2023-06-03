import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Avatar extends ConsumerWidget {
  final size;
  const Avatar({this.size = 50});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(genderProvider);
    return CircleAvatar(
      backgroundColor: kOverlaySurfaceColor,
      radius: size / 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset('assets/images/AvatarMale.png'),
      ),
    );
  }
}
