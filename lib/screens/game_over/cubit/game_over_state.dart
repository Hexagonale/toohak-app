part of 'game_over_cubit.dart';

sealed class GameOverState extends Equatable {
  const GameOverState();
  @override
  List<Object?> get props => <dynamic>[];
}

class GameOverInitialState extends GameOverState {
  const GameOverInitialState();
}

class GameOverLoadedState extends GameOverState {
  const GameOverLoadedState({
    required this.gameTemplate,
  });

  final GameTemplate gameTemplate;

  @override
  List<Object?> get props => <Object?>[
        gameTemplate,
      ];
}

class GameOverErrorState extends GameOverState {
  const GameOverErrorState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => <Object?>[
        error,
      ];
}
