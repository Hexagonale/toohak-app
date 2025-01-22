import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/game_over/cubit/game_over_cubit.dart';

class GameOverBody extends StatefulWidget {
  const GameOverBody({
    super.key,
    required this.event,
    required this.state,
  });

  final GameOverCloudEvent event;
  final GameOverLoadedState state;

  @override
  State<GameOverBody> createState() => _GameOverBodyState();
}

class _GameOverBodyState extends State<GameOverBody> {
  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Toohak',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    widget.event.didPlayerLost ? 'Unfortunately, you lost (hardcore mode)' : 'Game over!',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  if (widget.event.finalPosition != null && !widget.event.didPlayerLost)
                    Column(
                      children: [
                        Text(
                          'Final position: ${widget.event.finalPosition}',
                          style: ThTextStyles.headlineH1Bold.copyWith(
                            color: ThColors.textText1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  Text(
                    'Total points: ${widget.event.totalPoints}',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Question answered: ${widget.event.questionsAnswered}',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Question answered correctly: ${widget.event.questionsAnsweredCorrectly}',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Question answered correctly in whole quiz: ${(widget.event.questionsAnsweredCorrectly / widget.state.gameTemplate.questions.length * 100).toStringAsFixed(1)}%',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Average answer time: ${(widget.event.averageAnswerTimeInMilis / 1000).toStringAsFixed(1)} seconds',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
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
}
