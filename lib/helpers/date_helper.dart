import 'package:intl/intl.dart';

extension DateFormatterHelper on DateTime {
  String toFormattedString(){
    return DateFormat('d MMM yyyy').format(this.toLocal());
  }
}