import 'package:flutter/material.dart';

enum TransactionCategory {
  All,
  Tech,
  Bills,
  Education,
  Other,
}

class TransactionPage extends StatelessWidget {
  static const kTransactionPageId = 'TransactionPageId';

  TransactionCategory category;

  TransactionPage({
    Key? key,
    this.category = TransactionCategory.All,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
