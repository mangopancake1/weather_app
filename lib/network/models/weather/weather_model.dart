import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/network/models/weather/sys.dart';
import 'package:weather_app/network/models/weather/weather.dart';
import 'package:weather_app/network/models/weather/wind.dart';
import 'package:hive/hive.dart';

import 'main.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class WeatherModel {
  @HiveField(0)
  final List<Weather> weather;
  @HiveField(1)
  final Main main;
  @HiveField(2)
  final Sys sys;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final int dt;
  @HiveField(5)
  final int visibility;
  @HiveField(6)
  final Wind wind;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.sys,
    required this.name,
    required this.dt,
    required this.visibility,
    required this.wind
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}





