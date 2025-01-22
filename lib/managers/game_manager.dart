import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:toohak/_toohak.dart';

class GameManager {
  GameManager({
    required FunctionsManager cloudFunctionsManager,
  }) : _functionsManager = cloudFunctionsManager;

  final FunctionsManager _functionsManager;

  int questionIndex = -1;
  List<RankingPlayer> rankingPlayers = <RankingPlayer>[];
  GameTemplate? _gameTemplate;
  Game? _game;

  Future<bool> init() async {
    questionIndex = -1;
    rankingPlayers = <RankingPlayer>[];
    _gameTemplate = null;
    _game = null;
    return true;
  }

  void setGame(Game game, GameTemplate gameTemplate) {
    _game = game;
    _gameTemplate = gameTemplate;
    clean();
  }

  Game? get game => _game;
  GameTemplate? get gameTemplate => _gameTemplate;

  Future<DateTime?> sendQuestion() async {
    if (_gameTemplate == null || _game == null) {
      return null;
    }
    questionIndex++;
    final question = currentQuestion;
    if (question == null ||
        question.doubleBoost == null ||
        question.durationInSec == null ||
        question.correctAnswerIndex == null ||
        question.answers.isEmpty) {
      return null;
    }

    BotToast.showLoading();

    final finishWhen = await _functionsManager.sendQuestion(
      gameId: _game!.id,
      question: question.question,
      hint: question.hint,
      isDouble: question.doubleBoost!,
      timeInSeconds: question.durationInSec!,
      answers: question.answers,
      isHardcore: gameTemplate!.type == GameType.hardcore,
    );

    BotToast.closeAllLoading();
    return finishWhen;
  }

  Future<bool> finishRound() async {
    if (_gameTemplate == null || _game == null) {
      return false;
    }

    int maxPoints = 1000;
    Question question = _gameTemplate!.questions[questionIndex];

    if (question.correctAnswerIndex == null) {
      return false;
    }

    if (question.doubleBoost == true) {
      maxPoints *= 2;
    }
    BotToast.showLoading();

    List<RankingPlayer> result = await _functionsManager.finishRound(
      gameId: _game!.id,
      currentRanking: rankingPlayers,
      correctAnswerIndex: question.correctAnswerIndex!,
      maxPoints: maxPoints,
    );

    rankingPlayers = result.toList();
    BotToast.closeAllLoading();
    return true;
  }

  Future<bool> finishGame() async {
    if (_gameTemplate == null || _game == null) {
      return false;
    }

    BotToast.showLoading();

    await _functionsManager.finishGame(
      gameId: _game!.id,
      currentRanking: rankingPlayers,
    );

    BotToast.closeAllLoading();
    return true;
  }

  void clean() {
    questionIndex = -1;
    rankingPlayers = <RankingPlayer>[];
  }

  Question? get currentQuestion {
    if (_gameTemplate == null) {
      return null;
    }

    if (questionIndex > _gameTemplate!.questions.length - 1) {
      return null;
    }

    return _gameTemplate!.questions[questionIndex];
  }

  Question? get nextQuestion {
    if (_gameTemplate == null) {
      return null;
    }

    if (questionIndex + 1 > _gameTemplate!.questions.length - 1) {
      return null;
    }

    return _gameTemplate!.questions[questionIndex + 1];
  }
}
