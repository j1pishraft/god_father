import 'dart:core';

import 'package:intl/intl.dart';

class ConvertNoLocale {
  static String convertNoLocale(int num, String locale) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern(locale);
    return numberFormat.format(num);
  }
}