// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'dart:async';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({
    Key? key,
    this.width,
    this.height,
    this.videoUrl,
    this.stopPoints,
    this.updateAction,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? videoUrl;
  final List<int>? stopPoints;
  final Future<dynamic> Function()? updateAction;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late String videoUrl;
  late List<int> stopPoints;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  //List<Timer> _timers = [];
  @override
  void initState() {
    super.initState();
    videoUrl = widget.videoUrl ?? '';
    stopPoints = widget.stopPoints ?? <int>[];
    stopPoints.sort();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      for (final msecond in stopPoints) {
        if (_controller.value.position.inMilliseconds >= msecond &&
            _controller.value.position.inMilliseconds < msecond + 500) {
          _pauseVideo();
          stopPoints.remove(msecond);
          break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPauseVideo() {
    if (_isPlaying) {
      _pauseVideo();
    } else {
      _playVideo();
    }
  }

  void _playVideo() {
    setState(() {
      _isPlaying = true;
    });
    _controller.play();
    _controller.setPlaybackSpeed(_playbackSpeed);
  }

  void _pauseVideo() {
    setState(() {
      _isPlaying = false;
    });
    _controller.pause();
  }

  void _setPlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
    });
    _controller.setPlaybackSpeed(_playbackSpeed);
  }

  Future<void> _playNext() async {
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // Fetch the current lesson from the "users" collection
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    String userdata = '';
    if (!userSnapshot.exists) {
      FFAppState().Log = 'User Not Exists';
    } else {
      DocumentReference dr =
          userSnapshot.get("current_lesson") as DocumentReference;
      userdata = dr.id; //dr.path.split('/')[1];
    }
    FFAppState().Log += 'currentLesson: ' + userdata;
    String currentLesson = userdata;
    DocumentSnapshot lesson = await FirebaseFirestore.instance
        .collection('lessons')
        .doc(currentLesson)
        .get();
    if (!lesson.exists) {
      FFAppState().Log += 'Lesson Not Exists';
    } else {
      userdata = lesson.get("lesson_name") as String;
      FFAppState().Log = 'lesson: ' + userdata;
    }
    int videoCount = (await FirebaseFirestore.instance
            .collection('lessons')
            .doc(currentLesson)
            .collection('videos')
            .where('videoOriginPath', isNotEqualTo: videoUrl)
            .get())
        .docs
        .length;
    FFAppState().Log += ' videoCount: ' + videoCount.toString();
    FFAppState().Log +=
        ' ShowedVideos: ' + FFAppState().showedVideos.length.toString();
    if (videoCount > 0 && FFAppState().showedVideos.length < videoCount) {
      var showedVideos = [videoUrl];
      if (FFAppState().showedVideos.length > 0) {
        FFAppState()
            .showedVideos
            .forEach((videoURL) => showedVideos.add(videoURL));
      }
      FFAppState().showedVideos.add(videoUrl);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(currentLesson)
          .collection('videos')
          .where('videoOriginPath', whereNotIn: showedVideos)
          .limit(1)
          .get();
      FFAppState().Log +=
          ' isQueryNotEmpty: ' + querySnapshot.docs.isNotEmpty.toString();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot newVideoDoc = querySnapshot.docs.first;
        String newVideoPath = newVideoDoc.get('videoOriginPath') as String;
        FFAppState().Log += ' newVideoPath: ' + newVideoPath;
        final data = newVideoDoc.data() as Map<String, dynamic>;
        stopPoints = List.from(data?['stopPoints']);
        FFAppState().currentVideoPath = newVideoPath;
        FFAppState().stopPoints = stopPoints;

        // Set the new video URL and stop points
        videoUrl = newVideoPath;
        stopPoints.sort(); //*/

        // Dispose the current controller and create a new one for the new video
        _controller.dispose();
        _controller = VideoPlayerController.network(videoUrl)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
        _controller.addListener(() {
          for (final msecond in stopPoints) {
            if (_controller.value.position.inMilliseconds >= msecond &&
                _controller.value.position.inMilliseconds < msecond + 500) {
              _pauseVideo();
              stopPoints.remove(msecond);
              break;
            }
          }
        });
        // widget.updateAction!();
        // Start playing the new video
        _playVideo();
        //FFAppState().Log = '';
        widget.updateAction!();
      }
    } else {
      DocumentReference chpt = lesson.get('chapter') as DocumentReference;
      final QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('lessons')
          .where('chapter',
              isEqualTo: FirebaseFirestore.instance.doc(chpt.path))
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
          FFAppState().Log += 'Next Lesson is ' + nextLes.get("lesson_name");
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
          widget.updateAction!();
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
            final QuerySnapshot querySnapshot4 = await FirebaseFirestore
                .instance
                .collection('lessons')
                .where('chapter',
                    isEqualTo: FirebaseFirestore.instance
                        .doc(newChapterDoc.reference.path))
                .orderBy('lesson_name')
                .limit(1)
                .get();
            if (querySnapshot4.docs.isNotEmpty) {
              nextLes = querySnapshot4.docs.first;
              FFAppState().Log +=
                  'Next Lesson is ' + nextLes.get("lesson_name");
              //widget.updateAction!();
            }
          } else {
            FFAppState().Log += 'Next Chapter Not Exists';
            widget.updateAction!();
          }
        }
      }
      if (nextLes != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'current_lesson': nextLes.reference});
        FFAppState().showedVideos = <String>[];
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('lessons')
            .doc(nextLes.id)
            .collection('videos')
            .orderBy('name')
            .limit(1)
            .get();
        FFAppState().Log +=
            ' isQueryNotEmpty: ' + querySnapshot.docs.isNotEmpty.toString();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot newVideoDoc = querySnapshot.docs.first;
          String newVideoPath = newVideoDoc.get('videoOriginPath') as String;
          FFAppState().Log += ' newVideoPath: ' + newVideoPath;
          final data = newVideoDoc.data() as Map<String, dynamic>;
          stopPoints = List.from(data?['stopPoints']);
          FFAppState().currentVideoPath = newVideoPath;
          FFAppState().stopPoints = stopPoints;

          // Set the new video URL and stop points
          videoUrl = newVideoPath;
          stopPoints.sort(); //*/

          // Dispose the current controller and create a new one for the new video
          _controller.dispose();
          _controller = VideoPlayerController.network(videoUrl)
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
          _controller.addListener(() {
            for (final msecond in stopPoints) {
              if (_controller.value.position.inMilliseconds >= msecond &&
                  _controller.value.position.inMilliseconds < msecond + 500) {
                _pauseVideo();
                stopPoints.remove(msecond);
                break;
              }
            }
          });
          // widget.updateAction!();
          // Start playing the new video
          _playVideo();
          //FFAppState().Log = '';
          widget.updateAction!();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: _playPauseVideo,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              PopupMenuButton<double>(
                initialValue: _playbackSpeed,
                onSelected: _setPlaybackSpeed,
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 0.25,
                      child: Text("0.25x"),
                    ),
                    PopupMenuItem(
                      value: 0.5,
                      child: Text("0.5x"),
                    ),
                    PopupMenuItem(
                      value: 1.0,
                      child: Text("1.0x"),
                    ),
                    PopupMenuItem(
                      value: 1.5,
                      child: Text("1.5x"),
                    ),
                    PopupMenuItem(
                      value: 2.0,
                      child: Text("2.0x"),
                    ),
                  ];
                },
                child: Row(
                  children: [
                    Text("Speed: "),
                    Text("${_playbackSpeed}x"),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _controller.seekTo(Duration.zero);
                  _playVideo();
                },
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: _playNext,
                icon: Icon(Icons.skip_next),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
