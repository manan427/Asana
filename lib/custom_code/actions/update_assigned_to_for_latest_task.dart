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

Future<void> updateAssignedToForLatestTask(int taskId) async {
  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    // Query the task based on the taskId
    final taskResponse = await client
        .from('tasks')
        .select('task_id, assigned_to, user_name')
        .eq('task_id', taskId)
        .single()
        .execute();

    if (taskResponse.status != 200 || taskResponse.data == null) {
      throw Exception('Error querying task: ${taskResponse.status}');
    }

    final taskData = taskResponse.data;
    if (taskData == null) {
      print('Task not found.');
      return;
    }

    final assignedTo = taskData['assigned_to'] as String?;
    final userName = taskData['user_name'] as String?;

    if (assignedTo == null || userName == null) {
      throw Exception('Assigned to or user name is null.');
    }

    final assignedToResponse = await client
        .from('users')
        .select('user_id')
        .eq('email', assignedTo)
        .single()
        .execute();

    if (assignedToResponse.status != 200 || assignedToResponse.data == null) {
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

      if (userNameResponse.status != 200 || userNameResponse.data == null) {
        throw Exception(
            'Error querying user_name user: ${userNameResponse.status}');
      }

      final userNameUserId = userNameResponse.data?['user_id'] as String?;

      if (userNameUserId != null) {
        // Check if the assigned_to and user_name users are already in user_assignedTo for this task
        final existingRecordsResponse = await client
            .from('user_assignedTo')
            .select('user_id, task_id, role_id')
            .eq('task_id', taskId)
            .execute();

        if (existingRecordsResponse.status != 200 ||
            existingRecordsResponse.data == null) {
          throw Exception(
              'Error querying user_assignedTo: ${existingRecordsResponse.status}');
        }

        final existingRecords = existingRecordsResponse.data as List<dynamic>;

        // Prepare the list of records to update or insert
        final recordsToUpdate = <Map<String, dynamic>>[];
        final userIdsToDelete = existingRecords
            .map((record) => record['user_id'] as String)
            .toSet()
            .difference({assignedToUserId, userNameUserId});

        // If assigned_to and user_name are the same, create only one record with role_id = 3
        if (assignedToUserId == userNameUserId) {
          recordsToUpdate.add(
              {'user_id': assignedToUserId, 'task_id': taskId, 'role_id': 3});
        } else {
          // If assigned_to and user_name are different, create separate records with respective role_ids
          recordsToUpdate.add(
              {'user_id': assignedToUserId, 'task_id': taskId, 'role_id': 3});
          recordsToUpdate.add(
              {'user_id': userNameUserId, 'task_id': taskId, 'role_id': 2});
        }

        // Delete records that are no longer valid
        for (final userId in userIdsToDelete) {
          await client
              .from('user_assignedTo')
              .delete()
              .eq('user_id', userId)
              .eq('task_id', taskId)
              .execute();
        }

        // Insert or update the required records
        for (final record in recordsToUpdate) {
          final existingRecord = existingRecords.firstWhere(
            (existing) => existing['user_id'] == record['user_id'],
            orElse: () => null,
          );

          if (existingRecord != null) {
            await client
                .from('user_assignedTo')
                .update(record)
                .eq('user_id', record['user_id'])
                .eq('task_id', taskId)
                .execute();
          } else {
            await client.from('user_assignedTo').insert(record).execute();
          }
        }

        print(
            'User roles updated successfully for the task with task_id: $taskId');
      } else {
        throw Exception('User name user not found.');
      }
    } else {
      throw Exception('Assigned to user not found.');
    }
  } catch (e) {
    print('Error: $e');
  }
}
