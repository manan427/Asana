import '/flutter_flow/flutter_flow_util.dart';
import 'update_password_widget.dart' show UpdatePasswordWidget;
import 'package:flutter/material.dart';

class UpdatePasswordModel extends FlutterFlowModel<UpdatePasswordWidget> {
  ///  Local state fields for this page.

  String? updatepass;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for Passwordtextfield widget.
  FocusNode? passwordtextfieldFocusNode;
  TextEditingController? passwordtextfieldTextController;
  late bool passwordtextfieldVisibility;
  String? Function(BuildContext, String?)?
      passwordtextfieldTextControllerValidator;
  // State field(s) for re-enterPass widget.
  FocusNode? reEnterPassFocusNode;
  TextEditingController? reEnterPassTextController;
  late bool reEnterPassVisibility;
  String? Function(BuildContext, String?)? reEnterPassTextControllerValidator;
  // Stores action output result for [Custom Action - changePasswordError] action in Button widget.
  bool? success;

  @override
  void initState(BuildContext context) {
    passwordtextfieldVisibility = false;
    reEnterPassVisibility = false;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    passwordtextfieldFocusNode?.dispose();
    passwordtextfieldTextController?.dispose();

    reEnterPassFocusNode?.dispose();
    reEnterPassTextController?.dispose();
  }
}
