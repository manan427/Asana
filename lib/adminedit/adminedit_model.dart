import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'adminedit_widget.dart' show AdmineditWidget;
import 'package:flutter/material.dart';

class AdmineditModel extends FlutterFlowModel<AdmineditWidget> {
  ///  Local state fields for this page.

  String? pageRebuild;

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
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for MonthlyWeek widget.
  String? monthlyWeekValue;
  FormFieldController<String>? monthlyWeekValueController;
  // State field(s) for MonthlyDay widget.
  String? monthlyDayValue;
  FormFieldController<String>? monthlyDayValueController;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for MonthlyDate widget.
  String? monthlyDateValue;
  FormFieldController<String>? monthlyDateValueController;
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
