import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'radio_answers_model.dart';
export 'radio_answers_model.dart';

class RadioAnswersWidget extends StatefulWidget {
  const RadioAnswersWidget({
    Key? key,
    this.answers,
  }) : super(key: key);

  final List<String>? answers;

  @override
  _RadioAnswersWidgetState createState() => _RadioAnswersWidgetState();
}

class _RadioAnswersWidgetState extends State<RadioAnswersWidget> {
  late RadioAnswersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioAnswersModel());

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

    return FlutterFlowRadioButton(
      options: widget.answers!.toList(),
      onChanged: (val) => setState(() {}),
      controller: _model.radioButtonValueController ??=
          FormFieldController<String>(null),
      optionHeight: 25.0,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.of(context).primaryText,
          ),
      buttonPosition: RadioButtonPosition.left,
      direction: Axis.horizontal,
      radioButtonColor: Colors.blue,
      inactiveRadioButtonColor: Color(0x8A000000),
      toggleable: false,
      horizontalAlignment: WrapAlignment.start,
      verticalAlignment: WrapCrossAlignment.start,
    );
  }
}
