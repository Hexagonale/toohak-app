// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_template_write_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameTemplateWriteRequest _$GameTemplateWriteRequestFromJson(
        Map<String, dynamic> json) =>
    GameTemplateWriteRequest(
      userId: json['user_id'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecodeNullable(_$GameTypeEnumMap, json['type']),
      name: json['name'] as String?,
      ready: json['ready'] as bool? ?? true,
    );

Map<String, dynamic> _$GameTemplateWriteRequestToJson(
        GameTemplateWriteRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'type': _$GameTypeEnumMap[instance.type],
      'name': instance.name,
      'ready': instance.ready,
    };

const _$GameTypeEnumMap = {
  GameType.normal: 'normal',
  GameType.hardcore: 'hardcore',
};
