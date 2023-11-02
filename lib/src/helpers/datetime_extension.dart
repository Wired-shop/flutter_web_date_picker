import 'package:flutter/material.dart';

const kNumberCellsOfMonth = 42;
const kNumberOfWeekday = 7;
const kNumberOfMonth = 12;

const kWeekdayNames = <String>[
  "Domenica",
  "Lunedì",
  "Martedì",
  "Mercoledì",
  "Giovedì",
  "Venerdì",
  "Sabato"
];
const kWeekdayShortNames = <String>[
  "Dom",
  "Lun",
  "Mar",
  "Mer",
  "Gio",
  "Ven",
  "Sab"
];
const kWeekdayAbbreviations = <String>["D", "L", "M", "M", "G", "V", "S"];
const kMonthNames = <String>[
  "Gennaio",
  "Febbraio",
  "Marzo",
  "Aprile",
  "Maggio",
  "Giugno",
  "Luglio",
  "Agosto",
  "Settembre",
  "Ottobre",
  "Novembre",
  "Dicembre"
];
const kMonthShortNames = <String>[
  "Gen",
  "Feb",
  "Mar",
  "Apr",
  "Mag",
  "Giu",
  "Lug",
  "Ago",
  "Set",
  "Ott",
  "Nov",
  "Dic"
];

extension DateTimeExtension on DateTime {
  DateTime get nextMonth => DateTime(year, month + 1);
  DateTime get previousMonth => DateTime(year, month - 1);

  DateTime get nextYear => DateTime(year + 1);
  DateTime get previousYear => DateTime(year - 1);

  DateTimeRange monthDateTimeRange(
      {bool includeTrailingAndLeadingDates = false}) {
    DateTime start = DateTime(year, month);
    if (includeTrailingAndLeadingDates) {
      start = start.subtract(Duration(days: start.weekday % kNumberOfWeekday));
    }
    DateTime end = includeTrailingAndLeadingDates
        ? start.add(const Duration(days: kNumberCellsOfMonth))
        : DateTime(year, month + 1, 0);
    return DateTimeRange(start: start, end: end);
  }

  bool isInRange(DateTimeRange range) {
    return difference(range.start).inSeconds >= 0 &&
        difference(range.end).inSeconds <= 0;
  }

  int monthCompareTo(DateTime other) {
    if (year < other.year) {
      return -1;
    } else if (year > other.year) {
      return 1;
    } else {
      if (month < other.month) {
        return -1;
      } else if (month > other.month) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  int dateCompareTo(DateTime other) {
    final cmp = monthCompareTo(other);
    if (cmp == 0) {
      if (day < other.day) {
        return -1;
      } else if (day > other.day) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return cmp;
    }
  }
}
