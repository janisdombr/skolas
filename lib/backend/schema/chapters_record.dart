import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChaptersRecord extends FirestoreRecord {
  ChaptersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "year" field.
  int? _year;
  int get year => _year ?? 0;
  bool hasYear() => _year != null;

  // "subject" field.
  DocumentReference? _subject;
  DocumentReference? get subject => _subject;
  bool hasSubject() => _subject != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _year = snapshotData['year'] as int?;
    _subject = snapshotData['subject'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chapters');

  static Stream<ChaptersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChaptersRecord.fromSnapshot(s));

  static Future<ChaptersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChaptersRecord.fromSnapshot(s));

  static ChaptersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChaptersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChaptersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChaptersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChaptersRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createChaptersRecordData({
  String? name,
  int? year,
  DocumentReference? subject,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'year': year,
      'subject': subject,
    }.withoutNulls,
  );

  return firestoreData;
}
