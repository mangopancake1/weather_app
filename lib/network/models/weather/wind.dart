import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'wind.g.dart';


@HiveType(typeId: 1)
@JsonSerializable()
class Wind {
  Wind({required this.speed, required this.deg, required this.gust});

  @HiveField(0)
  final double speed;
  @HiveField(1)
  final int deg;
  @HiveField(2)
  final double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}
