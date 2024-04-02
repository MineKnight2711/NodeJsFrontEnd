import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final currentcy = NumberFormat('#,##0', 'ID');
  String result =
      "${currentcy.format(double.parse(value.toStringAsFixed(0)))} đ";
  return result;
}
