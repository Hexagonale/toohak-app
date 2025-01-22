import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

part 'final_ranking_state.dart';

class FinalRankingCubit extends ThCubit<FinalRankingState> {
  FinalRankingCubit() : super(FinalRankingLoadingState());

  final GameManager _gameManager = sl();

  Future<void> init() async {
    List<RankingPlayer> rankingPlayers = _gameManager.rankingPlayers.toList();
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
      FinalRankingLoadedState(
        players: rankingPlayers,
        somebodyStillPlaying: somebodyStillPlaying,
      ),
    );
  }
}
