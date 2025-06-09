import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';

part 'saved_state_data.g.dart';

@JsonSerializable()
class SavedStateData {
  SavedStateData(
      {required this.weatherData, required this.forecastData, required this.isDayTime, required this.currentDate});

  final WeatherModel weatherData;
  final ForecastModel forecastData;
  final bool isDayTime;
  final String currentDate;

  factory SavedStateData.fromJson(Map<String, dynamic> json) =>
      _$SavedStateDataFromJson(json);

  Map<String, dynamic> toJson() => _$SavedStateDataToJson(this);
}