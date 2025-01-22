import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

part 'admin_waiting_state.dart';

class AdminWaitingCubit extends ThCubit<AdminWaitingState> {
  AdminWaitingCubit() : super(const AdminWaitingLoadingState());

  final PlayersManager _playersManager = sl();
  final GameManager _gameManager = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  Future<void> init() async {
    _subscription = _playersManager.players.listen((List<String> players) {
      GameTemplate? gameTemplate = _gameManager.gameTemplate;
      String? gameId = _gameManager.game?.id;

      if (gameTemplate == null || gameId == null) {
        emit(
          const AdminWaitingErrorState(
            error: 'Cannot find game',
          ),
        );

        return;
      }

      emit(
        AdminWaitingLoadedState(
          nicknames: players,
          gameTemplate: gameTemplate,
          gameId: gameId,
        ),
      );
    });
  }
}
