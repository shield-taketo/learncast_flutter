import 'package:intl/intl.dart';

final _numberFormatter = NumberFormat('#,###');

String formatNumber(int value) {
  return _numberFormatter.format(value);
}
