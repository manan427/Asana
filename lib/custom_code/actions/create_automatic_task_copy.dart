// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:supabase/supabase.dart';

Future<void> createAutomaticTaskCopy(int taskId, String repetitionType) async {
  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    // Query the task with the specified task_id
    final taskResponse =
        await client.from('tasks').select().eq('task_id', taskId).execute();

    // Check for errors in task query
    if (taskResponse.status != 200) {
      throw Exception('Error querying task: ${taskResponse.status}');
    }

    // Get the task
    final task = taskResponse.data?.first;

    if (task != null) {
      final repeatative = task['repeatative'];
      final statusId = task['status_id'];

      // Check if the status_id is changing from 1 to 2
      if (statusId == 2 && repeatative == repetitionType) {
        // Get the current due date and end date
        final duedate = DateTime.parse(task['duedate']);
        final enddate = DateTime.parse(task['enddate']);

        if (repetitionType == 'Monthly') {
          // Check if the monthly_date column has a value
          final monthlyDate = task['monthly_date'];

          if (monthlyDate != null) {
            DateTime nextDueDate =
                getNextMonthlyDateByDate(duedate, int.parse(monthlyDate));

            // Check if the next due date exceeds the end date
            if (nextDueDate.isAfter(enddate)) {
              print(
                  'Task due date exceeds end date. Task will not be created.');
              return; // Exit the function
            }

            createTask(client, taskId, task,
                nextDueDate.toIso8601String().substring(0, 10));
          } else {
            // Check if the monthly_day and monthly_week columns have values
            final monthlyDay = task['monthly_day'];
            final monthlyWeek = task['monthly_week'];

            if (monthlyDay != null && monthlyWeek != null) {
              DateTime nextDueDate =
                  getNextMonthlyDate(duedate, monthlyDay, monthlyWeek);

              // Check if the next due date exceeds the end date
              if (nextDueDate.isAfter(enddate)) {
                print(
                    'Task due date exceeds end date. Task will not be created.');
                return; // Exit the function
              }

              createTask(client, taskId, task,
                  nextDueDate.toIso8601String().substring(0, 10));
            } else {
              print(
                  'Monthly_day or monthly_week column is null. Task will not be created.');
            }
          }
        } else if (repetitionType == 'Weekly') {
          // Check if the repeatative_day_month column has a value
          final repeatativeDayMonth = task['repeatative_day_month'];

          if (repeatativeDayMonth != null) {
            DateTime nextDueDate =
                getNextWeeklyDateByDay(duedate, repeatativeDayMonth);

            // Check if the next due date exceeds the end date
            if (nextDueDate.isAfter(enddate)) {
              print(
                  'Task due date exceeds end date. Task will not be created.');
              return; // Exit the function
            }

            createTask(client, taskId, task,
                nextDueDate.toIso8601String().substring(0, 10));
          } else {
            // Calculate the next week's due date
            final nextWeek = duedate.add(Duration(days: 7));

            // Check if the next week's date exceeds the end date
            if (nextWeek.isAfter(enddate)) {
              print(
                  'Task due date exceeds end date. Task will not be created.');
              return; // Exit the function
            }

            // Format the next week date as a string
            final nextDueDate = nextWeek.toIso8601String().substring(0, 10);
            createTask(client, taskId, task, nextDueDate);
          }
        } else if (repetitionType == 'Daily') {
          // Calculate the next day's due date
          final nextDay = duedate.add(Duration(days: 1));

          // Check if the next day's date exceeds the end date
          if (nextDay.isAfter(enddate)) {
            print('Task due date exceeds end date. Task will not be created.');
            return; // Exit the function
          }

          // Format the next day's date as a string
          final nextDueDate = nextDay.toIso8601String().substring(0, 10);
          createTask(client, taskId, task, nextDueDate);
        }
      } else {
        // Print a message if repeatative does not match repetitionType or status_id is not 2
        print(
            'Task with task_id $taskId is not set to repeat $repetitionType or status_id is not 2.');
      }
    } else {
      print('Task with task_id $taskId not found');
    }
  } catch (e) {
    // Handle any exceptions
    print('Error: $e');
  }
}

DateTime getNextMonthlyDate(
    DateTime currentDate, String monthlyDay, String monthlyWeek) {
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final weeksOfMonth = ['1st', '2nd', '3rd', '4th', '5th'];

  int dayIndex = daysOfWeek.indexOf(monthlyDay);
  int weekIndex = weeksOfMonth.indexOf(monthlyWeek);

  if (dayIndex == -1 || weekIndex == -1) {
    throw Exception('Invalid monthly_day or monthly_week value');
  }

  DateTime nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);

  int count = 0;
  DateTime targetDate;
  while (true) {
    if (nextMonth.weekday - 1 == dayIndex) {
      count++;
      if (count == weekIndex + 1) {
        targetDate = nextMonth;
        break;
      }
    }
    nextMonth = nextMonth.add(Duration(days: 1));
  }

  return targetDate;
}

DateTime getNextMonthlyDateByDate(DateTime currentDate, int monthlyDate) {
  DateTime nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);
  int lastDayOfMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;

  if (monthlyDate > lastDayOfMonth) {
    monthlyDate = lastDayOfMonth; // Set to last day of month if date exceeds
  }

  DateTime targetDate = DateTime(nextMonth.year, nextMonth.month, monthlyDate);
  return targetDate;
}

DateTime getNextWeeklyDateByDay(DateTime currentDate, String day) {
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  int dayIndex = daysOfWeek.indexOf(day);

  if (dayIndex == -1) {
    throw Exception('Invalid day value in repeatative_day_month');
  }

  DateTime nextDate = currentDate;
  while (true) {
    nextDate = nextDate.add(Duration(days: 1));
    if (nextDate.weekday - 1 == dayIndex) {
      break;
    }
  }

  return nextDate;
}

Future<void> createTask(SupabaseClient client, int taskId,
    Map<String, dynamic> task, String nextDueDate) async {
  final currentTimestamp = DateTime.now().toUtc().toIso8601String();

  // Create a new task with the same task name and description
  final newTaskData = {
    'taskname': task['taskname'],
    'description': task['description'],
    'repeatative': task['repeatative'],
    'enddate': task['enddate'],
    'repeatative_day_month': task['repeatative_day_month'],
    'user_name': task['user_name'],
    'assigned_to': task['assigned_to'],
    'user_id': task['user_id'],
    'collaborator': task['collaborator'],
    'status_id': 1, // Set status_id to 1 for new task
    'created_at': currentTimestamp,
    'duedate': nextDueDate,
    'monthly_week': task['monthly_week'],
    'monthly_day': task['monthly_day'],
    'monthly_date': task['monthly_date']
  };

  // Insert the new task into the database
  final newTaskResponse =
      await client.from('tasks').insert([newTaskData]).execute();

  // Check for errors in task insertion
  if (newTaskResponse.status != 201) {
    throw Exception('Error inserting task: ${newTaskResponse.status}');
  }

  // Print success message for task insertion
  print('Task inserted successfully with new due date: $nextDueDate');
}
