// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<String>> getListFromCollection(
    String? collectionName,
    String? parameterName,
    bool? isSub,
    String? parentRef,
    String? filterName,
    String? filterValue) async {
  // get List<String> of parameterName values from collectionName collection
  String pName = parameterName ?? 'display_name';
  String cName = collectionName ?? 'users';
  bool isSubc = isSub ?? false;
  bool hasFilter = filterName != null;
  String fName = filterName ?? 'chapter';
  String fValue = filterValue ?? 'OsEujK8A0byMjLrWHTJF';
  final List<String> list = [];

  if (isSubc && parentRef != null) {
    String ref = parentRef;
    if (parentRef.contains('/')) {
      ref = ref.split('/')[1];
    }
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lessons')
        .doc(ref)
        .collection(cName)
        .orderBy(pName)
        .get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;
    for (final DocumentSnapshot document in documents) {
      list.add(document[pName]);
    }
  } else {
    if (hasFilter) {
      String reference = 'chapters/${fValue}';
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(cName)
          .where(fName, isEqualTo: FirebaseFirestore.instance.doc(reference))
          .orderBy(pName)
          .get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;
      for (final DocumentSnapshot document in documents) {
        list.add(document[pName]);
      }
    } else {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(cName)
          .orderBy(pName)
          .get();
      final List<DocumentSnapshot> documents = querySnapshot.docs;
      for (final DocumentSnapshot document in documents) {
        list.add(document[pName]);
      }
    }
  }
  list.sort();
  return list;
}
