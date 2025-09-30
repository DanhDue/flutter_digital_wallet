// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

// coverage:ignore-file

import 'package:intl/intl.dart';

class DateTimeUtils {
  static const yMd = 'dd/MM/yyyy';
  static String formatDateTime(DateTime dateTime, DateFormat dateFormat) {
    return dateFormat.format(dateTime);
  }

  static DateTime? convertFromDateString({
    required String dateString,
    required DateFormat dateFormat,
  }) {
    DateTime? date;
    try {
      date = dateFormat.parse(dateString);
    } catch (e) {
      date = null;
    }
    return date;
  }

  static List<String> getYearList() {
    DateTime dateNow = DateTime.now();
    DateTime dateBeforeOneYear = DateTime(dateNow.year - 1, dateNow.month, dateNow.day);
    DateTime dateBeforeTwoYear = DateTime(dateNow.year - 2, dateNow.month, dateNow.day);
    DateTime dateAfterOneYear = DateTime(dateNow.year + 1, dateNow.month, dateNow.day);
    DateTime dateAfterTwoYear = DateTime(dateNow.year + 2, dateNow.month, dateNow.day);
    return [
      getYearSchool(dateBeforeTwoYear, dateBeforeOneYear),
      getYearSchool(dateBeforeOneYear, dateNow),
      getYearSchool(dateNow, dateAfterOneYear),
      getYearSchool(dateAfterOneYear, dateAfterTwoYear),
    ];
  }

  static String getYearSchool(DateTime before, DateTime after) {
    return "${before.year}-${after.year}";
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime? other) {
    return year == other?.year && month == other?.month && day == other?.day;
  }
}

int maxScaleTime = 2 * 365;

DateTime minDate = DateTime.now().subtract(Duration(days: maxScaleTime));
DateTime maxDate = DateTime.now().add(Duration(days: maxScaleTime));
