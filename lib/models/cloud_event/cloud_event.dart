import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cloud_event.g.dart';

sealed class CloudEvent extends Equatable {
  const CloudEvent();
}

@JsonSerializable()
class PlayerJoinedCloudEvent extends CloudEvent {
  const PlayerJoinedCloudEvent({
    required this.username,
  });

  factory PlayerJoinedCloudEvent.fromJson(Map<String, dynamic> json) => _$PlayerJoinedCloudEventFromJson(json);

  @JsonKey(name: 'username')
  final String username;

  @override
  List<Object?> get props => <Object?>[
        username,
      ];
}

@JsonSerializable()
class QuestionSentCloudEvent extends CloudEvent {
  const QuestionSentCloudEvent({
    required this.question,
    required this.answers,
    required this.hint,
    required this.isDouble,
    required this.finishWhen,
  });

  factory QuestionSentCloudEvent.fromJson(Map<String, dynamic> json) => _$QuestionSentCloudEventFromJson(json);

  @JsonKey(name: 'question')
  final String question;

  @JsonKey(name: 'hint')
  final String? hint;

  @JsonKey(name: 'answers')
  final List<String> answers;

  @JsonKey(name: 'is_double')
  final bool isDouble;

  @JsonKey(name: 'finish_when')
  final DateTime finishWhen;

  @override
  List<Object?> get props => <Object?>[
        question,
        answers,
        hint,
        isDouble,
        finishWhen,
      ];
}

@JsonSerializable()
class RoundFinishedCloudEvent extends CloudEvent {
  const RoundFinishedCloudEvent({
    required this.wasAnswerCorrect,
    required this.pointsForThisRound,
    required this.totalPoints,
    required this.currentPosition,
    required this.answeredNth,
  });

  factory RoundFinishedCloudEvent.fromJson(Map<String, dynamic> json) => _$RoundFinishedCloudEventFromJson(json);

  @JsonKey(name: 'was_answer_correct')
  final bool? wasAnswerCorrect;

  @JsonKey(name: 'points_for_this_round')
  final int pointsForThisRound;

  @JsonKey(name: 'total_points')
  final int totalPoints;

  @JsonKey(name: 'current_position')
  final int currentPosition;

  @JsonKey(name: 'answered_nth')
  final int? answeredNth;

  @override
  List<Object?> get props => <Object?>[
        wasAnswerCorrect,
        pointsForThisRound,
        totalPoints,
        currentPosition,
        answeredNth,
      ];
}

@JsonSerializable()
class GameOverCloudEvent extends CloudEvent {
  const GameOverCloudEvent({
    required this.didPlayerLost,
    required this.totalPoints,
    required this.finalPosition,
    required this.questionsAnswered,
    required this.questionsAnsweredCorrectly,
    required this.averageAnswerTimeInMilis,
  });

  factory GameOverCloudEvent.fromJson(Map<String, dynamic> json) => _$GameOverCloudEventFromJson(json);

  @JsonKey(name: 'did_player_lost')
  final bool didPlayerLost;

  @JsonKey(name: 'total_points')
  final int totalPoints;

  @JsonKey(name: 'final_position')
  final int? finalPosition;

  @JsonKey(name: 'questions_answered')
  final int questionsAnswered;

  @JsonKey(name: 'questions_answered_correctly')
  final int questionsAnsweredCorrectly;

  @JsonKey(name: 'average_answer_time')
  final int averageAnswerTimeInMilis;

  @override
  List<Object?> get props => <Object?>[
        didPlayerLost,
        totalPoints,
        finalPosition,
        questionsAnswered,
        questionsAnsweredCorrectly,
        averageAnswerTimeInMilis,
      ];
}
