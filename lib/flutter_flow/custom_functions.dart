import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? convertVideoPathToString(String? videoPath) {
  // convert videoPath to String
  if (videoPath == null) {
    return null;
  }
  return json.encode(videoPath);
}

String? convertRefToString(String? docRef) {
  String currentLesson = docRef != null ? docRef : '';
  if (docRef != null) {
    currentLesson = currentLesson.split('(')[1].split(')')[0].split('/')[1];
    return currentLesson;
  }
  return null;
}

List<VideosRecord> videoDocToArray(VideosRecord video) {
  List<VideosRecord> ret = <VideosRecord>[];
  ret.add(video);
  return ret;
}

List<int> getStopPointsFromListOfVideos(
  int index,
  List<VideosRecord> listOfVideos,
) {
  List<int> res = <int>[];

  if (listOfVideos[index].hasStopPoints()) {
    res = listOfVideos[index].stopPoints;
  }
  res.sort();
  return res;
}
