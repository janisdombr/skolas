import '/auth/firebase_auth/auth_util.dart';
import '/components/backbutton_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for Backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
  }

  void dispose() {
    backbuttonModel.dispose();
    emailAddressController?.dispose();
  }

  /// Additional helper methods are added here.

}
