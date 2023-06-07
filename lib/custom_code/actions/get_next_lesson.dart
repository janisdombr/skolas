// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<LessonsRecord?> getNextLesson(DocumentReference? currentLesson) async {
  // Add your function code here!
  String id = '';
  if (currentLesson == null) {
    return null;
  } else {
    id = currentLesson.id;
  }
  DocumentSnapshot lesson =
      await FirebaseFirestore.instance.collection('lessons').doc(id).get();
  DocumentReference chpt = lesson.get('chapter') as DocumentReference;
  final QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
      .collection('lessons')
      .where('chapter', isEqualTo: FirebaseFirestore.instance.doc(chpt.path))
      .orderBy('lesson_name')
      .get();

  final List<DocumentSnapshot> documents = querySnapshot2.docs;
  bool Found = false;
  DocumentSnapshot? nextLes = null;
  for (final DocumentSnapshot document in documents) {
    if (document.id == lesson.id) {
      Found = true;
    } else if (Found) {
      nextLes = document;
      FFAppState().Log += '\nNext Lesson is ' + nextLes.get("lesson_name");
      break;
    }
  }
  if (nextLes == null) {
    DocumentSnapshot chapter = await FirebaseFirestore.instance
        .collection('chapters')
        .doc(chpt.id)
        .get();
    if (!chapter.exists) {
      FFAppState().Log += 'Chapter Not Exists';
    } else {
      DocumentReference subj = chapter.get('subject') as DocumentReference;
      final QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
          .collection('chapters')
          .where('subject',
              isEqualTo: FirebaseFirestore.instance.doc(subj.path))
          .where('year', isEqualTo: chapter.get("year") as int)
          .where('name', isGreaterThan: chapter.get("name") as String)
          .orderBy('name')
          .limit(1)
          .get();
      if (querySnapshot3.docs.isNotEmpty) {
        DocumentSnapshot newChapterDoc = querySnapshot3.docs.first;
        final QuerySnapshot querySnapshot4 = await FirebaseFirestore.instance
            .collection('lessons')
            .where('chapter',
                isEqualTo: FirebaseFirestore.instance
                    .doc(newChapterDoc.reference.path))
            .orderBy('lesson_name')
            .limit(1)
            .get();
        if (querySnapshot4.docs.isNotEmpty) {
          nextLes = querySnapshot4.docs.first;
          FFAppState().Log += '\nNext Lesson is ' + nextLes.get("lesson_name");
          //widget.updateAction!();
        }
      } else {
        FFAppState().Log += 'Next Chapter Not Exists';
      }
    }
  }
  if (nextLes != null) {
    LessonsRecord res =
        await LessonsRecord.getDocument(nextLes.reference).first;
    return res;
  } else {
    FFAppState().Log += '\nNext Lesson is null';
    return null;
  }
}
