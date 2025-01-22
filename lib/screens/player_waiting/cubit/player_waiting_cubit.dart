import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/answer/answer_screen.dart';

part 'player_waiting_state.dart';

class PlayerWaitingCubit extends ThCubit<PlayerWaitingState> {
  PlayerWaitingCubit() : super(PlayerWaitingLoadedState());

  final CloudEventsManager _cloudEventsManager = sl();
  final GameManager _gameManager = sl();

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  Future<void> init() async {
    _subscription = _cloudEventsManager.cloudEvents.listen(
      (CloudEvent event) {
        String? gameId = _gameManager.game?.id;
        if (gameId == null) {
          return;
        }

        if (event is QuestionSentCloudEvent) {
          thRouter.replace(
            AnswerScreen.getRoute(gameId),
            arguments: event,
          );
        }
      },
    );
  }
}
