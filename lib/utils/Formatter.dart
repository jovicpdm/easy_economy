import 'package:intl/intl.dart';

class Formatter {
  String getCurrency(double value) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: "pt-br");
    return formatter.format(value);
  }

  String percentageFormat(double value) {
    var formatter = NumberFormat("##0.##", "pt-br");
    return formatter.format(value * 100);
  }
}
