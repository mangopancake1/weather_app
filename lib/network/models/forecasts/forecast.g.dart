// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      date: json['date'] as String,
      day_averages:
          DayAverages.fromJson(json['day_averages'] as Map<String, dynamic>),
      night_averages: NightAverages.fromJson(
          json['night_averages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'date': instance.date,
      'day_averages': instance.day_averages,
      'night_averages': instance.night_averages,
    };
