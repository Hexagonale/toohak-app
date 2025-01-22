// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerJoinedCloudEvent _$PlayerJoinedCloudEventFromJson(
        Map<String, dynamic> json) =>
    PlayerJoinedCloudEvent(
      username: json['username'] as String,
    );

Map<String, dynamic> _$PlayerJoinedCloudEventToJson(
        PlayerJoinedCloudEvent instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

QuestionSentCloudEvent _$QuestionSentCloudEventFromJson(
        Map<String, dynamic> json) =>
    QuestionSentCloudEvent(
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      hint: json['hint'] as String?,
      isDouble: json['is_double'] as bool,
      finishWhen: DateTime.parse(json['finish_when'] as String),
    );

Map<String, dynamic> _$QuestionSentCloudEventToJson(
        QuestionSentCloudEvent instance) =>
    <String, dynamic>{
      'question': instance.question,
      'hint': instance.hint,
      'answers': instance.answers,
      'is_double': instance.isDouble,
      'finish_when': instance.finishWhen.toIso8601String(),
    };

RoundFinishedCloudEvent _$RoundFinishedCloudEventFromJson(
        Map<String, dynamic> json) =>
    RoundFinishedCloudEvent(
      wasAnswerCorrect: json['was_answer_correct'] as bool?,
      pointsForThisRound: json['points_for_this_round'] as int,
      totalPoints: json['total_points'] as int,
      currentPosition: json['current_position'] as int,
      answeredNth: json['answered_nth'] as int?,
    );

Map<String, dynamic> _$RoundFinishedCloudEventToJson(
        RoundFinishedCloudEvent instance) =>
    <String, dynamic>{
      'was_answer_correct': instance.wasAnswerCorrect,
      'points_for_this_round': instance.pointsForThisRound,
      'total_points': instance.totalPoints,
      'current_position': instance.currentPosition,
      'answered_nth': instance.answeredNth,
    };

GameOverCloudEvent _$GameOverCloudEventFromJson(Map<String, dynamic> json) =>
    GameOverCloudEvent(
      didPlayerLost: json['did_player_lost'] as bool,
      totalPoints: json['total_points'] as int,
      finalPosition: json['final_position'] as int?,
      questionsAnswered: json['questions_answered'] as int,
      questionsAnsweredCorrectly: json['questions_answered_correctly'] as int,
      averageAnswerTimeInMilis: json['average_answer_time'] as int,
    );

Map<String, dynamic> _$GameOverCloudEventToJson(GameOverCloudEvent instance) =>
    <String, dynamic>{
      'did_player_lost': instance.didPlayerLost,
      'total_points': instance.totalPoints,
      'final_position': instance.finalPosition,
      'questions_answered': instance.questionsAnswered,
      'questions_answered_correctly': instance.questionsAnsweredCorrectly,
      'average_answer_time': instance.averageAnswerTimeInMilis,
    };
