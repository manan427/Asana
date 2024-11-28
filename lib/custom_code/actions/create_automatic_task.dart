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

Future<void> createAutomaticTask(int taskId, String repetitionType) async {
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
      // Check if the repeatative field matches the repetitionType
      if (repeatative == repetitionType) {
        // Get the current due date and end date
        final duedate = DateTime.parse(task['duedate']);
        final enddate = DateTime.parse(task['enddate']);

        if (repetitionType == 'Monthly') {
          // Get the next month
          final nextMonth =
              DateTime(duedate.year, duedate.month + 1, duedate.day);

          // Check if the next month's date exceeds the end date
          if (nextMonth.isAfter(enddate)) {
            print('Task due date exceeds end date. Task will not be created.');
            return; // Exit the function
          }

          // Format the next month date as a string
          final nextDueDate =
              '${nextMonth.year}-${nextMonth.month.toString().padLeft(2, '0')}-${duedate.day.toString().padLeft(2, '0')}';

          createTask(client, taskId, task, nextDueDate);
        } else if (repetitionType == 'Weekly') {
          // Calculate the next week's due date
          final nextWeek = duedate.add(Duration(days: 7));

          // Check if the next week's date exceeds the end date
          if (nextWeek.isAfter(enddate)) {
            print('Task due date exceeds end date. Task will not be created.');
            return; // Exit the function
          }

          // Format the next week date as a string
          final nextDueDate =
              '${nextWeek.year}-${nextWeek.month.toString().padLeft(2, '0')}-${nextWeek.day.toString().padLeft(2, '0')}';

          createTask(client, taskId, task, nextDueDate);
        }
      } else {
        // Print a message if repeatative does not match repetitionType
        print(
            'Task with task_id $taskId is not set to repeat $repetitionType.');
      }
    } else {
      print('Task with task_id $taskId not found');
    }
  } catch (e) {
    // Handle any exceptions
    print('Error: $e');
  }
}

Future<void> createTask(SupabaseClient client, int taskId,
    Map<String, dynamic> task, String nextDueDate) async {
  final currentTimestampz = DateTime.now().toUtc().toIso8601String();

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
    'created_at': currentTimestampz,
    'duedate': nextDueDate,
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
