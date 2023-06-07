import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/subject_choose_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNewChapterModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for chapterName widget.
  TextEditingController? chapterNameController;
  String? Function(BuildContext, String?)? chapterNameControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChaptersRecord? createdChapter;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    chapterNameController?.dispose();
  }

  /// Additional helper methods are added here.

}
