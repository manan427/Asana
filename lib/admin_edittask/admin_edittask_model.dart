import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'admin_edittask_widget.dart' show AdminEdittaskWidget;
import 'package:flutter/material.dart';

class AdminEdittaskModel extends FlutterFlowModel<AdminEdittaskWidget> {
  ///  Local state fields for this page.

  String? loopAction;

  String? loopActionCounter;

  String? assignedto;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for task widget.
  FocusNode? taskFocusNode;
  TextEditingController? taskTextController;
  String? Function(BuildContext, String?)? taskTextControllerValidator;
  // State field(s) for Assignedto widget.
  String? assignedtoValue;
  FormFieldController<String>? assignedtoValueController;
  DateTime? datePicked1;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for Repeatative widget.
  String? repeatativeValue;
  FormFieldController<String>? repeatativeValueController;
  // State field(s) for DayofWeek widget.
  String? dayofWeekValue;
  FormFieldController<String>? dayofWeekValueController;
  // State field(s) for Month widget.
  String? monthValue;
  FormFieldController<String>? monthValueController;
  DateTime? datePicked2;
  // State field(s) for Collabortor widget.
  List<String>? collabortorValue;
  FormFieldController<List<String>>? collabortorValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    taskFocusNode?.dispose();
    taskTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
