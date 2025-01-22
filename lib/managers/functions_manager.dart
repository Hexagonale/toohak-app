import 'package:dio/dio.dart';
import 'package:toohak/_toohak.dart';

class FunctionsManager {
  final FunctionsDataProvider _functionsDataProvider = sl();

  final Logger _logger = Logger('FunctionsManager');

  Future<String?> joinGame({
    required String code,
    required String username,
  }) async {
    try {
      return await _functionsDataProvider.joinGame(
        code: code,
        username: username,
      );
    } catch (e, stacktrace) {
      // ignore: avoid_dynamic_calls
      if (e is DioException && e.response?.data['error'] == 'Username already taken') {
        ThMessage.showError('Username already taken. Please choose another one.');

        _logger.error(
          'joinGame, username already taken',
          error: e,
          stackTrace: stacktrace,
        );
      }
      // ignore: avoid_dynamic_calls
      if (e is DioException && e.response?.data['error'] == 'You are already in this game') {
        ThMessage.showError('You are already in this game.');
        _logger.error(
          'joinGame, you are already in this game',
          error: e,
          stackTrace: stacktrace,
        );
      }
      return null;
    }
  }

  Future<List<RankingPlayer>> finishRound({
    required String gameId,
    required int correctAnswerIndex,
    required int maxPoints,
    required List<RankingPlayer> currentRanking,
  }) async {
    try {
      return await _functionsDataProvider.finishRound(
        gameId: gameId,
        correctAnswerIndex: correctAnswerIndex,
        maxPoints: maxPoints,
        currentRanking: currentRanking,
      );
    } catch (e, stacktrace) {
      _logger.error(
        'finishRound, could not finish round',
        error: e,
        stackTrace: stacktrace,
      );

      return <RankingPlayer>[];
    }
  }

  Future<void> finishGame({
    required String gameId,
    required List<RankingPlayer> currentRanking,
  }) async {
    try {
      await _functionsDataProvider.finishGame(
        gameId: gameId,
        currentRanking: currentRanking,
      );
    } catch (e, stacktrace) {
      _logger.error(
        'finishGame, could not finish game',
        error: e,
        stackTrace: stacktrace,
      );

      return;
    }
  }

  Future<DateTime?> sendQuestion({
    required String gameId,
    required String question,
    required String? hint,
    required bool isDouble,
    required bool isHardcore,
    required int timeInSeconds,
    required List<String> answers,
  }) async {
    try {
      return await _functionsDataProvider.sendQuestion(
        gameId: gameId,
        question: question,
        hint: hint,
        isDouble: isDouble,
        isHardcore: isHardcore,
        timeInSeconds: timeInSeconds,
        answers: answers,
      );
    } catch (e, stacktrace) {
      _logger.error(
        'sendQuestion, could not send question',
        error: e,
        stackTrace: stacktrace,
      );

      return null;
    }
  }

  Future<bool> sendAnswer({
    required String gameId,
    required String token,
    required int answerIndex,
    required bool wasHintUsed,
  }) async {
    try {
      await _functionsDataProvider.sendAnswer(
        gameId: gameId,
        token: token,
        answerIndex: answerIndex,
        wasHintUsed: wasHintUsed,
      );

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'sendAnswer, could not send answer',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }
}
