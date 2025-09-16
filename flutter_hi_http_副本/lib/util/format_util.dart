// 数字转换
import 'package:intl/intl.dart';

String countFormat(int count) {
  String views = "";
  if (count > 9999) {
    views = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    views = count.toString();
  }
  return views;
}

//时间转分钟：秒
String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - 60 * m;
  if (s < 10) {
    return "$m:0$s";
  }
  return "$m:$s";
}

///日期格式化，2022-06-11 20:06:43 -> 06-11
String dateMonthAndDay(String dateStr) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM-dd');
  String formatted = formatter.format(now);
  return formatted;
}
