import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toohak/_toohak.dart';

part 'profile_write_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileWriteRequest extends Equatable {
  const ProfileWriteRequest({
    required this.gameTemplateIds,
  });

  factory ProfileWriteRequest.fromJson(Map<String, dynamic> json) {
    return _$ProfileWriteRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileWriteRequestToJson(this);
  }

  @JsonKey(name: ProfileFields.gameTemplateIds)
  final List<String> gameTemplateIds;

  @override
  List<Object?> get props => <Object?>[
        gameTemplateIds,
      ];
}
