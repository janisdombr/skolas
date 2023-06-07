// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DocumentReference?> getVideoRefByName(
    String? videoName, String? parentRef) async {
  // async get first ref filtered by lesson_name parameter using FirebaseFirestore

  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('lessons')
      .doc(parentRef)
      .collection('videos')
      .where('name', isEqualTo: videoName)
      .limit(1)
      .get();
  if (snapshot.docs.length == 0) {
    return null;
  } else {
    return snapshot.docs.first.reference;
  }
}
