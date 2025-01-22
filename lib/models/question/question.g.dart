// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      question: json['question'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIndex: json['correct_answer_index'] as int?,
      hint: json['hint'] as String?,
      durationInSec: json['duration_in_sec'] as int?,
      doubleBoost: json['double_boost'] as bool?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'correct_answer_index': instance.correctAnswerIndex,
      'hint': instance.hint,
      'duration_in_sec': instance.durationInSec,
      'double_boost': instance.doubleBoost,
    };
