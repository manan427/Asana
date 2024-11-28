import '/flutter_flow/flutter_flow_util.dart';
import 'admin_view_widget.dart' show AdminViewWidget;
import 'package:flutter/material.dart';

class AdminViewModel extends FlutterFlowModel<AdminViewWidget> {
  ///  Local state fields for this page.

  String? loopAction;

  String? loopActionCounter;

  String? assignedto;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for taskname widget.
  FocusNode? tasknameFocusNode;
  TextEditingController? tasknameTextController;
  String? Function(BuildContext, String?)? tasknameTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for Comments widget.
  FocusNode? commentsFocusNode;
  TextEditingController? commentsTextController;
  String? Function(BuildContext, String?)? commentsTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tasknameFocusNode?.dispose();
    tasknameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    commentsFocusNode?.dispose();
    commentsTextController?.dispose();
  }
}
