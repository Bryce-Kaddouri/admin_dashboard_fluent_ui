//import intl
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String get24HourTime(TimeOfDay time) {
    DateTime date = DateTime(2023, 1, 1, time.hour, time.minute);
    return DateFormat('HH:mm').format(date);
  }

  // 11 Monday January 2024 at 14:00
  static String getFormattedDateTime(DateTime date) {
    return "${DateFormat('dd').format(date)} ${DateFormat('EEEE').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('yyyy').format(date)} at ${DateFormat('HH:mm').format(date)}";
  }

  // 11 Monday January 2024
  static String getFormattedDateWithoutTime(DateTime date, {bool isShort = false}) {
    return "${DateFormat('dd').format(date)} ${DateFormat(isShort ? 'E' : 'EEEE').format(date)} ${DateFormat('MMMM').format(date)} ${DateFormat('yyyy').format(date)}";
  }

  // get month name and year
  static String getMonthNameAndYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static int getNbWeekInYear(int year) {
    DateTime date = DateTime(year, 12, 31);
    int dayOfYear = getDayOfYear(date);
    int nbWeek = dayOfYear ~/ 7;
    return nbWeek;
  }

  static getDayOfYear(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return dayOfYear;
  }

  static int getNbDaysInYear(int year) {
    return year % 4 == 0 ? 366 : 365;
  }

  static int getNbDaysInMonth(DateTime date) {
    int month = date.month;
    int year = date.year;
    int nbDays = 0;
    if (month == 2) {
      nbDays = year % 4 == 0 ? 29 : 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      nbDays = 30;
    } else {
      nbDays = 31;
    }
    return nbDays;
  }

  static getNbWeekInMonth(DateTime date) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int dayOfWeek = firstDayOfMonth.weekday;
    int nbDayInMonth = getNbDaysInMonth(date);
    int nbWeek = (dayOfWeek + nbDayInMonth) ~/ 7;
    return nbWeek;
  }

  // get the days of the week by the current date (monday, tuesday, ...)
  static List<DateTime> getDaysInWeek(DateTime date) {
    List<DateTime> days = [];
    int dayOfWeek = date.weekday;
    DateTime firstDayOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
    for (int i = 0; i < 7; i++) {
      days.add(firstDayOfWeek.add(Duration(days: i)));
    }
    return days;
  }

  // method to get day in letter (ex: SUnday ==> Sun)
  static String getDayInLetter(DateTime date) {
    return DateFormat('E').format(date);
  }
}
