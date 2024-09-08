import 'package:intl/intl.dart';

String formatTime(String apiTime) {
  DateTime dateTime = DateTime.parse(apiTime);
  return DateFormat.jm().format(dateTime);
}
