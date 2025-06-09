import 'package:json_annotation/json_annotation.dart';

part 'day_averages.g.dart';


@JsonSerializable()
class DayAverages {
  DayAverages(
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

  factory DayAverages.fromJson(Map<String, dynamic> json) => _$DayAveragesFromJson(json);
  Map<String, dynamic> toJson() => _$DayAveragesToJson(this);
}
