import 'package:freezed_annotation/freezed_annotation.dart';

part 'actor.freezed.dart';
part 'actor.g.dart';

@freezed
class Actor with _$Actor {
  const factory Actor({
    @JsonKey(name: 'also_known_as') required List<String> alsoKnownAs,
    @JsonKey(name: 'profile_path') required String profilePath,
    @JsonKey(name: 'birthday') String? birthDay,
    @JsonKey(name: 'deathday') String? deathDay,
    required int id,
    String? name,
    String? biography,
    double? popularity,
    String? homePage,
  }) = _Actor;

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
}
