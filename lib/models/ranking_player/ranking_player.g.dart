// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingPlayer _$RankingPlayerFromJson(Map<String, dynamic> json) =>
    RankingPlayer(
      token: json['token'] as String,
      username: json['username'] as String,
      points: json['points'] as int,
      roundLost: json['round_lost'] as int?,
    );

Map<String, dynamic> _$RankingPlayerToJson(RankingPlayer instance) =>
    <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'points': instance.points,
      'round_lost': instance.roundLost,
    };
