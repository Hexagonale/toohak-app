import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    super.key,
    required this.question,
    required this.finishWhen,
  });

  final Question question;
  final DateTime finishWhen;

  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700.0,
              ),
              child: SingleChildScrollView(
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
                    TimerBuilder(
                      endTime: widget.finishWhen,
                      builder: (context, duration) {
                        return Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThColors.textText2,
                          ),
                          child: Center(
                            child: Text(
                              '${duration.inSeconds}',
                              style: ThTextStyles.headlineH1Bold.copyWith(
                                color: ThColors.textText1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      widget.question.question,
                      style: ThTextStyles.headlineH2Semibold.copyWith(
                        color: ThColors.textText1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    if (widget.question.doubleBoost == true)
                      Text(
                        'Double boost!',
                        style: ThTextStyles.headlineH2Semibold.copyWith(
                          color: ThColors.ascentAscent,
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: [
                        for (int i = 0; i < widget.question.answers.length; i++)
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: _getColorForQuestion(i),
                            ),
                            child: Text(
                              '${i + 1}. ${widget.question.answers[i]}',
                              style: ThTextStyles.headlineH2Semibold.copyWith(
                                color: ThColors.textText1,
                              ),
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
      ),
    );
  }

  Color _getColorForQuestion(int index) {
    final arrayIndex = index % ThColors.answerColors.length;
    return ThColors.answerColors[arrayIndex];
  }
}
