import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.gameTemplateIds,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileToJson(this);
  }

  @JsonKey(name: ProfileFields.id)
  final String id;

  @JsonKey(name: ProfileFields.gameTemplateIds)
  final List<String> gameTemplateIds;

  @override
  List<Object?> get props => <Object?>[
        id,
        gameTemplateIds,
      ];
}
