import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

part 'round_ranking_state.dart';

class RoundRankingCubit extends ThCubit<RoundRankingState> {
  RoundRankingCubit() : super(RoundRankingLoadingState());

  final GameManager _gameManager = sl();

  Future<void> init() async {
    final rankingPlayers = _gameManager.rankingPlayers.toList();
    rankingPlayers.sort((RankingPlayer a, RankingPlayer b) {
      return b.points.compareTo(a.points);
    });

    bool somebodyStillPlaying = false;
    for (RankingPlayer player in rankingPlayers) {
      if (player.roundLost == null) {
        somebodyStillPlaying = true;
        break;
      }
    }

    emit(
      RoundRankingLoadedState(
        players: rankingPlayers,
        somebodyStillPlaying: somebodyStillPlaying,
      ),
    );
  }
}
