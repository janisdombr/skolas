import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LessonsRecord extends FirestoreRecord {
  LessonsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "users_assigned" field.
  List<DocumentReference>? _usersAssigned;
  List<DocumentReference> get usersAssigned => _usersAssigned ?? const [];
  bool hasUsersAssigned() => _usersAssigned != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "last_edited" field.
  DateTime? _lastEdited;
  DateTime? get lastEdited => _lastEdited;
  bool hasLastEdited() => _lastEdited != null;

  // "time_created" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "lesson_name" field.
  String? _lessonName;
  String get lessonName => _lessonName ?? '';
  bool hasLessonName() => _lessonName != null;

  // "lang" field.
  String? _lang;
  String get lang => _lang ?? '';
  bool hasLang() => _lang != null;

  // "chapter" field.
  DocumentReference? _chapter;
  DocumentReference? get chapter => _chapter;
  bool hasChapter() => _chapter != null;

  void _initializeFields() {
    _owner = snapshotData['owner'] as DocumentReference?;
    _usersAssigned = getDataList(snapshotData['users_assigned']);
    _description = snapshotData['description'] as String?;
    _lastEdited = snapshotData['last_edited'] as DateTime?;
    _timeCreated = snapshotData['time_created'] as DateTime?;
    _lessonName = snapshotData['lesson_name'] as String?;
    _lang = snapshotData['lang'] as String?;
    _chapter = snapshotData['chapter'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('lessons');

  static Stream<LessonsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LessonsRecord.fromSnapshot(s));

  static Future<LessonsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LessonsRecord.fromSnapshot(s));

  static LessonsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LessonsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LessonsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LessonsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LessonsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createLessonsRecordData({
  DocumentReference? owner,
  String? description,
  DateTime? lastEdited,
  DateTime? timeCreated,
  String? lessonName,
  String? lang,
  DocumentReference? chapter,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'owner': owner,
      'description': description,
      'last_edited': lastEdited,
      'time_created': timeCreated,
      'lesson_name': lessonName,
      'lang': lang,
      'chapter': chapter,
    }.withoutNulls,
  );

  return firestoreData;
}
