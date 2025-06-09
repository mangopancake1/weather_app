import 'package:json_annotation/json_annotation.dart';

part 'night_averages.g.dart';

@JsonSerializable()
class NightAverages {
  NightAverages(
      {required this.temp,
        required this.humidity,
        required this.windSpeed,
        required this.visibility,
        required this.weather_main,
        required this.weather_icon});

  final double temp;
  final int humidity;
  final double windSpeed;
  final int visibility;
  final String weather_main;
  final String weather_icon;

  factory NightAverages.fromJson(Map<String, dynamic> json) => _$NightAveragesFromJson(json);
  Map<String, dynamic> toJson() => _$NightAveragesToJson(this);
}