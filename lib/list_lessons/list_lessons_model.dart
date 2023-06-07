import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/backbutton_widget.dart';
import '/components/create_new_chapter_widget.dart';
import '/components/create_new_lesson_widget.dart';
import '/components/create_new_subject_widget.dart';
import '/components/subject_choose_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListLessonsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for Backbutton component.
  late BackbuttonModel backbuttonModel;
  // State field(s) for DropDownChapters widget.
  String? dropDownChaptersValue;
  FormFieldController<String>? dropDownChaptersValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    backbuttonModel = createModel(context, () => BackbuttonModel());
  }

  void dispose() {
    backbuttonModel.dispose();
  }

  /// Additional helper methods are added here.

}
