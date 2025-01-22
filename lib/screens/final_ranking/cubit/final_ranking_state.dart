part of 'final_ranking_cubit.dart';

sealed class FinalRankingState extends Equatable {
  const FinalRankingState();
  @override
  List<Object?> get props => <dynamic>[];
}

class FinalRankingLoadingState extends FinalRankingState {}

class FinalRankingLoadedState extends FinalRankingState {
  const FinalRankingLoadedState({
    required this.players,
    required this.somebodyStillPlaying,
  });

  final List<RankingPlayer> players;
  final bool somebodyStillPlaying;

  @override
  List<Object?> get props => <dynamic>[
        players,
        somebodyStillPlaying,
      ];
}

class FinalRankingErrorState extends FinalRankingState {
  const FinalRankingErrorState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => <dynamic>[
        error,
      ];
}
