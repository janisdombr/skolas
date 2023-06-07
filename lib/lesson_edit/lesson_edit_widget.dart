import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/backbutton_widget.dart';
import '/components/check_box_answers_widget.dart';
import '/components/radio_answers_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lesson_edit_model.dart';
export 'lesson_edit_model.dart';

class LessonEditWidget extends StatefulWidget {
  const LessonEditWidget({
    Key? key,
    required this.lesson,
    required this.videos,
  }) : super(key: key);

  final LessonsRecord? lesson;
  final List<VideosRecord>? videos;

  @override
  _LessonEditWidgetState createState() => _LessonEditWidgetState();
}

class _LessonEditWidgetState extends State<LessonEditWidget> {
  late LessonEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LessonEditModel());

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

      setState(() {
        FFAppState().showVideoCheck = false;
      });
    });

    _model.textFieldLessonNameController ??=
        TextEditingController(text: widget.lesson!.lessonName);
    _model.textFieldVideoNameController ??= TextEditingController(
        text: widget.videos?[FFAppState().editVideoIndex]!.name);
    _model.textFieldPointController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _model.textFieldPointController?.text =
              FFLocalizations.of(context).getText(
            'ni8btphm' /* 1000 */,
          );
        }));
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 5.0, 5.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x4D101213),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownVIdeosValueController ??=
                                            FormFieldController<String>(
                                      _model.dropDownVIdeosValue ??=
                                          widget.videos?.first!.name,
                                    ),
                                    options: widget.videos!
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (val) async {
                                      setState(() =>
                                          _model.dropDownVIdeosValue = val);
                                      setState(() {
                                        FFAppState().showVideoCheck = false;
                                        FFAppState().editStopPointsRefreshed =
                                            false;
                                        FFAppState().editVideoIndex = widget
                                            .videos!
                                            .map((e) => e.name)
                                            .toList()
                                            .indexOf(
                                                _model.dropDownVIdeosValue!);
                                      });
                                      setState(() {
                                        _model.textFieldVideoNameController
                                                ?.text =
                                            _model.dropDownVIdeosValue!;
                                      });
                                    },
                                    width: 180.0,
                                    height: 50.0,
                                    searchHintTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                    textStyle:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '6z1yjk0a' /* Please select... */,
                                    ),
                                    searchHintText:
                                        FFLocalizations.of(context).getText(
                                      'tuqvod2i' /* Search for an item... */,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0.0,
                                    borderRadius: 8.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 4.0, 12.0, 4.0),
                                    hidesUnderline: true,
                                    isSearchable: false,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 5.0, 5.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x4D101213),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        _model.textFieldLessonNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          FFLocalizations.of(context).getText(
                                        'jw10ztpq' /* Lesson name */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    validator: _model
                                        .textFieldLessonNameControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 5.0, 5.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Color(0x4D101213),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        _model.textFieldVideoNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          FFLocalizations.of(context).getText(
                                        'vpqtz8r8' /* Video name */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    validator: _model
                                        .textFieldVideoNameControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    FFAppState().showVideoCheck = true;
                                    FFAppState().editStopPointsRefreshed = true;
                                  });
                                },
                                text: FFLocalizations.of(context).getText(
                                  'oz0eo6xr' /* Check video */,
                                ),
                                icon: Icon(
                                  Icons.check,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 19.0, 0.0),
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
                            FFButtonWidget(
                              onPressed: () async {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: false,
                                  allowVideo: true,
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(() => _model.isDataUploading = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];
                                  var downloadUrls = <String>[];
                                  try {
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                              height: m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(
                                            m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    _model.isDataUploading = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() {
                                      _model.uploadedLocalFile =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl =
                                          downloadUrls.first;
                                    });
                                  } else {
                                    setState(() {});
                                    return;
                                  }
                                }
                              },
                              text: FFLocalizations.of(context).getText(
                                'cop5nl59' /* Update video */,
                              ),
                              icon: Icon(
                                Icons.cloud_upload,
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
                          ],
                        ),
                        if (FFAppState().showVideoCheck)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 380.0,
                                  height: 240.0,
                                  child: custom_widgets.FlickVideoPlayerDefault(
                                    width: 380.0,
                                    height: 240.0,
                                    videoUrl: widget
                                        .videos?[FFAppState().editVideoIndex]!
                                        .videoOriginPath,
                                    stopPoints:
                                        functions.getStopPointsFromListOfVideos(
                                            FFAppState().editVideoIndex,
                                            widget.videos!.toList()),
                                    updatePage: () async {
                                      setState(() {
                                        FFAppState().currentVideoPath = widget
                                            .videos![
                                                FFAppState().editVideoIndex]
                                            .videoOriginPath;
                                        FFAppState().stopPoints = functions
                                            .getStopPointsFromListOfVideos(
                                                FFAppState().editVideoIndex,
                                                widget.videos!.toList())
                                            .toList();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (FFAppState().showVideoCheck)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 5.0, 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x4D101213),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: FlutterFlowDropDown<String>(
                                      controller: _model
                                              .dropDownPointsValueController ??=
                                          FormFieldController<String>(null),
                                      options: functions
                                          .getStopPointsFromListOfVideos(
                                              FFAppState().editVideoIndex,
                                              widget.videos!.toList())
                                          .map((e) => valueOrDefault<String>(
                                                e.toString(),
                                                '0',
                                              ))
                                          .toList(),
                                      onChanged: (val) => setState(() =>
                                          _model.dropDownPointsValue = val),
                                      width: 180.0,
                                      height: 50.0,
                                      searchHintTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'd9yr3pd4' /* Stop points */,
                                      ),
                                      searchHintText:
                                          FFLocalizations.of(context).getText(
                                        '3u9csjov' /* Search for an item... */,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 4.0, 12.0, 4.0),
                                      hidesUnderline: true,
                                      isSearchable: false,
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    FFAppState().removeFromEditVideoStopPoints(
                                        (String? var1) {
                                      return int.parse(var1 ?? '0');
                                    }(_model.dropDownPointsValue));
                                  });
                                },
                                text: FFLocalizations.of(context).getText(
                                  'm8eoe1c7' /* Delete point */,
                                ),
                                icon: Icon(
                                  Icons.delete,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: 130.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
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
                            ],
                          ),
                        if (FFAppState().showVideoCheck)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 5.0, 5.0, 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x4D101213),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextFormField(
                                      controller:
                                          _model.textFieldPointController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText:
                                            FFLocalizations.of(context).getText(
                                          'cjcffnzg' /* Point to add (ms) */,
                                        ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          'hjr372pd' /* in milliseconds */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodySmall,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                      validator: _model
                                          .textFieldPointControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    FFAppState().addToEditVideoStopPoints(
                                        valueOrDefault<int>(
                                      int.tryParse(
                                          _model.textFieldPointController.text),
                                      0,
                                    ));
                                  });
                                },
                                text: FFLocalizations.of(context).getText(
                                  'hyg73f4y' /* New point */,
                                ),
                                icon: Icon(
                                  Icons.add,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: 130.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
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
                            ],
                          ),
                        if (FFAppState().ShowTest)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: StreamBuilder<List<TestsRecord>>(
                                  stream: queryTestsRecord(
                                    parent: widget.lesson!.reference,
                                    queryBuilder: (testsRecord) => testsRecord
                                        .where('videoRef',
                                            isEqualTo: widget
                                                .videos?[FFAppState()
                                                    .editVideoIndex]!
                                                .reference)
                                        .where('radio', isEqualTo: true),
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
                                    List<TestsRecord> columnTestsRecordList =
                                        snapshot.data!;
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            columnTestsRecordList.length,
                                            (columnIndex) {
                                          final columnTestsRecord =
                                              columnTestsRecordList[
                                                  columnIndex];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      columnTestsRecord
                                                          .question,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .radioAnswersModels
                                                            .getModel(
                                                          columnTestsRecord
                                                              .reference.id,
                                                          columnIndex,
                                                        ),
                                                        updateCallback: () =>
                                                            setState(() {}),
                                                        child:
                                                            RadioAnswersWidget(
                                                          key: Key(
                                                            'Keyjbb_${columnTestsRecord.reference.id}',
                                                          ),
                                                          answers:
                                                              columnTestsRecord
                                                                  .answers,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                                child: StreamBuilder<List<TestsRecord>>(
                                  stream: queryTestsRecord(
                                    parent: widget.lesson!.reference,
                                    queryBuilder: (testsRecord) => testsRecord
                                        .where('radio', isEqualTo: false)
                                        .where('videoRef',
                                            isEqualTo: widget
                                                .videos?[FFAppState()
                                                    .editVideoIndex]!
                                                .reference),
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
                                    List<TestsRecord> columnTestsRecordList =
                                        snapshot.data!;
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            columnTestsRecordList.length,
                                            (columnIndex) {
                                          final columnTestsRecord =
                                              columnTestsRecordList[
                                                  columnIndex];
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      columnTestsRecord
                                                          .question,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          CheckBoxAnswersWidget(
                                                        key: Key(
                                                            'Key36f_${columnIndex}_of_${columnTestsRecordList.length}'),
                                                        answers:
                                                            columnTestsRecord
                                                                .answers,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    final lessonsUpdateData = {
                                      ...createLessonsRecordData(
                                        lessonName: _model
                                            .textFieldLessonNameController.text,
                                      ),
                                      'last_edited':
                                          FieldValue.serverTimestamp(),
                                    };
                                    await FFAppState()
                                        .editCurrentLesson!
                                        .update(lessonsUpdateData);
                                    if (_model.uploadedFileUrl != null &&
                                        _model.uploadedFileUrl != '') {
                                      final videosUpdateData1 = {
                                        ...createVideosRecordData(
                                          videoOriginPath:
                                              _model.uploadedFileUrl,
                                          name: _model
                                              .textFieldVideoNameController
                                              .text,
                                        ),
                                        'stopPoints':
                                            FFAppState().editVideoStopPoints,
                                      };
                                      await FFAppState()
                                          .editCurrentVideo!
                                          .update(videosUpdateData1);
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Save'),
                                            content:
                                                Text('Lesson has been saved'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      if (FFAppState().showVideoCheck) {
                                        final videosUpdateData2 = {
                                          ...createVideosRecordData(
                                            name: _model
                                                .textFieldVideoNameController
                                                .text,
                                          ),
                                          'stopPoints':
                                              FFAppState().editVideoStopPoints,
                                        };
                                        await FFAppState()
                                            .editCurrentVideo!
                                            .update(videosUpdateData2);
                                      } else {
                                        final videosUpdateData3 =
                                            createVideosRecordData(
                                          name: _model
                                              .textFieldVideoNameController
                                              .text,
                                        );
                                        await FFAppState()
                                            .editCurrentVideo!
                                            .update(videosUpdateData3);
                                      }

                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Save'),
                                            content:
                                                Text('Lesson has been saved'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }

                                    context.safePop();
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'u69z2viu' /* Save */,
                                  ),
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      FFAppState().ShowTest = true;
                                    });
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'zmjh25tq' /* Rādīt testus */,
                                  ),
                                  options: FFButtonOptions(
                                    width: 130.0,
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              FFAppState().Log,
                              maxLines: 5,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
