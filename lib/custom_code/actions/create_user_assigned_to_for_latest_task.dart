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

Future<void> createUserAssignedToForLatestTask() async {
  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    await Future.delayed(Duration(seconds: 4));
    // Query the latest task based on the timestamp
    final taskResponse = await client
        .from('tasks')
        .select('task_id, assigned_to, user_name')
        .not('assigned_to', 'is', null)
        .not('user_name', 'is', null)
        .order('task_id', ascending: false)
        .limit(1)
        .execute();

    if (taskResponse.status != 200) {
      throw Exception('Error querying latest task: ${taskResponse.status}');
    }

    final taskData = taskResponse.data;
    if (taskData == null || taskData.isEmpty) {
      print('No latest task found.');
      return;
    }

    final taskId = taskData[0]['task_id'] as int;
    final assignedTo = taskData[0]['assigned_to'] as String?;
    final userName = taskData[0]['user_name'] as String?;

    if (assignedTo == null || userName == null) {
      throw Exception('Assigned to or user name is null.');
    }

    final List<Map<String, dynamic>> recordsToInsert = [];

    final assignedToResponse = await client
        .from('users')
        .select('user_id')
        .eq('email', assignedTo)
        .single()
        .execute();

    if (assignedToResponse.status != 200) {
      throw Exception(
          'Error querying assigned_to user: ${assignedToResponse.status}');
    }

    final assignedToUserId = assignedToResponse.data?['user_id'] as String?;

    if (assignedToUserId != null) {
      final userNameResponse = await client
          .from('users')
          .select('user_id')
          .eq('email', userName)
          .single()
          .execute();

      if (userNameResponse.status != 200) {
        throw Exception(
            'Error querying user_name user: ${userNameResponse.status}');
      }

      final userNameUserId = userNameResponse.data?['user_id'] as String?;

      if (userNameUserId != null) {
        if (assignedToUserId == userNameUserId) {
          // If assigned_to and user_name are the same, create only one record
          recordsToInsert.add({'user_id': assignedToUserId, 'task_id': taskId});
        } else {
          // If assigned_to and user_name are different, create separate records for each
          recordsToInsert.add({'user_id': assignedToUserId, 'task_id': taskId});
          recordsToInsert.add({'user_id': userNameUserId, 'task_id': taskId});
        }
      } else {
        throw Exception('User name user not found.');
      }
    } else {
      throw Exception('Assigned to user not found.');
    }

    await client.from('user_assignedTo').insert(recordsToInsert).execute();

    print(
        'User roles created successfully for the latest task with task_id: $taskId');
  } catch (e) {
    print('Error: $e');
  }
}
