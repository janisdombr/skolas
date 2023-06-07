import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/check_box_answers_widget.dart';
import '/components/radio_answers_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lesson_new_model.dart';
export 'lesson_new_model.dart';
import 'dart:math';

class LessonNewWidget extends StatefulWidget {
  const LessonNewWidget({Key? key}) : super(key: key);

  @override
  _LessonNewWidgetState createState() => _LessonNewWidgetState();
}

class _LessonNewWidgetState extends State<LessonNewWidget> {
  late LessonNewModel _model;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonNewModel());
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (height < width) {
      width = double.parse((height*1.778).toStringAsFixed(0));
    }
    else
    {
      height = double.parse((width/1.778).toStringAsFixed(0));
    }
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserPhoto != null && currentUserPhoto != '') {
        setState(() {
          FFAppState().photoURL = currentUserPhoto;
        });
      } else {
        setState(() {
          FFAppState().photoURL =
              'https://firebasestorage.googleapis.com/v0/b/skolaslv.appspot.com/o/avatarblank.png?alt=media&token=4605dcb7-e4f3-4b09-8a22-f9646181d94e';
        });
      }

      if ((currentUserUid != null && currentUserUid != '') &&
          (currentUserDocument?.currentLesson == null)) {
        final usersUpdateData = createUsersRecordData(
          currentLesson: FFAppState().editCurrentLesson,
        );
        await currentUserReference!.update(usersUpdateData);
      }
      _model.getTestsFromVideo = await actions.getListFromCollection(
        'tests',
        'question',
        true,
        currentUserDocument?.currentLesson?.id,
        null,
        null,
      );
      setState(() {
        FFAppState().hasTests = _model.getTestsFromVideo!.length > 0;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) => FutureBuilder<int>(
        future: queryVideosRecordCount(
          parent: currentUserDocument?.currentLesson,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ),
            );
          }
          int lessonNewCount = snapshot.data!;
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      StreamBuilder<LessonsRecord>(
                        stream: LessonsRecord.getDocument(
                            currentUserDocument!.currentLesson!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                              ),
                            );
                          }
                          final columnLessonsRecord = snapshot.data!;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                StreamBuilder<List<VideosRecord>>(
                                  stream: queryVideosRecord(
                                    parent: columnLessonsRecord.reference,
                                    queryBuilder: (videosRecord) =>
                                        videosRecord.whereNotIn(
                                            'videoOriginPath',
                                            FFAppState().showedVideos),
                                    singleRecord: true,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                        ),
                                      );
                                    }
                                    List<VideosRecord> columnVideosRecordList =
                                        snapshot.data!;
                                    final columnVideosRecord =
                                        columnVideosRecordList.isNotEmpty
                                            ? columnVideosRecordList.first
                                            : null;
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 5.0,
                                                                5.0, 5.0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      borderRadius: 25.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 50.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      icon: Icon(
                                                        Icons.menu,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 25.0,
                                                      ),
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                            'ListLessons');
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            columnLessonsRecord
                                                                .lessonName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (columnVideosRecord!
                                                                .name !=
                                                            columnLessonsRecord
                                                                .lessonName)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              columnVideosRecord!
                                                                  .name,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                5.0, 0.0),
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                              'Profile');
                                                        },
                                                        child: Container(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            FFAppState()
                                                                .photoURL,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: height,
                                                  child: custom_widgets
                                                      .FlickVideoPlayerDefault(
                                                    width: width,
                                                    height: height,
                                                    videoUrl:
                                                        columnVideosRecord!
                                                            .videoOriginPath,
                                                    stopPoints:
                                                        columnVideosRecord!
                                                            .stopPoints,
                                                    updatePage: () async {
                                                      setState(() {
                                                        FFAppState()
                                                                .currentVideoPath =
                                                            columnVideosRecord!
                                                                .videoOriginPath;
                                                        FFAppState()
                                                                .stopPoints =
                                                            columnVideosRecord!
                                                                .stopPoints
                                                                .toList();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (FFAppState().ShowTest)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: StreamBuilder<
                                                      List<TestsRecord>>(
                                                    stream: queryTestsRecord(
                                                      parent:
                                                          currentUserDocument
                                                              ?.currentLesson,
                                                      queryBuilder: (testsRecord) =>
                                                          testsRecord
                                                              .where(
                                                                  'videoRef',
                                                                  isEqualTo:
                                                                      columnVideosRecord!
                                                                          .reference)
                                                              .where('radio',
                                                                  isEqualTo:
                                                                      true),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<TestsRecord>
                                                          columnTestsRecordList =
                                                          snapshot.data!;
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                              columnTestsRecordList
                                                                  .length,
                                                              (columnIndex) {
                                                            final columnTestsRecord =
                                                                columnTestsRecordList[
                                                                    columnIndex];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      columnTestsRecord
                                                                          .question,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          wrapWithModel(
                                                                        model: _model
                                                                            .radioAnswersModels
                                                                            .getModel(
                                                                          columnTestsRecord
                                                                              .reference
                                                                              .id,
                                                                          columnIndex,
                                                                        ),
                                                                        updateCallback:
                                                                            () =>
                                                                                setState(() {}),
                                                                        child:
                                                                            RadioAnswersWidget(
                                                                          key:
                                                                              Key(
                                                                            'Keyd8p_${columnTestsRecord.reference.id}',
                                                                          ),
                                                                          answers:
                                                                              columnTestsRecord.answers,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (FFAppState().ShowTest)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: StreamBuilder<
                                                      List<TestsRecord>>(
                                                    stream: queryTestsRecord(
                                                      parent:
                                                          currentUserDocument
                                                              ?.currentLesson,
                                                      queryBuilder: (testsRecord) =>
                                                          testsRecord
                                                              .where('radio',
                                                                  isEqualTo:
                                                                      false)
                                                              .where('videoRef',
                                                                  isEqualTo:
                                                                      columnVideosRecord!
                                                                          .reference),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<TestsRecord>
                                                          columnTestsRecordList =
                                                          snapshot.data!;
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: List.generate(
                                                              columnTestsRecordList
                                                                  .length,
                                                              (columnIndex) {
                                                            final columnTestsRecord =
                                                                columnTestsRecordList[
                                                                    columnIndex];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      columnTestsRecord
                                                                          .question,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          CheckBoxAnswersWidget(
                                                                        key: Key(
                                                                            'Keyn55_${columnIndex}_of_${columnTestsRecordList.length}'),
                                                                        answers:
                                                                            columnTestsRecord.answers,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (!FFAppState().ShowTest &&
                                                    FFAppState().hasTests)
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      setState(() {
                                                        FFAppState().ShowTest =
                                                            true;
                                                      });
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'dvhybsb2' /* Start test */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 130.0,
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                if (FFAppState().hasTests)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                0.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Pabeigt'),
                                                              content: Text(
                                                                  'Labi padarīts! Jūs esat uzvarētājs!'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        setState(() {
                                                          FFAppState()
                                                              .ShowTest = false;
                                                        });
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'czpse6g1' /* Finish */,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width: 130.0,
                                                        height: 40.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      if (lessonNewCount >
                                                          (FFAppState()
                                                                  .showedVideos
                                                                  .length +
                                                              1)) {
                                                        setState(() {
                                                          FFAppState().addToShowedVideos(
                                                              columnVideosRecord!
                                                                  .videoOriginPath);
                                                        });
                                                        await Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    1000));
                                                        setState(() {
                                                          FFAppState()
                                                                  .needUpdatePath =
                                                              true;
                                                        });
                                                      } else {
                                                        _model.nextlesson =
                                                            await actions
                                                                .getNextLesson(
                                                          columnLessonsRecord
                                                              .reference,
                                                        );
                                                        if (_model.nextlesson ==
                                                            null) {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Apsveicu'),
                                                                content: Text(
                                                                    'Priekšmets ir pabeigts'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ok'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          final usersUpdateData =
                                                              createUsersRecordData(
                                                            currentLesson:
                                                                _model
                                                                    .nextlesson!
                                                                    .reference,
                                                            lastChapter: _model
                                                                .nextlesson!
                                                                .chapter,
                                                          );
                                                          await currentUserReference!
                                                              .update(
                                                                  usersUpdateData);
                                                          FFAppState()
                                                              .update(() {
                                                            FFAppState()
                                                                .showedVideos = [];
                                                            FFAppState()
                                                                    .needUpdatePath =
                                                                true;
                                                          });
                                                          _model.getTestsFromVideo2 =
                                                              await actions
                                                                  .getListFromCollection(
                                                            'tests',
                                                            'question',
                                                            true,
                                                            _model.nextlesson!
                                                                .reference.id,
                                                            null,
                                                            null,
                                                          );
                                                          setState(() {
                                                            FFAppState()
                                                                .hasTests = _model
                                                                    .getTestsFromVideo!
                                                                    .length >
                                                                0;
                                                          });
                                                        }
                                                      }

                                                      setState(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'xafd04i8' /* Next */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 130.0,
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (false)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  AutoSizeText(
                                                    FFAppState().Log,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
