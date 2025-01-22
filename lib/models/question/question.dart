import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question extends Equatable {
  const Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    required this.hint,
    required this.durationInSec,
    required this.doubleBoost,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return _$QuestionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionToJson(this);
  }

  @JsonKey(name: QuestionFields.id)
  final String id;

  @JsonKey(name: QuestionFields.question)
  final String question;

  @JsonKey(name: QuestionFields.answers)
  final List<String> answers;

  @JsonKey(name: QuestionFields.correctAnswerIndex)
  final int? correctAnswerIndex;

  @JsonKey(name: QuestionFields.hint)
  final String? hint;

  @JsonKey(name: QuestionFields.durationInSec)
  final int? durationInSec;

  @JsonKey(name: QuestionFields.doubleBoost)
  final bool? doubleBoost;

  @override
  List<Object?> get props => <Object?>[
        id,
        question,
        answers,
        correctAnswerIndex,
        hint,
        durationInSec,
        doubleBoost,
      ];
}
