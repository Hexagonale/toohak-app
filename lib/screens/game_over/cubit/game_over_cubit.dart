import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

part 'game_over_state.dart';

class GameOverCubit extends ThCubit<GameOverState> {
  GameOverCubit() : super(const GameOverInitialState());

  final GameManager _gameManager = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  Future<void> init() async {
    GameTemplate? template = _gameManager.gameTemplate;
    if (template == null) {
      emit(
        const GameOverErrorState(
          error: 'Cannot find game template',
        ),
      );

      return;
    }

    emit(
      GameOverLoadedState(
        gameTemplate: template,
      ),
    );
  }
}
