import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "lang" field.
  String? _lang;
  String get lang => _lang ?? '';
  bool hasLang() => _lang != null;

  // "current_lesson" field.
  DocumentReference? _currentLesson;
  DocumentReference? get currentLesson => _currentLesson;
  bool hasCurrentLesson() => _currentLesson != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "year" field.
  int? _year;
  int get year => _year ?? 0;
  bool hasYear() => _year != null;

  // "last_subject" field.
  DocumentReference? _lastSubject;
  DocumentReference? get lastSubject => _lastSubject;
  bool hasLastSubject() => _lastSubject != null;

  // "last_chapter" field.
  DocumentReference? _lastChapter;
  DocumentReference? get lastChapter => _lastChapter;
  bool hasLastChapter() => _lastChapter != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _lang = snapshotData['lang'] as String?;
    _currentLesson = snapshotData['current_lesson'] as DocumentReference?;
    _role = snapshotData['role'] as String?;
    _year = snapshotData['year'] as int?;
    _lastSubject = snapshotData['last_subject'] as DocumentReference?;
    _lastChapter = snapshotData['last_chapter'] as DocumentReference?;
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  String? lang,
  DocumentReference? currentLesson,
  String? role,
  int? year,
  DocumentReference? lastSubject,
  DocumentReference? lastChapter,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'lang': lang,
      'current_lesson': currentLesson,
      'role': role,
      'year': year,
      'last_subject': lastSubject,
      'last_chapter': lastChapter,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}
