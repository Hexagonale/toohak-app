import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/answer/answer_screen.dart';

part 'nickname_state.dart';

class NicknameCubit extends ThCubit<NicknameState> {
  NicknameCubit() : super(NicknameLoadedState());

  final FunctionsManager _functionsManager = sl();
  final CloudEventsManager _cloudEventsManager = sl();
  final GameTemplateDataManager _gameTemplateDataManager = sl();
  final GameDataManager _gameDataManager = sl();
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

  Future<String?> joinGame({
    required String code,
    required String username,
  }) async {
    BotToast.showLoading();

    final String? gameId = await _functionsManager.joinGame(
      code: code,
      username: username,
    );

    if (gameId == null) {
      BotToast.closeAllLoading();
      return null;
    }

    await _gameDataManager.fetchWithId(gameId);
    Game? game = _gameDataManager.dataWithId(gameId);

    if (game == null) {
      BotToast.closeAllLoading();
      return null;
    }

    await _gameTemplateDataManager.fetchWithId(game.gameTemplateId);
    GameTemplate? gameTemplate = _gameTemplateDataManager.dataWithId(game.gameTemplateId);
    if (gameTemplate == null) {
      BotToast.closeAllLoading();
      return null;
    }

    _gameManager.setGame(
      game,
      gameTemplate,
    );

    BotToast.closeAllLoading();

    return gameId;
  }
}
