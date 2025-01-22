import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/question/question_screen.dart';

class RoundRankingBody extends StatefulWidget {
  const RoundRankingBody({
    super.key,
    required this.ranking,
    required this.somebodyStillPlaying,
    this.isFinal = false,
  });

  final List<RankingPlayer> ranking;
  final bool somebodyStillPlaying;
  final bool isFinal;

  @override
  State<RoundRankingBody> createState() => _RoundRankingBodyState();
}

class _RoundRankingBodyState extends State<RoundRankingBody> {
  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!widget.isFinal && widget.somebodyStillPlaying)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    PrimaryButton(
                                      title: 'Next question',
                                      onTap: () async {
                                        final result = await sl<GameManager>().sendQuestion();
                                        if (result != null) {
                                          unawaited(
                                            thRouter.replace(
                                              QuestionScreen.route,
                                              arguments: result,
                                            ),
                                          );
                                        }
                                      },
                                      size: ThPrimaryButtonSize.small,
                                      style: ThPrimaryButtonStyle.secondary,
                                    ),
                                  ],
                                ),
                              ),
                            Text(
                              'Toohak',
                              style: ThTextStyles.headlineH1Bold.copyWith(
                                color: ThColors.textText1,
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            if (!widget.isFinal && !widget.somebodyStillPlaying)
                              Column(
                                children: [
                                  Text(
                                    'All players have finished the game!',
                                    style: ThTextStyles.headlineH2Bold.copyWith(
                                      color: ThColors.textText1,
                                    ),
                                  ),
                                  const SizedBox(height: 32.0),
                                ],
                              ),
                            const SizedBox(height: 24.0),
                            Text(
                              widget.isFinal ? 'Final ranking, congratulations!' : 'Ranking',
                              style: ThTextStyles.headlineH1Bold.copyWith(
                                color: ThColors.textText1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24.0),
                            _buildRanking(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRanking() {
    if (widget.ranking.isEmpty) {
      return Text(
        'Ranking is empty',
        style: ThTextStyles.headlineH2Semibold.copyWith(
          color: ThColors.textText1,
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No.',
              style: ThTextStyles.headlineH3Bold.copyWith(
                color: ThColors.statusColorDangerDark,
              ),
            ),
            Text(
              'Nickname',
              style: ThTextStyles.headlineH3Bold.copyWith(
                color: ThColors.statusColorDangerDark,
              ),
            ),
            Text(
              'Points',
              style: ThTextStyles.headlineH3Bold.copyWith(
                color: ThColors.statusColorDangerDark,
              ),
            ),
          ],
        ),
        const Divider(
          color: ThColors.textText5,
          thickness: 1.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final RankingPlayer player = widget.ranking[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}',
                  style: ThTextStyles.headlineH3Bold.copyWith(
                    color: ThColors.textText1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      player.username,
                      style: ThTextStyles.headlineH3Bold.copyWith(
                        color: ThColors.textText1,
                      ),
                    ),
                    if (player.roundLost != null)
                      Text(
                        ' (lost in round: ${player.roundLost})',
                        style: ThTextStyles.paragraphP2Regular.copyWith(
                          color: ThColors.textText2,
                        ),
                      ),
                  ],
                ),
                Text(
                  '${player.points}',
                  style: ThTextStyles.headlineH3Bold.copyWith(
                    color: ThColors.textText1,
                  ),
                ),
              ],
            );
          },
          itemCount: widget.ranking.length,
        ),
      ],
    );
  }
}
