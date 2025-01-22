// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_write_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameWriteRequest _$GameWriteRequestFromJson(Map<String, dynamic> json) =>
    GameWriteRequest(
      gameTemplateId: json['game_template_id'] as String,
      code: json['code'] as String,
      signUpBlocked: json['sign_up_blocked'] as bool,
      adminToken: json['admin_token'] as String,
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$GameWriteRequestToJson(GameWriteRequest instance) =>
    <String, dynamic>{
      'game_template_id': instance.gameTemplateId,
      'code': instance.code,
      'sign_up_blocked': instance.signUpBlocked,
      'admin_token': instance.adminToken,
      'created_by': instance.createdBy,
    };
