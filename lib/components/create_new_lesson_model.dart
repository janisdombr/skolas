import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNewLessonModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for lessonName widget.
  TextEditingController? lessonNameController;
  String? Function(BuildContext, String?)? lessonNameControllerValidator;
  String? _lessonNameControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'i4tu7fpk' /* Jānorāda  nosaukums */,
      );
    }

    return null;
  }

  // State field(s) for videoname widget.
  TextEditingController? videonameController;
  String? Function(BuildContext, String?)? videonameControllerValidator;
  String? _videonameControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'wjdi43wn' /* Jānorāda  nosaukums */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  LessonsRecord? createdLesson;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  VideosRecord? createdVideoRef;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    lessonNameControllerValidator = _lessonNameControllerValidator;
    videonameControllerValidator = _videonameControllerValidator;
  }

  void dispose() {
    lessonNameController?.dispose();
    videonameController?.dispose();
  }

  /// Additional helper methods are added here.

}
