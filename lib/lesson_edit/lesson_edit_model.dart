import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/backbutton_widget.dart';
import '/components/check_box_answers_widget.dart';
import '/components/radio_answers_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LessonEditModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for Backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for DropDownVIdeos widget.
  String? dropDownVIdeosValue;
  FormFieldController<String>? dropDownVIdeosValueController;
  // State field(s) for TextFieldLessonName widget.
  TextEditingController? textFieldLessonNameController;
  String? Function(BuildContext, String?)?
      textFieldLessonNameControllerValidator;
  // State field(s) for TextFieldVideoName widget.
  TextEditingController? textFieldVideoNameController;
  String? Function(BuildContext, String?)?
      textFieldVideoNameControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for DropDownPoints widget.
  String? dropDownPointsValue;
  FormFieldController<String>? dropDownPointsValueController;
  // State field(s) for TextFieldPoint widget.
  TextEditingController? textFieldPointController;
  String? Function(BuildContext, String?)? textFieldPointControllerValidator;
  // Models for RadioAnswers dynamic component.
  late FlutterFlowDynamicModels<RadioAnswersModel> radioAnswersModels;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
    radioAnswersModels = FlutterFlowDynamicModels(() => RadioAnswersModel());
  }

  void dispose() {
    backbuttonModel.dispose();
    textFieldLessonNameController?.dispose();
    textFieldVideoNameController?.dispose();
    textFieldPointController?.dispose();
    radioAnswersModels.dispose();
  }

  /// Additional helper methods are added here.

}
