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

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<void> updateUserRolesForTask(int taskId) async {
  // Replace these with your Supabase project URL and anon key
  final supabaseUrl = 'https://nzpkdamrqkyvsjwkkhpc.supabase.co';
  final supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cGtkYW1ycWt5dnNqd2traHBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0OTQ3MzMsImV4cCI6MjAyNjA3MDczM30.y8UtaHIM7xTK384hN1LYFsheBoWIM0e4At25PaoMHwE';

  final client = http.Client();

  try {
    // Query the current state of the task based on the provided taskId
    final taskResponse = await client.get(
      Uri.parse('$supabaseUrl/rest/v1/tasks?task_id=eq.$taskId'),
      headers: {
        'apikey': supabaseKey,
        'Accept': 'application/json',
      },
    );

    if (taskResponse.statusCode != 200) {
      throw Exception('Error querying task: ${taskResponse.statusCode}');
    }

    final taskDataList = jsonDecode(taskResponse.body) as List<dynamic>;
    if (taskDataList.isEmpty) {
      print('No task found with the specified taskId.');
      return;
    }

    final taskData = taskDataList[0] as Map<String, dynamic>;
    final task = parseTask(taskData);

    // Fetch UUIDs for the current collaborator emails
    final currentCollaboratorUUIDs = await fetchUserUUIDs(
        task.collaborator, client, supabaseUrl, supabaseKey);

    // Fetch the assigned_to and user_name user IDs
    final assignedToUserId = await getUserIdByEmail(
        client, supabaseUrl, supabaseKey, task.assignedTo);
    final userNameUserId =
        await getUserIdByEmail(client, supabaseUrl, supabaseKey, task.userName);

    // Query the user_roles table for existing entries for this task
    final existingRolesResponse = await client.get(
      Uri.parse('$supabaseUrl/rest/v1/user_roles?task_id=eq.$taskId'),
      headers: {
        'apikey': supabaseKey,
        'Accept': 'application/json',
      },
    );

    if (existingRolesResponse.statusCode != 200) {
      throw Exception(
          'Error querying user_roles: ${existingRolesResponse.statusCode}');
    }

    final existingRolesData =
        jsonDecode(existingRolesResponse.body) as List<dynamic>;
    final existingRoles = parseUserRoles(existingRolesData);

    // Separate roles into different sets for comparison
    final existingCollaborators = existingRoles
        .where((role) => role.roleId == 4)
        .map((role) => role.userId)
        .toSet();
    final newCollaborators = currentCollaboratorUUIDs.toSet();

    final existingAssignedTo = existingRoles
        .where((role) => role.roleId == 3)
        .map((role) => role.userId)
        .toSet();
    final newAssignedTo =
        assignedToUserId != null ? {assignedToUserId} : <String>{};

    final existingUserName = existingRoles
        .where((role) => role.roleId == 2)
        .map((role) => role.userId)
        .toSet();
    final newUserName = userNameUserId != null ? {userNameUserId} : <String>{};

    // Determine which roles to add and which to remove
    final rolesToRemove = existingCollaborators
        .difference(newCollaborators)
        .union(existingAssignedTo.difference(newAssignedTo))
        .union(existingUserName.difference(newUserName));

    final rolesToAdd = newCollaborators
        .difference(existingCollaborators)
        .union(newAssignedTo.difference(existingAssignedTo))
        .union(newUserName.difference(existingUserName));

    // Remove outdated roles
    for (final userId in rolesToRemove) {
      await client.delete(
        Uri.parse(
            '$supabaseUrl/rest/v1/user_roles?task_id=eq.$taskId&user_id=eq.$userId'),
        headers: {
          'apikey': supabaseKey,
          'Accept': 'application/json',
        },
      );
    }

    // Add new roles
    for (final userId in rolesToAdd) {
      int roleId = 4; // Default to collaborator role
      if (newAssignedTo.contains(userId)) {
        roleId = 3;
      } else if (newUserName.contains(userId)) {
        roleId = 2;
      }

      await client.post(
        Uri.parse('$supabaseUrl/rest/v1/user_roles'),
        headers: {
          'apikey': supabaseKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'task_id': taskId,
          'role_id': roleId,
        }),
      );
    }

    print('User roles updated successfully for the task with task_id: $taskId');
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}

// Function to fetch UUIDs for a list of emails
Future<List<String>> fetchUserUUIDs(List<String> emails, http.Client client,
    String supabaseUrl, String supabaseKey) async {
  final uuids = <String>[];

  for (final email in emails) {
    final userResponse = await client.get(
      Uri.parse('$supabaseUrl/rest/v1/users?email=eq.$email'),
      headers: {
        'apikey': supabaseKey,
        'Accept': 'application/json',
      },
    );

    if (userResponse.statusCode != 200) {
      throw Exception('Error querying user: ${userResponse.statusCode}');
    }

    final userDataList = jsonDecode(userResponse.body) as List<dynamic>;
    if (userDataList.isNotEmpty) {
      final userId = userDataList[0]['user_id'] as String?;
      if (userId != null) {
        uuids.add(userId);
      }
    }
  }

  return uuids;
}

// Function to fetch user UUID by email
Future<String?> getUserIdByEmail(http.Client client, String supabaseUrl,
    String supabaseKey, String? email) async {
  if (email == null) return null;

  final response = await client.get(
    Uri.parse('$supabaseUrl/rest/v1/users?email=eq.$email'),
    headers: {
      'apikey': supabaseKey,
      'Accept': 'application/json',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Error querying user: ${response.statusCode}');
  }

  final data = jsonDecode(response.body) as List<dynamic>;
  if (data.isEmpty) {
    return null;
  }

  return data[0]['user_id'] as String?;
}

// Parse the task data
Task parseTask(Map<String, dynamic> taskData) {
  final id = taskData['task_id'] as int;
  final assignedTo = taskData['assigned_to'] as String?;
  final userName = taskData['user_name'] as String?;
  final collaborator = (taskData['collaborator'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
      [];
  return Task(
      id: id,
      assignedTo: assignedTo,
      userName: userName,
      collaborator: collaborator);
}

// Parse the user roles data
List<UserRole> parseUserRoles(List<dynamic> userRolesData) {
  return userRolesData
      .map((data) => UserRole(
          userId: data['user_id'] as String, roleId: data['role_id'] as int))
      .toList();
}

class Task {
  final int id;
  final String? assignedTo;
  final String? userName;
  final List<String> collaborator;

  Task(
      {required this.id,
      this.assignedTo,
      this.userName,
      required this.collaborator});
}

class UserRole {
  final String userId;
  final int roleId;

  UserRole({required this.userId, required this.roleId});
}

void main() async {
  // Example usage
  try {
    final taskId = 1; // Replace with the actual task ID
    await updateUserRolesForTask(taskId);
  } catch (e) {
    print('Error: $e');
  }
}
