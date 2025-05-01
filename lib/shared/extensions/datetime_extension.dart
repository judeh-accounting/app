import 'package:timeago/timeago.dart' as timeago;

extension DatetimeExtension on DateTime {
  String get since => timeago.format(this, locale: 'ar');
}
