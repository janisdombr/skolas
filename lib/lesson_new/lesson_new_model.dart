import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/check_box_answers_widget.dart';
import '/components/radio_answers_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LessonNewModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getListFromCollection] action in LessonNew widget.
  List<String>? getTestsFromVideo;
  // Models for RadioAnswers dynamic component.
  late FlutterFlowDynamicModels<RadioAnswersModel> radioAnswersModels;
  // Stores action output result for [Custom Action - getNextLesson] action in ButtonNext widget.
  LessonsRecord? nextlesson;
  // Stores action output result for [Custom Action - getListFromCollection] action in ButtonNext widget.
  List<String>? getTestsFromVideo2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    radioAnswersModels = FlutterFlowDynamicModels(() => RadioAnswersModel());
  }

  void dispose() {
    radioAnswersModels.dispose();
  }

  /// Additional helper methods are added here.

}
