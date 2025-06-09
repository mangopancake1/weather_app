import 'package:json_annotation/json_annotation.dart';

import 'day_averages.dart';
import 'night_averages.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast {
  Forecast(
      {required this.date,
      required this.day_averages,
      required this.night_averages});

  final String date;
  final DayAverages day_averages;
  final NightAverages night_averages;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}
