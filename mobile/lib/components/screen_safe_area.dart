import 'package:flutter/material.dart';

class ScreenSafeArea extends StatelessWidget {
  final Widget child;
  const ScreenSafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
