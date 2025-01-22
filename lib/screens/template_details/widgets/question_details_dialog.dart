import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class QuestionDetailDialog extends StatefulWidget {
  const QuestionDetailDialog({
    Key? key,
    required this.questionParameters,
    required this.ready,
  }) : super(key: key);

  final QuestionParameters? questionParameters;
  final bool ready;

  static Future<QuestionParameters?> show({
    required BuildContext context,
    required QuestionParameters? question,
    required bool ready,
  }) {
    return showDialog<QuestionParameters?>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: ThRoutes.dialogRouteName),
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600.0,
              maxHeight: 575.0,
            ),
            child: QuestionDetailDialog(
              questionParameters: question,
              ready: ready,
            ),
          ),
        );
      },
    );
  }

  @override
  State<QuestionDetailDialog> createState() => _QuestionDetailDialogState();
}

class _QuestionDetailDialogState extends State<QuestionDetailDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _questionKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<int>> _correctAnswerKey = GlobalKey<FormFieldState<int>>();
  final GlobalKey<FormFieldState<String>> _durationKey = GlobalKey<FormFieldState<String>>();
  final List<GlobalKey<FormFieldState<String>>> _answersKey = <GlobalKey<FormFieldState<String>>>[];
  final GlobalKey<FormFieldState<String>> _hintKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<bool>> _doubleBoostKey = GlobalKey<FormFieldState<bool>>();

  File? file;
  @override
  void initState() {
    if (widget.questionParameters == null) {
      return;
    }

    for (String _ in widget.questionParameters!.answers) {
      _answersKey.add(GlobalKey<FormFieldState<String>>());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: ThColors.backgroundBG1,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      ThTextInput(
                        initialValue: widget.questionParameters?.question,
                        isRequired: true,
                        formFieldKey: _questionKey,
                        labelText: 'Question *',
                        maxLines: null,
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: ThTextInput(
                                  initialValue: _getInitialValue(index),
                                  isRequired: true,
                                  formFieldKey: _answersKey[index],
                                  labelText: 'Answer ${index + 1} *',
                                  maxLines: null,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () {
                                  setState(() {
                                    _answersKey.removeAt(index);
                                    _correctAnswerKey.currentState?.didChange(null);
                                  });
                                },
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  size: 30.0,
                                  color: ThColors.ascentAscent,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: _answersKey.length,
                      ),
                      PrimaryButton(
                        title: 'Add answer',
                        onTap: () {
                          setState(() {
                            _answersKey.add(GlobalKey<FormFieldState<String>>());
                          });
                        },
                        size: ThPrimaryButtonSize.large,
                        style: ThPrimaryButtonStyle.secondary,
                      ),
                      const SizedBox(height: 8.0),
                      ThDropdownInput<int>(
                        values: _getIndexValues(),
                        label: 'Correct answer *',
                        formFieldKey: _correctAnswerKey,
                        isRequired: widget.ready ? true : false,
                        initialValue:
                            widget.questionParameters == null || widget.questionParameters!.correctAnswerIndex == null
                                ? null
                                : widget.questionParameters!.correctAnswerIndex! + 1,
                      ),
                      const SizedBox(height: 8.0),
                      ThTextInput(
                        initialValue: widget.questionParameters?.hint,
                        formFieldKey: _hintKey,
                        labelText: 'Hint',
                        maxLines: null,
                      ),
                      ThCheckboxInput(
                        label: 'Double boost',
                        formFieldKey: _doubleBoostKey,
                      ),
                      const SizedBox(height: 8.0),
                      ThNumberInput(
                        initialValue: widget.questionParameters?.durationInSec == null
                            ? ''
                            : widget.questionParameters?.durationInSec.toString(),
                        required: widget.ready ? true : false,
                        formFieldKey: _durationKey,
                        labelText: 'Duration in sec *',
                      ),
                      const SizedBox(height: 32.0),
                      PrimaryButton(
                        title: widget.questionParameters == null ? 'Add question' : 'Update question ',
                        onTap: () async => await _submit(context),
                        size: ThPrimaryButtonSize.large,
                        style: ThPrimaryButtonStyle.secondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 66.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Set<int> _getIndexValues() {
    final values = <int>{};
    for (int i = 1; i <= _answersKey.length; i++) {
      values.add(i);
    }
    return values;
  }

  String? _getInitialValue(int index) {
    if (widget.questionParameters == null) {
      return null;
    }

    if (index < widget.questionParameters!.answers.length) {
      return widget.questionParameters!.answers[index];
    }

    return null;
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'template details',
          style: ThTextStyles.paragraphP3Medium.copyWith(
            color: ThColors.textText1,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () => thRouter.pop(),
          child: const Icon(
            Icons.cancel_outlined,
            size: 30.0,
            color: ThColors.ascentAscent,
          ),
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final readingTimeMins = int.tryParse(_durationKey.currentState!.value!);
    if (readingTimeMins == null && widget.ready) {
      return;
    }

    final answers = <String>[];
    for (int i = 0; i < _answersKey.length; i++) {
      answers.add(_answersKey[i].currentState!.value!);
    }

    String? hint = _hintKey.currentState!.value;

    if (hint == '') {
      hint = null;
    }

    final correctAnswerIndex = _correctAnswerKey.currentState!.value;
    final lessonParameters = QuestionParameters(
      currentQuestion: widget.questionParameters?.currentQuestion,
      question: _questionKey.currentState!.value!,
      answers: answers,
      correctAnswerIndex: correctAnswerIndex == null ? null : correctAnswerIndex - 1,
      hint: hint,
      durationInSec: readingTimeMins,
      doubleBoost: _doubleBoostKey.currentState?.value ?? false,
    );

    thRouter.pop(lessonParameters);
  }
}
