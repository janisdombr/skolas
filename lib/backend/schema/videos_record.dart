import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VideosRecord extends FirestoreRecord {
  VideosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "videoURL" field.
  String? _videoURL;
  String get videoURL => _videoURL ?? '';
  bool hasVideoURL() => _videoURL != null;

  // "stopPoints" field.
  List<int>? _stopPoints;
  List<int> get stopPoints => _stopPoints ?? const [];
  bool hasStopPoints() => _stopPoints != null;

  // "videoOriginPath" field.
  String? _videoOriginPath;
  String get videoOriginPath => _videoOriginPath ?? '';
  bool hasVideoOriginPath() => _videoOriginPath != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _videoURL = snapshotData['videoURL'] as String?;
    _stopPoints = getDataList(snapshotData['stopPoints']);
    _videoOriginPath = snapshotData['videoOriginPath'] as String?;
    _name = snapshotData['name'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('videos')
          : FirebaseFirestore.instance.collectionGroup('videos');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('videos').doc();

  static Stream<VideosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VideosRecord.fromSnapshot(s));

  static Future<VideosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VideosRecord.fromSnapshot(s));

  static VideosRecord fromSnapshot(DocumentSnapshot snapshot) => VideosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VideosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VideosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VideosRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createVideosRecordData({
  String? videoURL,
  String? videoOriginPath,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'videoURL': videoURL,
      'videoOriginPath': videoOriginPath,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}
