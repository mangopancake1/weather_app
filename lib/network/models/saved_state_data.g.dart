// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_state_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedStateData _$SavedStateDataFromJson(Map<String, dynamic> json) =>
    SavedStateData(
      weatherData:
          WeatherModel.fromJson(json['weatherData'] as Map<String, dynamic>),
      forecastData:
          ForecastModel.fromJson(json['forecastData'] as Map<String, dynamic>),
      isDayTime: json['isDayTime'] as bool,
      currentDate: json['currentDate'] as String,
    );

Map<String, dynamic> _$SavedStateDataToJson(SavedStateData instance) =>
    <String, dynamic>{
      'weatherData': instance.weatherData,
      'forecastData': instance.forecastData,
      'isDayTime': instance.isDayTime,
      'currentDate': instance.currentDate,
    };
