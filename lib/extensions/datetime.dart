import 'package:jiffy/jiffy.dart';

extension FormatDateTime on DateTime {
  String get dateTime {
    Jiffy.setLocale('id');
    return Jiffy.parseFromDateTime(this).format(pattern: 'd MMMM yyyy');
  }
}

extension DayOfWeek on DateTime {
  String get dayOfWeek {
    Jiffy.setLocale('id');
    return Jiffy.parseFromDateTime(this).format(pattern: 'EEEE');
  }
}
