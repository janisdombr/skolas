import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/backbutton_widget.dart';
import '/components/create_new_chapter_widget.dart';
import '/components/create_new_lesson_widget.dart';
import '/components/create_new_subject_widget.dart';
import '/components/subject_choose_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'list_lessons_model.dart';
export 'list_lessons_model.dart';

class ListLessonsWidget extends StatefulWidget {
  const ListLessonsWidget({Key? key}) : super(key: key);

  @override
  _ListLessonsWidgetState createState() => _ListLessonsWidgetState();
}

class _ListLessonsWidgetState extends State<ListLessonsWidget> {
  late ListLessonsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListLessonsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (currentUserDocument?.lastSubject != null) {
        setState(() {
          FFAppState().classesSubject = currentUserDocument?.lastSubject;
        });
      } else {
        final usersUpdateData1 = createUsersRecordData(
          lastSubject: FFAppState().classesSubject,
        );
        await currentUserReference!.update(usersUpdateData1);
      }

      if ((valueOrDefault(currentUserDocument?.year, 0) != null) &&
          (valueOrDefault(currentUserDocument?.year, 0) != 0)) {
        FFAppState().update(() {
          FFAppState().classesYear =
              valueOrDefault(currentUserDocument?.year, 0);
        });
      } else {
        final usersUpdateData2 = createUsersRecordData(
          year: FFAppState().classesYear,
        );
        await currentUserReference!.update(usersUpdateData2);
      }

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
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.backbuttonModel,
                      updateCallback: () => setState(() {}),
                      child: BackbuttonWidget(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '4lyi3tjt' /* Nodarbību katalogs */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 24.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('Profile');
                          },
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              FFAppState().photoURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Mācību priekšmeti ( ${FFAppState().classesSubjectName} )',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                            ),
                      ),
                      if (valueOrDefault(currentUserDocument?.role, '') ==
                          'admin')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: CreateNewSubjectWidget(),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              },
                              text: FFLocalizations.of(context).getText(
                                'rysqjc48' /* Jauns */,
                              ),
                              icon: Icon(
                                Icons.post_add,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 1.0, 0.0),
                child: StreamBuilder<List<SubjectsRecord>>(
                  stream: querySubjectsRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      );
                    }
                    List<SubjectsRecord> rowCategoriesSubjectsRecordList =
                        snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            rowCategoriesSubjectsRecordList.length,
                            (rowCategoriesIndex) {
                          final rowCategoriesSubjectsRecord =
                              rowCategoriesSubjectsRecordList[
                                  rowCategoriesIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 8.0, 0.0, 8.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: rowCategoriesSubjectsRecord
                                                .reference ==
                                            FFAppState().classesSubject
                                        ? FlutterFlowTheme.of(context).primary
                                        : Color(0x00000000),
                                    width: 1.0,
                                  ),
                                ),
                                child: SubjectChooseWidget(
                                  key: Key(
                                      'Key316_${rowCategoriesIndex}_of_${rowCategoriesSubjectsRecordList.length}'),
                                  name: rowCategoriesSubjectsRecord.name,
                                  classes: rowCategoriesSubjectsRecord.classes,
                                  subjectRef:
                                      rowCategoriesSubjectsRecord.reference,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0x430F1113),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 4.0, 20.0, 0.0),
                          child: StreamBuilder<List<ChaptersRecord>>(
                            stream: queryChaptersRecord(
                              queryBuilder: (chaptersRecord) => chaptersRecord
                                  .where('subject',
                                      isEqualTo: FFAppState().classesSubject)
                                  .where('year',
                                      isEqualTo: FFAppState().classesYear)
                                  .orderBy('name'),
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
                              List<ChaptersRecord>
                                  dropDownChaptersChaptersRecordList =
                                  snapshot.data!;
                              return FlutterFlowDropDown<String>(
                                controller:
                                    _model.dropDownChaptersValueController ??=
                                        FormFieldController<String>(null),
                                options: dropDownChaptersChaptersRecordList
                                    .map((e) => e.name)
                                    .toList(),
                                onChanged: (val) async {
                                  setState(
                                      () => _model.dropDownChaptersValue = val);
                                  setState(() {
                                    FFAppState().classesChapter =
                                        dropDownChaptersChaptersRecordList
                                            .where((e) =>
                                                e.name ==
                                                _model.dropDownChaptersValue)
                                            .toList()
                                            .first
                                            .reference;
                                    FFAppState().classesChapterName =
                                        _model.dropDownChaptersValue!;
                                  });
                                },
                                width: 180.0,
                                height: 50.0,
                                searchHintTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyMedium,
                                hintText: FFLocalizations.of(context).getText(
                                  'of6clckv' /* Izvēlieties tēmu */,
                                ),
                                searchHintText:
                                    FFLocalizations.of(context).getText(
                                  '4se7mzma' /* Search for an item... */,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor: Colors.transparent,
                                borderWidth: 0.0,
                                borderRadius: 0.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 4.0, 12.0, 4.0),
                                hidesUnderline: true,
                                isSearchable: false,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (valueOrDefault(currentUserDocument?.role, '') == 'admin')
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: CreateNewChapterWidget(
                                    subjectRef: FFAppState().classesSubject!,
                                    subjectName:
                                        FFAppState().classesSubjectName,
                                    year: FFAppState().classesYear,
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          text: FFLocalizations.of(context).getText(
                            '5op9z6wv' /* Jauna tēma */,
                          ),
                          icon: Icon(
                            Icons.post_add,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 20.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Klases par tēmu ${FFAppState().classesChapterName}',
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                    if (valueOrDefault(currentUserDocument?.role, '') ==
                        'admin')
                      AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: CreateNewLessonWidget(
                                    chapterRef: FFAppState().classesChapter!,
                                    chapterName:
                                        FFAppState().classesChapterName,
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          text: FFLocalizations.of(context).getText(
                            'rz59njsj' /* Jauna nodarbība */,
                          ),
                          icon: Icon(
                            Icons.post_add,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                child: StreamBuilder<List<LessonsRecord>>(
                  stream: queryLessonsRecord(
                    queryBuilder: (lessonsRecord) => lessonsRecord
                        .where('chapter',
                            isEqualTo: FFAppState().classesChapter)
                        .orderBy('lesson_name'),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      );
                    }
                    List<LessonsRecord> listViewLessonsRecordList =
                        snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewLessonsRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewLessonsRecord =
                            listViewLessonsRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 2.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listViewLessonsRecord
                                                    .lessonName,
                                                textAlign: TextAlign.start,
                                                maxLines: 3,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                              Text(
                                                FFAppState().classesChapterName,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Color(0xFF39D2C0),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                final usersUpdateData =
                                                    createUsersRecordData(
                                                  currentLesson:
                                                      listViewLessonsRecord
                                                          .reference,
                                                  lastChapter:
                                                      listViewLessonsRecord
                                                          .chapter,
                                                  lastSubject: FFAppState()
                                                      .classesSubject,
                                                  year:
                                                      FFAppState().classesYear,
                                                );
                                                await currentUserReference!
                                                    .update(usersUpdateData);

                                                context.pushNamed('LessonNew');
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'y0j1rv33' /* Skatīties */,
                                              ),
                                              icon: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.white,
                                                size: 15.0,
                                              ),
                                              options: FFButtonOptions(
                                                width: 120.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: Color(0xFF39D2C0),
                                                textStyle: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if ((listViewLessonsRecord.owner ==
                                                  currentUserReference) ||
                                              (valueOrDefault(
                                                      currentUserDocument?.role,
                                                      '') ==
                                                  'admin'))
                                            AuthUserStreamWidget(
                                              builder: (context) =>
                                                  StreamBuilder<
                                                      List<VideosRecord>>(
                                                stream: queryVideosRecord(
                                                  parent: listViewLessonsRecord
                                                      .reference,
                                                ),
                                                builder: (context, snapshot) {
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
                                                  List<VideosRecord>
                                                      buttonEditVideosRecordList =
                                                      snapshot.data!;
                                                  return FFButtonWidget(
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'LessonEdit',
                                                        queryParameters: {
                                                          'lesson':
                                                              serializeParam(
                                                            listViewLessonsRecord,
                                                            ParamType.Document,
                                                          ),
                                                          'videos':
                                                              serializeParam(
                                                            buttonEditVideosRecordList,
                                                            ParamType.Document,
                                                            true,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'lesson':
                                                              listViewLessonsRecord,
                                                          'videos':
                                                              buttonEditVideosRecordList,
                                                        },
                                                      );
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'iu9odgdu' /* Rediģēt */,
                                                    ),
                                                    icon: Icon(
                                                      Icons.edit_rounded,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 120.0,
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
                                                      color: Color(0xFF39D2C0),
                                                      textStyle:
                                                          GoogleFonts.getFont(
                                                        'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                      ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
