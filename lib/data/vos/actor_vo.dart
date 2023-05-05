import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId:HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO{

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "gender")
  @HiveField(1)
  int? gender;

  @JsonKey(name: "id")
  @HiveField(2)
  int? id;

  @JsonKey(name: "known_for")
  @HiveField(3)
  List<MovieVO>? knownFor;

  @JsonKey(name: "known_for_department")
  @HiveField(4)
  String? knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(5)
  String? name;

  @JsonKey(name: "popularity")
  @HiveField(6)
  double? popularity;

  @JsonKey(name: "profile_path")
  @HiveField(7)
  String? profilePath;

  @JsonKey(name: "original_name")
  @HiveField(8)
  String? originalName;

  @JsonKey(name: "cast_id")
  @HiveField(9)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(10)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(11)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(12)
  int? order;

  ActorVO(
      this.adult,
      this.gender,
      this.id,
      this.knownFor,
      this.knownForDepartment,
      this.name,
      this.popularity,
      this.profilePath,
      this.originalName,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory ActorVO.fromJson(Map<String,dynamic> json) => _$ActorVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorVO && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}