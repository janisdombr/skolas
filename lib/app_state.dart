import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _photoURL =
      'https://firebasestorage.googleapis.com/v0/b/skolaslv.appspot.com/o/avatarblank.png?alt=media&token=4605dcb7-e4f3-4b09-8a22-f9646181d94e';
  String get photoURL => _photoURL;
  set photoURL(String _value) {
    _photoURL = _value;
  }

  bool _ShowTest = true;
  bool get ShowTest => _ShowTest;
  set ShowTest(bool _value) {
    _ShowTest = _value;
  }

  DocumentReference? _currentVideo = FirebaseFirestore.instance
      .doc('/lessons/unTEPcTNMAc2lrpdxnIu/videos/aFhpNcLwvGmRckzPvKgn');
  DocumentReference? get currentVideo => _currentVideo;
  set currentVideo(DocumentReference? _value) {
    _currentVideo = _value;
  }

  List<int> _stopPoints = [];
  List<int> get stopPoints => _stopPoints;
  set stopPoints(List<int> _value) {
    _stopPoints = _value;
  }

  void addToStopPoints(int _value) {
    _stopPoints.add(_value);
  }

  void removeFromStopPoints(int _value) {
    _stopPoints.remove(_value);
  }

  void removeAtIndexFromStopPoints(int _index) {
    _stopPoints.removeAt(_index);
  }

  void updateStopPointsAtIndex(
    int _index,
    Function(int) updateFn,
  ) {
    updateFn(_stopPoints[_index]);
  }

  List<String> _showedVideos = [];
  List<String> get showedVideos => _showedVideos;
  set showedVideos(List<String> _value) {
    _showedVideos = _value;
  }

  void addToShowedVideos(String _value) {
    _showedVideos.add(_value);
  }

  void removeFromShowedVideos(String _value) {
    _showedVideos.remove(_value);
  }

  void removeAtIndexFromShowedVideos(int _index) {
    _showedVideos.removeAt(_index);
  }

  void updateShowedVideosAtIndex(
    int _index,
    Function(String) updateFn,
  ) {
    updateFn(_showedVideos[_index]);
  }

  String _currentVideoPath =
      'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4';
  String get currentVideoPath => _currentVideoPath;
  set currentVideoPath(String _value) {
    _currentVideoPath = _value;
  }

  int _videosCount = 0;
  int get videosCount => _videosCount;
  set videosCount(int _value) {
    _videosCount = _value;
  }

  String _Log = 'ajwdawjdna\ndw\nd\nd\nawd\nawd\nawd';
  String get Log => _Log;
  set Log(String _value) {
    _Log = _value;
  }

  DocumentReference? _editCurrentLesson =
      FirebaseFirestore.instance.doc('/lessons/EevRclUAsUAhg5xotY4a');
  DocumentReference? get editCurrentLesson => _editCurrentLesson;
  set editCurrentLesson(DocumentReference? _value) {
    _editCurrentLesson = _value;
  }

  List<String> _lesonsNamesList = [];
  List<String> get lesonsNamesList => _lesonsNamesList;
  set lesonsNamesList(List<String> _value) {
    _lesonsNamesList = _value;
  }

  void addToLesonsNamesList(String _value) {
    _lesonsNamesList.add(_value);
  }

  void removeFromLesonsNamesList(String _value) {
    _lesonsNamesList.remove(_value);
  }

  void removeAtIndexFromLesonsNamesList(int _index) {
    _lesonsNamesList.removeAt(_index);
  }

  void updateLesonsNamesListAtIndex(
    int _index,
    Function(String) updateFn,
  ) {
    updateFn(_lesonsNamesList[_index]);
  }

  bool _showVideoCheck = false;
  bool get showVideoCheck => _showVideoCheck;
  set showVideoCheck(bool _value) {
    _showVideoCheck = _value;
  }

  bool _isNewLesson = false;
  bool get isNewLesson => _isNewLesson;
  set isNewLesson(bool _value) {
    _isNewLesson = _value;
  }

  bool _isNewVideo = false;
  bool get isNewVideo => _isNewVideo;
  set isNewVideo(bool _value) {
    _isNewVideo = _value;
  }

  DocumentReference? _editCurrentVideo = FirebaseFirestore.instance
      .doc('/lessons/EevRclUAsUAhg5xotY4a/videos/3aiBGbS5MkJDruZcaaxb');
  DocumentReference? get editCurrentVideo => _editCurrentVideo;
  set editCurrentVideo(DocumentReference? _value) {
    _editCurrentVideo = _value;
  }

  List<String> _videosNamesList = [];
  List<String> get videosNamesList => _videosNamesList;
  set videosNamesList(List<String> _value) {
    _videosNamesList = _value;
  }

  void addToVideosNamesList(String _value) {
    _videosNamesList.add(_value);
  }

  void removeFromVideosNamesList(String _value) {
    _videosNamesList.remove(_value);
  }

  void removeAtIndexFromVideosNamesList(int _index) {
    _videosNamesList.removeAt(_index);
  }

  void updateVideosNamesListAtIndex(
    int _index,
    Function(String) updateFn,
  ) {
    updateFn(_videosNamesList[_index]);
  }

  String _editCurrentVideoName = 'Name';
  String get editCurrentVideoName => _editCurrentVideoName;
  set editCurrentVideoName(String _value) {
    _editCurrentVideoName = _value;
  }

  List<int> _editVideoStopPoints = [];
  List<int> get editVideoStopPoints => _editVideoStopPoints;
  set editVideoStopPoints(List<int> _value) {
    _editVideoStopPoints = _value;
  }

  void addToEditVideoStopPoints(int _value) {
    _editVideoStopPoints.add(_value);
  }

  void removeFromEditVideoStopPoints(int _value) {
    _editVideoStopPoints.remove(_value);
  }

  void removeAtIndexFromEditVideoStopPoints(int _index) {
    _editVideoStopPoints.removeAt(_index);
  }

  void updateEditVideoStopPointsAtIndex(
    int _index,
    Function(int) updateFn,
  ) {
    updateFn(_editVideoStopPoints[_index]);
  }

  bool _editStopPointsRefreshed = false;
  bool get editStopPointsRefreshed => _editStopPointsRefreshed;
  set editStopPointsRefreshed(bool _value) {
    _editStopPointsRefreshed = _value;
  }

  DocumentReference? _classesSubject =
      FirebaseFirestore.instance.doc('/subjects/q2TuFFVoOoSuPcH1LudZ');
  DocumentReference? get classesSubject => _classesSubject;
  set classesSubject(DocumentReference? _value) {
    _classesSubject = _value;
  }

  int _classesYear = 8;
  int get classesYear => _classesYear;
  set classesYear(int _value) {
    _classesYear = _value;
  }

  DocumentReference? _classesChapter =
      FirebaseFirestore.instance.doc('/chapters/XOUTPI9F9aD34LXagxK7');
  DocumentReference? get classesChapter => _classesChapter;
  set classesChapter(DocumentReference? _value) {
    _classesChapter = _value;
  }

  String _classesChapterName = '1. Ievads';
  String get classesChapterName => _classesChapterName;
  set classesChapterName(String _value) {
    _classesChapterName = _value;
  }

  String _classesSubjectName = 'Matemātika';
  String get classesSubjectName => _classesSubjectName;
  set classesSubjectName(String _value) {
    _classesSubjectName = _value;
  }

  bool _hasTests = false;
  bool get hasTests => _hasTests;
  set hasTests(bool _value) {
    _hasTests = _value;
  }

  bool _needUpdatePath = false;
  bool get needUpdatePath => _needUpdatePath;
  set needUpdatePath(bool _value) {
    _needUpdatePath = _value;
  }

  int _editVideoIndex = 0;
  int get editVideoIndex => _editVideoIndex;
  set editVideoIndex(int _value) {
    _editVideoIndex = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
