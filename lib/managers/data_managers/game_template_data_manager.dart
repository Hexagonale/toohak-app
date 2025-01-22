import 'package:toohak/_toohak.dart';

class GameTemplateDataManager extends DataManager<GameTemplate> {
  final GameTemplateDataProvider _gameTemplateDataProvider = sl();
  final Logger _logger = Logger('GameTemplateDataManager');

  List<GameTemplate> dataWithUserId(String userId) =>
      lastKnownValues.where((GameTemplate gameTemplate) => gameTemplate.userId == userId).toList();

  GameTemplate? dataWithId(String id) =>
      lastKnownValues.firstWhereOrNull((GameTemplate gameTemplate) => gameTemplate.id == id);

  Stream<List<GameTemplate>> dataWithUserId$(String userId) => data$.map(
        (List<GameTemplate> gameTemplates) =>
            gameTemplates.where((GameTemplate gameTemplate) => gameTemplate.userId == userId).toList(),
      );

  Future<bool> fetchWithId(String id) async {
    try {
      final GameTemplate? result = await _gameTemplateDataProvider.getWithId(id);
      updateStreamWith(<String, GameTemplate?>{id: result});
      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'fetchWithId, could not fetch witch id gameTemplate',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> fetchWithUserId(String userId) async {
    try {
      final Map<String, GameTemplate> result = await _gameTemplateDataProvider.fetchWithUserId(userId);
      updateStreamWith(
        result,
        deleteWhere: (GameTemplate template) => template.userId == userId,
      );

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'fetchWithUserId, could not fetch witch user id gameTemplate',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<String?> addGameTemplate({
    required GameTemplateWriteRequest gameTemplateWriteRequest,
  }) async {
    try {
      final String id = await _gameTemplateDataProvider.addGameTemplate(
        gameTemplateWriteRequest: gameTemplateWriteRequest,
      );
      await fetchWithId(id);

      return id;
    } catch (error, stacktrace) {
      _logger.error(
        'addGameTemplate, could not add gameTemplate',
        error: error,
        stackTrace: stacktrace,
      );

      return null;
    }
  }

  Future<bool> updateGameTemplate({
    required String id,
    required GameTemplateWriteRequest gameTemplateWriteRequest,
  }) async {
    try {
      await _gameTemplateDataProvider.updateGameTemplate(
        id: id,
        gameTemplateWriteRequest: gameTemplateWriteRequest,
      );
      await fetchWithId(id);

      return true;
    } catch (error, stacktrace) {
      _logger.error(
        'updateGameTemplate, could not update gameTemplate',
        error: error,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> deleteGameTemplate({
    required String id,
  }) async {
    try {
      await _gameTemplateDataProvider.deleteGameTemplate(id);
      await fetchWithId(id);

      return true;
    } catch (error, stacktrace) {
      _logger.error(
        'deleteGameTemplate, could not delete gameTemplate',
        error: error,
        stackTrace: stacktrace,
      );

      return false;
    }
  }
}
