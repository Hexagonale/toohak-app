import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/answer/answer_screen.dart';
import 'package:toohak/screens/game_over/game_over_screen.dart';

part 'result_state.dart';

class ResultCubit extends ThCubit<ResultState> {
  ResultCubit() : super(const ResultLoadedState());

  final CloudEventsManager _cloudEventsManager = sl();
  final GameManager _gameManager = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  Future<void> init() async {
    _subscription = _cloudEventsManager.cloudEvents.listen(
      (CloudEvent event) {
        final gameId = _gameManager.game?.id;
        if (gameId == null) {
          return;
        }

        if (event is QuestionSentCloudEvent) {
          thRouter.replace(
            AnswerScreen.getRoute(gameId),
            arguments: event,
          );
        }

        if (event is GameOverCloudEvent) {
          thRouter.replace(
            GameOverScreen.route,
            arguments: event,
          );
        }
      },
    );
  }
}
