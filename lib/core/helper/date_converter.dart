import 'package:demandium_serviceman/core/core_export.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String dateToDateAndTime(DateTime ? dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime!);
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String dateMonthYearTime(DateTime ? dateTime) {
    return DateFormat('d MMM,y HH:mm').format(dateTime!);
  }

  static String dateStringMonthYear(DateTime ? dateTime) {
    return DateFormat('d MMM,y').format(dateTime!);
  }

  static String dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String timeToTimeString(TimeOfDay time) {
    DateTime dateTime = DateTime(2000, 01, 01, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String countDays(DateTime ? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference.toString();
  }

  static String stringYear(DateTime ? dateTime) {
    return DateFormat('y').format(dateTime!);
  }

  static DateTime isoUtcStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }
}
