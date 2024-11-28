import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String? datecustomfunction(String? enddate) {
  // List of end dates prior to that date with the same day
  if (enddate == null) return null;

  final formatter = DateFormat('yyyy-MM-dd');
  final endDate = formatter.parse(enddate);

  final StringBuffer result = StringBuffer();

  // Get the day of the week of the end date
  final dayOfWeek = endDate.weekday;

  // Get the current date
  final currentDate = DateTime.now();

  // Iterate through the dates from the current date to the day before the end date
  for (DateTime date = currentDate;
      date.isBefore(endDate.subtract(Duration(days: 1)));
      date = date.add(Duration(days: 1))) {
    if (date.weekday == dayOfWeek) {
      result.write(formatter.format(date));
      result.write(', '); // Use any delimiter you prefer
    }
  }

  // Add the end date to the result if it has the same weekday
  if (endDate.weekday == dayOfWeek) {
    result.write(formatter.format(endDate));
  }

  return result.isEmpty
      ? null
      : result.toString(); // No need to remove the last delimiter
}

String? choicechipsfunction(String? choicechips) {
  // Filter data through selection from dropdown
  String? selectedCategory;
  if (choicechips != null && choicechips.isNotEmpty) {
    selectedCategory = choicechips;
  }
  return selectedCategory;
}

List<String>? uniqueList(List<String>? inputList) {
  inputList ??= [];
  Set<String> uniqueSet = Set<String>.from(inputList);
  List<String> uniqueList = uniqueSet.toList();
  return uniqueList;
}
