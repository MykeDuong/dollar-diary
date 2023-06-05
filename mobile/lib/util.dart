import 'dart:math';
import 'package:intl/intl.dart' as Intl;

double log10(num x) => log(x) / ln10;

String numberFormat(double x, int digits) => Intl.NumberFormat.compactCurrency(
      decimalDigits: digits,
      symbol: '',
    ).format(x);
