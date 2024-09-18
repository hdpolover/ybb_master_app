import 'package:intl/intl.dart';

class CommonMethods {
  static String formatDate(DateTime? date) {
    return date == null ? "-" : DateFormat('dd MMM yyyy').format(date);
  }

  static String formatDateDisplay(DateTime startDate, DateTime endDate) {
    // if the start date and end date is the same, just display the date
    if (startDate == endDate) {
      return formatDate(startDate);
    } else {
      // if the start date and end date is different, display both dates
      return "${formatDate(startDate)} - ${formatDate(endDate)}";
    }
  }

  static String formatDateWithTime(DateTime? date) {
    // format date with time to be like "April 14, 2024 10:00:00"
    return date == null ? "-" : DateFormat("dd MMM yyyy hh:mm").format(date);
  }
}
