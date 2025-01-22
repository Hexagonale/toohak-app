import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'game_template.g.dart';

@JsonSerializable(explicitToJson: true)
class GameTemplate extends Equatable {
  const GameTemplate({
    required this.id,
    required this.userId,
    required this.questions,
    required this.type,
    required this.name,
    required this.ready,
  });

  factory GameTemplate.fromJson(Map<String, dynamic> json) {
    return _$GameTemplateFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GameTemplateToJson(this);
  }

  @JsonKey(name: GameTemplateFields.id)
  final String id;

  @JsonKey(name: GameTemplateFields.userId)
  final String userId;

  @JsonKey(name: GameTemplateFields.name)
  final String? name;

  @JsonKey(name: GameTemplateFields.ready, defaultValue: true)
  final bool ready;

  @JsonKey(name: GameTemplateFields.questions)
  final List<Question> questions;

  @JsonKey(name: GameTemplateFields.type)
  final GameType? type;

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        name,
        questions,
        type,
        ready,
      ];
}
