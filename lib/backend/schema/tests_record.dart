import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TestsRecord extends FirestoreRecord {
  TestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  bool hasQuestion() => _question != null;

  // "videoRef" field.
  DocumentReference? _videoRef;
  DocumentReference? get videoRef => _videoRef;
  bool hasVideoRef() => _videoRef != null;

  // "answers" field.
  List<String>? _answers;
  List<String> get answers => _answers ?? const [];
  bool hasAnswers() => _answers != null;

  // "radio" field.
  bool? _radio;
  bool get radio => _radio ?? false;
  bool hasRadio() => _radio != null;

  // "right_answers" field.
  List<String>? _rightAnswers;
  List<String> get rightAnswers => _rightAnswers ?? const [];
  bool hasRightAnswers() => _rightAnswers != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _question = snapshotData['question'] as String?;
    _videoRef = snapshotData['videoRef'] as DocumentReference?;
    _answers = getDataList(snapshotData['answers']);
    _radio = snapshotData['radio'] as bool?;
    _rightAnswers = getDataList(snapshotData['right_answers']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('tests')
          : FirebaseFirestore.instance.collectionGroup('tests');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('tests').doc();

  static Stream<TestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TestsRecord.fromSnapshot(s));

  static Future<TestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TestsRecord.fromSnapshot(s));

  static TestsRecord fromSnapshot(DocumentSnapshot snapshot) => TestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TestsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createTestsRecordData({
  String? question,
  DocumentReference? videoRef,
  bool? radio,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question': question,
      'videoRef': videoRef,
      'radio': radio,
    }.withoutNulls,
  );

  return firestoreData;
}
