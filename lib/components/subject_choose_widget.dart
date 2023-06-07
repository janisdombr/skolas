import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'subject_choose_model.dart';
export 'subject_choose_model.dart';

class SubjectChooseWidget extends StatefulWidget {
  const SubjectChooseWidget({
    Key? key,
    required this.classes,
    String? name,
    required this.subjectRef,
  })  : this.name = name ?? 'name',
        super(key: key);

  final List<int>? classes;
  final String name;
  final DocumentReference? subjectRef;

  @override
  _SubjectChooseWidgetState createState() => _SubjectChooseWidgetState();
}

class _SubjectChooseWidgetState extends State<SubjectChooseWidget> {
  late SubjectChooseModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubjectChooseModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Text(
            widget.name,
            style: FlutterFlowTheme.of(context).bodySmall,
          ),
        ),
        FlutterFlowDropDown<String>(
          controller: _model.dropDownValueController ??=
              FormFieldController<String>(
            _model.dropDownValue ??=
                widget.subjectRef?.id == FFAppState().classesSubject?.id
                    ? FFAppState().classesYear.toString()
                    : null,
          ),
          options: widget.classes!.map((e) => e.toString()).toList(),
          onChanged: (val) async {
            setState(() => _model.dropDownValue = val);
            FFAppState().update(() {
              FFAppState().classesYear = int.parse(_model.dropDownValue!);
              FFAppState().classesSubject = widget.subjectRef;
              FFAppState().classesSubjectName = widget.name;
            });
          },
          width: 180.0,
          height: 50.0,
          searchHintTextStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
          textStyle: FlutterFlowTheme.of(context).bodyMedium,
          hintText: FFLocalizations.of(context).getText(
            '7933sx1s' /* class */,
          ),
          searchHintText: FFLocalizations.of(context).getText(
            'uvtd7c7k' /* Search for an item... */,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          margin: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
          hidesUnderline: true,
          isSearchable: false,
        ),
      ],
    );
  }
}
