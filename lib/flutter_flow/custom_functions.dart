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

String? newCustomFunctionCopyCopy() {
  // Define the userId as null
  final String? userId = null;

  // Define the Supabase project URL and anonymous key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    // Fetch task_ids where user_id is null from the user_roles table
    client
        .from('user_roles')
        .select('task_id')
        .is_('user_id', userId) // Use is_ instead of eq
        .execute()
        .then((userRolesResponse) {
      if (userRolesResponse.status != 200) {
        throw Exception(
            'Error fetching user roles: ${userRolesResponse.status}');
      }

      // Extract task IDs assigned to the user
      final List<dynamic>? taskIds =
          userRolesResponse.data?.map((e) => e['task_id']).toList();

      if (taskIds == null || taskIds.isEmpty) {
        print('No tasks assigned to the user.');
        return null;
      }

      // Fetch tasks based on the task IDs
      client
          .from('tasks')
          .select('*')
          .in_('task_id', taskIds)
          .execute()
          .then((tasksResponse) {
        if (tasksResponse.status != 200) {
          throw Exception('Error fetching tasks: ${tasksResponse.status}');
        }

        // Extract tasks data
        final tasksData = tasksResponse.data;

        if (tasksData == null || tasksData.isEmpty) {
          print('No tasks found for the user.');
          return null;
        }

        // Do not return tasks data
      }).catchError((e) {
        print('Error fetching tasks: $e');
        return null;
      });
    }).catchError((e) {
      print('Error fetching user roles: $e');
      return null;
    });
  } catch (e) {
    print('Error: $e');
    return null;
  }
  return null;
}

String? viewtasksonbasisofuserid(String? userId) {
  // Ensure userId is not null
  if (userId == null) {
    print('User ID is null.');
    return null;
  }

  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    // Fetch user roles from the user_roles table
    client
        .from('user_roles')
        .select('task_id')
        .eq('user_id', userId)
        .execute()
        .then((userRolesResponse) {
      if (userRolesResponse.status != 200) {
        throw Exception(
            'Error fetching user roles: ${userRolesResponse.status}');
      }

      // Extract task IDs assigned to the user
      final List<dynamic>? taskIds =
          userRolesResponse.data?.map((e) => e['task_id']).toList();

      if (taskIds == null || taskIds.isEmpty) {
        print('No tasks assigned to the user.');
        return null;
      }

      // Fetch tasks based on the task IDs
      client
          .from('tasks')
          .select('*')
          .in_('task_id', taskIds)
          .execute()
          .then((tasksResponse) {
        if (tasksResponse.status != 200) {
          throw Exception('Error fetching tasks: ${tasksResponse.status}');
        }

        // Extract tasks data
        final tasksData = tasksResponse.data;

        if (tasksData == null || tasksData.isEmpty) {
          print('No tasks found for the user.');
          return null;
        }

        // Process or use the tasks data here
        print('Tasks for user $userId:');
        for (final task in tasksData) {
          print(task);
        }
      }).catchError((e) {
        print('Error fetching tasks: $e');
        return null;
      });
    }).catchError((e) {
      print('Error fetching user roles: $e');
      return null;
    });
  } catch (e) {
    print('Error: $e');
    return null;
  }
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
