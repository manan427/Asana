import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mytasks_widget.dart' show MytasksWidget;
import 'package:flutter/material.dart';

class MytasksModel extends FlutterFlowModel<MytasksWidget> {
  ///  Local state fields for this page.

  int? userid;

  ///  State fields for stateful widgets in this page.

  // Model for navbar component.
  late NavbarModel navbarModel;

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    navbarModel.dispose();
  }
}
