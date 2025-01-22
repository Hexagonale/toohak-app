import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/after_answer_waiting/after_answer_waiting_screen.dart';

import 'cubit/answer_cubit.dart';

class AnswerBody extends StatefulWidget {
  const AnswerBody({
    super.key,
    required this.event,
    required this.gameId,
  });

  final QuestionSentCloudEvent event;
  final String gameId;

  @override
  State<AnswerBody> createState() => _AnswerBodyState();
}

class _AnswerBodyState extends State<AnswerBody> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 350.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Toohak',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    widget.event.question,
                    style: ThTextStyles.headlineH2Semibold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  _buildHint(),
                  const SizedBox(height: 16.0),
                  if (widget.event.isDouble)
                    Text(
                      'Double boost!',
                      style: ThTextStyles.headlineH2Semibold.copyWith(
                        color: ThColors.ascentAscent,
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: [
                      for (int i = 0; i < widget.event.answers.length; i++)
                        GestureDetector(
                          onTap: () async {
                            AnswerCubit cubit = context.read();
                            bool result = await cubit.sendAnswer(
                              answerIndex: i,
                              wasHintUsed: _showAnswer,
                              gameId: widget.gameId,
                            );

                            if (result) {
                              unawaited(thRouter.replace(
                                AfterAnswerWaitingScreen.route,
                              ));
                            }
                          },
                          child: Container(
                            width: 80.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: _getColorForAnswer(i),
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: ThTextStyles.headlineH2Semibold.copyWith(
                                  color: ThColors.textText1,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColorForAnswer(int index) {
    int arrayIndex = index % ThColors.answerColors.length;
    return ThColors.answerColors[arrayIndex];
  }

  Widget _buildHint() {
    if (widget.event.hint == null || widget.event.hint == null) {
      return const SizedBox();
    }
    if (_showAnswer) {
      return Text(
        'Hint: ${widget.event.hint}',
        style: ThTextStyles.headlineH2Semibold.copyWith(color: ThColors.textText1),
      );
    }

    return PrimaryButton(
      title: 'Show hint',
      onTap: () {
        _showAnswer = true;
        setState(() {});
      },
      size: ThPrimaryButtonSize.small,
      style: ThPrimaryButtonStyle.primary,
    );
  }
}
