part of 'round_ranking_cubit.dart';

sealed class RoundRankingState extends Equatable {
  const RoundRankingState();
  @override
  List<Object?> get props => <dynamic>[];
}

class RoundRankingLoadingState extends RoundRankingState {}

class RoundRankingLoadedState extends RoundRankingState {
  const RoundRankingLoadedState({
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

class RoundRankingErrorState extends RoundRankingState {
  const RoundRankingErrorState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => <dynamic>[
        error,
      ];
}
