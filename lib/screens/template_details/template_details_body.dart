import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';

import 'cubit/template_details_cubit.dart';
import 'widgets/question_details_dialog.dart';
import 'widgets/question_row.dart';

class TemplateDetailsBody extends StatefulWidget {
  const TemplateDetailsBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TemplateDetailsLoadedState state;

  @override
  State<TemplateDetailsBody> createState() => _TemplateDetailsBodyState();
}

class _TemplateDetailsBodyState extends State<TemplateDetailsBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<GameType>> _gameTypeKey = GlobalKey<FormFieldState<GameType>>();
  final GlobalKey<FormFieldState<bool>> _readyKey = GlobalKey<FormFieldState<bool>>();

  final GlobalKey<FormFieldState<String>> _nameKey = GlobalKey<FormFieldState<String>>();

  final List<QuestionParameters> questions = <QuestionParameters>[];

  @override
  void initState() {
    if (widget.state.template != null && widget.state.template!.questions.isNotEmpty) {
      for (Question lesson in widget.state.template!.questions) {
        questions.add(QuestionParameters(
          currentQuestion: lesson,
          question: lesson.question,
          correctAnswerIndex: lesson.correctAnswerIndex,
          answers: lesson.answers,
          doubleBoost: lesson.doubleBoost,
          durationInSec: lesson.durationInSec,
          hint: lesson.hint,
        ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Template Details',
                    style: ThTextStyles.headlineH2Semibold.copyWith(
                      color: ThColors.textText1,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ThDropdownInput(
                    isRequired: _readyKey.currentState?.value == false ? false : true,
                    values: GameType.values.toSet(),
                    formFieldKey: _gameTypeKey,
                    label: 'Game Type*',
                    initialValue: widget.state.template?.type,
                    translateItemToString: (GameType? value) => value == null ? '' : GameTypeMapper.getName(value),
                  ),
                  const SizedBox(height: 8.0),
                  ThDropdownInput(
                    isRequired: false,
                    values: const <bool>{true, false},
                    formFieldKey: _readyKey,
                    label: 'Ready *',
                    initialValue: widget.state.template == null ? true : widget.state.template?.ready,
                    translateItemToString: (bool? value) {
                      if (value == null) {
                        return '';
                      }
                      return value ? 'Yes' : 'No';
                    },
                    onChanged: (bool? _) => setState(() {}),
                  ),
                  const SizedBox(height: 8.0),
                  ThTextInput(
                    initialValue: widget.state.template?.name,
                    isRequired: true,
                    formFieldKey: _nameKey,
                    labelText: 'Name *',
                    maxLines: null,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Questions',
                    style: ThTextStyles.headlineH2Semibold.copyWith(
                      color: ThColors.textText2,
                    ),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          final params = await QuestionDetailDialog.show(
                            context: context,
                            question: questions[index],
                            ready: _readyKey.currentState?.value ?? true,
                          );

                          if (params == null) {
                            return;
                          }

                          questions[index] = params;

                          setState(() {});
                        },
                        child: QuestionRow(
                          question: questions[index].question,
                          duration: questions[index].durationInSec,
                          onDelete: () => thShowAlert(
                            context,
                            content: 'Are you sure you want to delete this question?',
                            onConfirm: () {
                              questions.removeAt(index);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: questions.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16.0),
                    shrinkWrap: true,
                  ),
                  const SizedBox(height: 16.0),
                  PrimaryButton(
                    title: 'Add question',
                    onTap: () async {
                      final lesson = await QuestionDetailDialog.show(
                        context: context,
                        question: null,
                        ready: _readyKey.currentState?.value ?? true,
                      );
                      if (lesson == null) {
                        return;
                      }

                      questions.add(lesson);

                      setState(() {});
                    },
                    size: ThPrimaryButtonSize.large,
                    style: ThPrimaryButtonStyle.justText,
                  ),
                  const SizedBox(height: 32.0),
                  PrimaryButton(
                    title: widget.state.template == null ? 'Add template' : 'Save template',
                    onTap: () async => await _submit(context),
                    size: ThPrimaryButtonSize.large,
                    style: ThPrimaryButtonStyle.primary,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final ready = _readyKey.currentState!.value!;

    for (QuestionParameters question in questions) {
      if (!ready) {
        break;
      }

      if (question.answers.isEmpty || question.correctAnswerIndex == null || question.durationInSec == null) {
        return;
      }
    }

    await context.read<TemplateDetailsCubit>().save(
          template: widget.state.template,
          name: _nameKey.currentState!.value!,
          params: questions,
          type: _gameTypeKey.currentState?.value,
          ready: ready,
        );

    thRouter.pop();
  }
}
