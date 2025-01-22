import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'ranking_player.g.dart';

@JsonSerializable()
class RankingPlayer extends Equatable {
  const RankingPlayer({
    required this.token,
    required this.username,
    required this.points,
    required this.roundLost,
  });

  // region Json

  factory RankingPlayer.fromJson(Map<String, dynamic> json) {
    return _$RankingPlayerFromJson(json);
  }

  static RankingPlayer? fromJsonSafe(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }

    return RankingPlayer.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RankingPlayerToJson(this);
  }

  // endregion

  @JsonKey(name: RankingPlayerFields.token)
  final String token;

  @JsonKey(name: RankingPlayerFields.username)
  final String username;

  @JsonKey(name: RankingPlayerFields.points)
  final int points;

  @JsonKey(name: RankingPlayerFields.roundLost)
  final int? roundLost;

  @override
  List<Object?> get props => <Object?>[
        token,
        username,
        points,
        roundLost,
      ];
}
