// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_averages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayAverages _$DayAveragesFromJson(Map<String, dynamic> json) => DayAverages(
      temp: (json['temp'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      visibility: (json['visibility'] as num).toInt(),
      weather_main: json['weather_main'] as String,
      weather_icon: json['weather_icon'] as String,
    );

Map<String, dynamic> _$DayAveragesToJson(DayAverages instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'visibility': instance.visibility,
      'weather_main': instance.weather_main,
      'weather_icon': instance.weather_icon,
    };
