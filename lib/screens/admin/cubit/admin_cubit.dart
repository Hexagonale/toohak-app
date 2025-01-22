import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

part 'admin_state.dart';

class AdminCubit extends ThCubit<AdminState> {
  AdminCubit() : super(const AdminLoadingState());

  final Logger _logger = Logger('AdminCubit');
  final GameTemplateDataManager _gameTemplateDataManager = sl();
  final GameDataManager _gameDataManager = sl();
  final PlayersManager _playersManager = sl();
  final GameManager _gameManager = sl();

  StreamSubscription<dynamic>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }

  Future<void> init() async {
    _logger.info('Initializing AdminCubit');
    String? userId = appSession.currentUser?.uid;
    if (userId == null) {
      emit(
        const AdminErrorState(
          error: 'Cannot find user',
        ),
      );

      return;
    }

    await _gameTemplateDataManager.fetchWithUserId(userId);

    _subscription = _gameTemplateDataManager.dataWithUserId$(userId).listen(
      (List<GameTemplate> templates) {
        emit(
          AdminLoadedState(
            templates: templates,
          ),
        );
      },
    );
  }

  Future<bool> deleteTemplate(String id) async {
    BotToast.showLoading();
    final bool success = await _gameTemplateDataManager.deleteGameTemplate(id: id);
    BotToast.closeAllLoading();
    return success;
  }

  Future<Game?> createGame(GameTemplate gameTemplate) async {
    try {
      String? userId = appSession.currentUser?.uid;
      if (userId == null) {
        return null;
      }

      BotToast.showLoading();

      final String? result = await _gameDataManager.createGame(
        templateId: gameTemplate.id,
      );

      BotToast.closeAllLoading();

      if (result == null) {
        return null;
      }

      _playersManager.clean();

      Game? game = _gameDataManager.dataWithId(result);
      if (game == null) {
        return null;
      }

      _gameManager.setGame(
        game,
        gameTemplate,
      );

      return game;
    } catch (e) {
      return null;
    }
  }
}
