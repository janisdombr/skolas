import '/auth/firebase_auth/auth_util.dart';
import '/components/backbutton_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for Backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for password widget.
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for confirmPassword widget.
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
    passwordVisibility = false;
    confirmPasswordVisibility = false;
  }

  void dispose() {
    backbuttonModel.dispose();
    emailAddressController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
  }

  /// Additional helper methods are added here.

}
