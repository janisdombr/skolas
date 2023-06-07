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

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class FlickVideoPlayerDefault extends StatefulWidget {
  const FlickVideoPlayerDefault({
    Key? key,
    this.width,
    this.height,
    this.videoUrl,
    this.stopPoints,
    this.updatePage,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? videoUrl;
  final List<int>? stopPoints;
  final Future<dynamic> Function()? updatePage;

  @override
  _FlickVideoPlayerDefaultState createState() =>
      _FlickVideoPlayerDefaultState();
}

class _FlickVideoPlayerDefaultState extends State<FlickVideoPlayerDefault> {
  late FlickManager flickManager;
  late VideoPlayerController _controller;
  late List<int> stopPoints;
  late String videoUrl;
  @override
  void initState() {
    super.initState();
    videoUrl = widget.videoUrl ?? '';
    stopPoints = widget.stopPoints ?? <int>[];
    stopPoints.sort();
    _controller = VideoPlayerController.network(
      videoUrl,
      //closedCaptionFile: _loadCaptions(),
    );
    FFAppState().currentVideoPath = videoUrl;
    FFAppState().Log =
        '\nPath: ' + FFAppState().currentVideoPath.split('/').last;
    widget.updatePage!();
    _controller.addListener(() {
      for (final msecond in stopPoints) {
        if (_controller.value.position.inMilliseconds >= msecond &&
            _controller.value.position.inMilliseconds < msecond + 500) {
          //_pauseVideo();
          //_controller.pause();
          flickManager.flickControlManager?.autoPause();
          stopPoints.remove(msecond);
          break;
        }
      }
      if (FFAppState().needUpdatePath) {
        widget.updatePage!();
        FFAppState().needUpdatePath = false;
      }
      if (videoUrl != FFAppState().currentVideoPath) {
        videoUrl = FFAppState().currentVideoPath;
        stopPoints = FFAppState().stopPoints;
        stopPoints.sort();
        _changeVideo(FFAppState().currentVideoPath);
      }
    });
    flickManager =
        FlickManager(videoPlayerController: _controller, autoPlay: false);
    flickManager.flickControlManager?.unmute();
  }

  void _changeVideo(String NewUrl) async {
    FFAppState().Log += '\n _changeVideo IN';
    widget.updatePage!();
    videoUrl = NewUrl;
    _controller.dispose();
    flickManager.dispose();
    _controller = VideoPlayerController.network(
      videoUrl,
      //closedCaptionFile: _loadCaptions(),
    );
    _controller.addListener(() {
      for (final msecond in stopPoints) {
        if (_controller.value.position.inMilliseconds >= msecond &&
            _controller.value.position.inMilliseconds < msecond + 500) {
          //_pauseVideo();
          flickManager.flickControlManager?.autoPause();
          stopPoints.remove(msecond);
          break;
        }
      }
      if (FFAppState().needUpdatePath) {
        widget.updatePage!();
        FFAppState().needUpdatePath = false;
      }
      if (videoUrl != FFAppState().currentVideoPath) {
        videoUrl = FFAppState().currentVideoPath;
        _changeVideo(FFAppState().currentVideoPath);
      }
    });
    flickManager =
        FlickManager(videoPlayerController: _controller, autoPlay: true);
    flickManager.flickControlManager?.autoResume();
    flickManager.flickControlManager?.unmute();
    FFAppState().Log += '\n _changeVideo OUT';
    widget.updatePage!();
  }

  ///If you have subtitle assets

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('images/bumble_bee_captions.srt');
    flickManager.flickControlManager!.toggleSubtitle();
    return SubRipCaptionFile(fileContents);
  }

  ///If you have subtitle urls

  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final url = Uri.parse('SUBTITLE URL LINK');
  //   try {
  //     final data = await http.get(url);
  //     final srtContent = data.body.toString();
  //     print(srtContent);
  //     return SubRipCaptionFile(srtContent);
  //   } catch (e) {
  //     print('Failed to get subtitles for ${e}');
  //     return SubRipCaptionFile('');
  //   }
  //}

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Container(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: FlickVideoWithControls(
              closedCaptionTextStyle: TextStyle(fontSize: 8),
              iconThemeData: IconThemeData(color: Colors.grey),
              controls: FlickPortraitControls(),
              textStyle: TextStyle(color: Colors.grey, fontSize: 12)),
          flickVideoWithControlsFullscreen: FlickVideoWithControls(
              iconThemeData: IconThemeData(color: Colors.grey),
              controls: FlickLandscapeControls(),
              textStyle: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
    );
  }
}
