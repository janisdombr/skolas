import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'check_box_answers_model.dart';
export 'check_box_answers_model.dart';

class CheckBoxAnswersWidget extends StatefulWidget {
  const CheckBoxAnswersWidget({
    Key? key,
    this.answers,
  }) : super(key: key);

  final List<String>? answers;

  @override
  _CheckBoxAnswersWidgetState createState() => _CheckBoxAnswersWidgetState();
}

class _CheckBoxAnswersWidgetState extends State<CheckBoxAnswersWidget> {
  late CheckBoxAnswersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckBoxAnswersModel());

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

    return FlutterFlowCheckboxGroup(
      options: widget.answers!.toList(),
      onChanged: (val) => setState(() => _model.checkboxGroupValues = val),
      controller: _model.checkboxGroupValueController ??=
          FormFieldController<List<String>>(
        [],
      ),
      activeColor: FlutterFlowTheme.of(context).primary,
      checkColor: Colors.white,
      checkboxBorderColor: FlutterFlowTheme.of(context).accent2,
      textStyle: FlutterFlowTheme.of(context).bodyMedium,
      initialized: _model.checkboxGroupValues != null,
    );
  }
}
