import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:toohak/_toohak.dart';

class FunctionsDataProvider {
  Future<String> joinGame({
    required String code,
    required String username,
  }) async {
    final response = await Dio().post(
      '$serverUrl/join_game',
      data: <String, dynamic>{
        'code': code,
        'username': username,
      },
    );

    await sl<CloudEventsManager>().connect(
      // ignore: avoid_dynamic_calls
      token: response.data['token'] as String,
      // ignore: avoid_dynamic_calls
      gameId: response.data['game_id'] as String,
    );

    // ignore: avoid_dynamic_calls
    return response.data['game_id'] as String;
  }

  Future<List<RankingPlayer>> finishRound({
    required String gameId,
    required int correctAnswerIndex,
    required int maxPoints,
    required List<RankingPlayer> currentRanking,
  }) async {
    final adminToken = await appSession.currentUser?.getIdToken();
    if (adminToken == null) {
      throw Exception('Could not get adminToken');
    }

    final response = await Dio().post(
      '$serverUrl/finish_round',
      data: <String, dynamic>{
        'game_id': gameId,
        'correct_answer_index': correctAnswerIndex,
        'max_points': maxPoints,
        'current_ranking': jsonDecode(jsonEncode(currentRanking)),
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $adminToken',
        },
      ),
    );

    // ignore: avoid_dynamic_calls
    final rankingRaw = response.data['ranking'] as List<dynamic>;
    final ranking = rankingRaw.map((e) => RankingPlayer.fromJsonSafe(e)!).toList();

    return ranking;
  }

  Future<void> finishGame({
    required String gameId,
    required List<RankingPlayer> currentRanking,
  }) async {
    final adminToken = await appSession.currentUser?.getIdToken();
    if (adminToken == null) {
      throw Exception('Could not get adminToken');
    }

    await Dio().post(
      '$serverUrl/finish_game',
      data: <String, dynamic>{
        'game_id': gameId,
        'current_ranking': jsonDecode(jsonEncode(currentRanking)),
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $adminToken',
        },
      ),
    );
  }

  Future<DateTime> sendQuestion({
    required String gameId,
    required String question,
    required String? hint,
    required bool isDouble,
    required bool isHardcore,
    required int timeInSeconds,
    required List<String> answers,
  }) async {
    final adminToken = await appSession.currentUser?.getIdToken();
    if (adminToken == null) {
      throw Exception('Could not get adminToken');
    }

    final response = await Dio().post(
      '$serverUrl/send_question',
      data: <String, dynamic>{
        'game_id': gameId,
        'question': question,
        'hint': hint,
        'is_double': isDouble,
        'time_in_seconds': timeInSeconds,
        'answers': answers,
        'is_hardcore': isHardcore,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $adminToken',
        },
      ),
    );

    // ignore: avoid_dynamic_calls
    return DateTime.parse(response.data['finish_when'] as String).toLocal();
  }

  Future<void> sendAnswer({
    required String gameId,
    required String token,
    required int answerIndex,
    required bool wasHintUsed,
  }) async {
    await Dio().post(
      '$serverUrl/send_answer',
      data: <String, dynamic>{
        'game_id': gameId,
        'token': token,
        'answer_index': answerIndex,
        'was_hint_used': wasHintUsed,
      },
    );
  }
}
