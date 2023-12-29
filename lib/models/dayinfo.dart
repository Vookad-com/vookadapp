import 'package:intl/intl.dart';
class DayInfo {
  String date = "";
  final DateTime mainDate;
  String formattedDay = "";
  bool active;
  DayInfo(this.mainDate, {this.active = false}){
    date = DateFormat('d').format(mainDate);
    formattedDay = DateFormat('E').format(mainDate);
  }
}