import 'package:intl/intl.dart';

class DateHelper {
  static String prettyDateWithTime(DateTime dateTime) {
    DateFormat formatter = DateFormat.yMMMMd('en_US').add_jm();
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDate(DateTime dateTime) {
    DateFormat formatter = DateFormat("E, MMM d, y");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String dateFormat(DateTime dateTime) {
    DateFormat formatter = DateFormat("y-MM-dd");
    String formatted = formatter.format(dateTime);
    return formatted;
  }
}
