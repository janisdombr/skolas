import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubjectsRecord extends FirestoreRecord {
  SubjectsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "classes" field.
  List<int>? _classes;
  List<int> get classes => _classes ?? const [];
  bool hasClasses() => _classes != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _classes = getDataList(snapshotData['classes']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subjects');

  static Stream<SubjectsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubjectsRecord.fromSnapshot(s));

  static Future<SubjectsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubjectsRecord.fromSnapshot(s));

  static SubjectsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubjectsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubjectsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubjectsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubjectsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createSubjectsRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}
