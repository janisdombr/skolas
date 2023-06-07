// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DocumentReference?> getLessonRefByName(
  String? lessonName,
  String? chapter,
) async {
  // async get first ref filtered by lesson_name parameter using FirebaseFirestore
  if (chapter == null) {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .where('lesson_name', isEqualTo: lessonName)
        .limit(1)
        .get();
    if (snapshot.docs.length == 0) {
      return null;
    } else {
      return snapshot.docs.first.reference;
    }
  } else {
    String reference = 'chapters/${chapter}';
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .where('chapter', isEqualTo: FirebaseFirestore.instance.doc(reference))
        .where('lesson_name', isEqualTo: lessonName)
        .limit(1)
        .get();
    if (snapshot.docs.length == 0) {
      return null;
    } else {
      return snapshot.docs.first.reference;
    }
  }
}
