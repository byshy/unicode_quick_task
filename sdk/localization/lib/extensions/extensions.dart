import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String formatDate() {
    return DateFormat('EEE dd, MMM').format(this);
  }

  String formatTime() {
    return DateFormat('hh:mm a').format(this);
  }

  static DateTime get current => _current();

  static DateTime _current() {
    DateTime now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }
}
