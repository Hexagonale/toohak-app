import 'package:toohak/_toohak.dart';

class GameDataManager extends DataManager<Game> {
  final GameDataProvider _gameDataProvider = sl();
  final Logger _logger = Logger('GameDataManager');

  Game? dataWithId(String id) => lastKnownValues.firstWhereOrNull((Game game) => game.id == id);

  Future<bool> fetchWithId(String id) async {
    try {
      final Game? result = await _gameDataProvider.getWithId(id);
      updateStreamWith(<String, Game?>{id: result});

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'fetchWithId, could not fetch witch id game',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<String?> createGame({
    required String templateId,
  }) async {
    try {
      final String id = await _gameDataProvider.createGame(
        templateId: templateId,
      );
      await fetchWithId(id);

      return id;
    } catch (error, stacktrace) {
      _logger.error(
        'addGame, could not add game',
        error: error,
        stackTrace: stacktrace,
      );

      return null;
    }
  }
}
