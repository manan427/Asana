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

Future<void> createUserRolesForLatestTask() async {
  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  // Create a Supabase client instance
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  try {
    // Query the latest task based on the timestamp
    await Future.delayed(Duration(seconds: 4));

    final taskResponse = await client
        .from('tasks')
        .select('task_id, assigned_to, collaborator, user_name')
        .not('assigned_to', 'is', null)
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
    final assignedToEmail = taskData[0]['assigned_to'] as String?;
    final collaboratorEmails = taskData[0]['collaborator'] as List<dynamic>?;
    final userName = taskData[0]['user_name'] as String?;

    // Insert user role for assigned_to if present
    if (assignedToEmail != null) {
      final userResponse = await client
          .from('users')
          .select('user_id')
          .eq('email', assignedToEmail)
          .single()
          .execute();

      if (userResponse.status != 200) {
        throw Exception('Error querying user: ${userResponse.status}');
      }

      final userId = userResponse.data?['user_id'] as String?;

      if (userId != null) {
        await client.from('user_roles').insert({
          'user_id': userId,
          'role_id': 3,
          'task_id': taskId,
        }).execute();
      }
    }

    // Insert user roles for collaborator if present
    if (collaboratorEmails != null) {
      for (final collaboratorEmail in collaboratorEmails) {
        final userResponse = await client
            .from('users')
            .select('user_id')
            .eq('email', collaboratorEmail)
            .single()
            .execute();

        if (userResponse.status != 200) {
          throw Exception('Error querying user: ${userResponse.status}');
        }

        final userId = userResponse.data?['user_id'] as String?;

        if (userId != null) {
          await client.from('user_roles').insert({
            'user_id': userId,
            'role_id': 4,
            'task_id': taskId,
          }).execute();
        }
      }
    }

    // Insert user role for user_name if present and user_name is different from assigned_to
    if (userName != null && userName != assignedToEmail) {
      final userResponse = await client
          .from('users')
          .select('user_id')
          .eq('email', userName)
          .single()
          .execute();

      if (userResponse.status != 200) {
        throw Exception('Error querying user: ${userResponse.status}');
      }

      final userId = userResponse.data?['user_id'] as String?;

      if (userId != null) {
        await client.from('user_roles').insert({
          'user_id': userId,
          'role_id': 2,
          'task_id': taskId,
        }).execute();
      }
    }

    print(
        'User roles created successfully for the latest task with task_id: $taskId');
  } catch (e) {
    print('Error: $e');
  }
}
