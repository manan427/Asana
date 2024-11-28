import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'incompete_tasks_widget.dart' show IncompeteTasksWidget;
import 'package:flutter/material.dart';

class IncompeteTasksModel extends FlutterFlowModel<IncompeteTasksWidget> {
  ///  Local state fields for this page.

  String? comments;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  Map<TasksAssigneeViewRow, bool> checkboxValueMap = {};
  List<TasksAssigneeViewRow> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  Completer<List<TasksAssigneeViewRow>>? requestCompleter;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
