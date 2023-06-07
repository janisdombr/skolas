// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DocumentReference?> addVideoToLesson(
  String? lessonRef,
  String? videoPath,
  String? name,
) async {
  // get List<String> of parameterName values from collectionName collection
  String ref = lessonRef ?? '';
  Map<String, dynamic> attributeMap = new Map<String, dynamic>();
  FFAppState().Log += ' Map created. ';
  attributeMap["name"] = name ?? '';
  attributeMap["videoOriginPath"] = videoPath ?? '';
  FFAppState().Log += ' name: ' + attributeMap["name"];
  FFAppState().Log += ' videoOriginPath: ' + attributeMap["videoOriginPath"];
  DocumentReference docReference = await FirebaseFirestore.instance
      .collection('lessons')
      .doc(ref)
      .collection('videos')
      .doc();
  FFAppState().Log += ' docReference: ' + docReference.id;
  await docReference.set(attributeMap);
  return docReference;
}
