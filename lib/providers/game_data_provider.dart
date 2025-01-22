import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:toohak/_toohak.dart';

class GameDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();
  final Logger _logger = Logger('GameDataProvider');

  Future<Map<String, Game>> fetchAll() async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection(Collections.games).get();

    final Map<String, Game> games = <String, Game>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Game game = Game.fromJson(doc.data()..['id'] = doc.id);
      games[doc.id] = game;
    }

    return games;
  }

  Future<Game?> getWithId(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection(Collections.games).doc(id).get();

    if (!result.exists) {
      return null;
    }

    return Game.fromJson(result.data()!..['id'] = result.id);
  }

  Future<String> createGame({
    required String templateId,
  }) async {
    final adminToken = await appSession.currentUser?.getIdToken();
    if (adminToken == null) {
      throw Exception('Could not get adminToken');
    }

    final response = await Dio().post(
      '$serverUrl/create_game',
      data: {
        'template_id': templateId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $adminToken',
        },
      ),
    );

    if (response.statusCode != 200) {
      _logger.info(
        'addGame, Could not create game, status code: ${response.statusCode}',
      );

      throw Exception('Could not create game');
    }

    // ignore: avoid_dynamic_calls
    final gameId = response.data['game_id'] as String;
    // ignore: avoid_dynamic_calls
    final token = response.data['token'] as String;

    await sl<CloudEventsManager>().connect(
      token: token,
      gameId: gameId,
    );

    _logger.info(
      'addGame, New game created with id: $gameId',
    );

    return gameId;
  }
}
