import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game extends Equatable {
  const Game({
    required this.id,
    required this.gameTemplateId,
    required this.code,
    required this.signUpBlocked,
    required this.adminToken,
    required this.createdBy,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return _$GameFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GameToJson(this);
  }

  @JsonKey(name: GameFields.id)
  final String id;

  @JsonKey(name: GameFields.gameTemplateId)
  final String gameTemplateId;

  @JsonKey(name: GameFields.code)
  final String code;

  @JsonKey(name: GameFields.signUpBlocked)
  final bool signUpBlocked;

  @JsonKey(name: GameFields.adminToken)
  final String adminToken;

  @JsonKey(name: GameFields.createdBy)
  final String createdBy;

  @override
  List<Object?> get props => <Object?>[
        id,
        gameTemplateId,
        code,
        signUpBlocked,
        adminToken,
        createdBy,
      ];
}
