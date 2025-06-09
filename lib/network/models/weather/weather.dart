import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Weather {
  @HiveField(0)
  final String main;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String icon;

  Weather({
    this.main = "Unidentified",
    this.description = "No description yet.",
    this.icon = "",
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}