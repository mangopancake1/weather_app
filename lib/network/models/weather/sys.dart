import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'sys.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Sys {
  @HiveField(0)
  final String country;

  const Sys({
    this.country = "Unidentified",
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
