import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toohak/_toohak.dart';

class GameTemplateDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();
  final Logger _logger = Logger('GameTemplateDataProvider');

  Future<Map<String, GameTemplate>> fetchAll() async {
    final QuerySnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection(Collections.gameTemplates).get();

    final Map<String, GameTemplate> gameTemplates = <String, GameTemplate>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final GameTemplate gameTemplate = GameTemplate.fromJson(doc.data()..['id'] = doc.id);
      gameTemplates[doc.id] = gameTemplate;
    }

    return gameTemplates;
  }

  Future<GameTemplate?> getWithId(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection(Collections.gameTemplates).doc(id).get();

    if (!result.exists) {
      return null;
    }

    return GameTemplate.fromJson(result.data()!..['id'] = result.id);
  }

  Future<Map<String, GameTemplate>> fetchWithUserId(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore
        .collection(Collections.gameTemplates)
        .where(GameTemplateFields.userId, isEqualTo: userId)
        .get();

    final Map<String, GameTemplate> gameTemplates = <String, GameTemplate>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final GameTemplate gameTemplate = GameTemplate.fromJson(doc.data()..['id'] = doc.id);
      gameTemplates[doc.id] = gameTemplate;
    }

    return gameTemplates;
  }

  Future<String> addGameTemplate({
    required GameTemplateWriteRequest gameTemplateWriteRequest,
  }) async {
    final DocumentReference<dynamic> result = await _firebaseFirestore
        .collection(Collections.gameTemplates)
        .add(jsonDecode(jsonEncode(gameTemplateWriteRequest)) as Map<String, dynamic>);

    _logger.info(
      'addGameTemplate, New gameTemplate created with id: ${result.id}',
    );

    return result.id;
  }

  Future<void> updateGameTemplate({
    required String id,
    required GameTemplateWriteRequest gameTemplateWriteRequest,
  }) async {
    await _firebaseFirestore
        .collection(Collections.gameTemplates)
        .doc(id)
        .update(jsonDecode(jsonEncode(gameTemplateWriteRequest)) as Map<String, dynamic>);
  }

  Future<void> deleteGameTemplate(String id) async {
    await _firebaseFirestore.collection(Collections.gameTemplates).doc(id).delete();
  }
}
