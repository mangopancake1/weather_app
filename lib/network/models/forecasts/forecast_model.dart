import 'package:json_annotation/json_annotation.dart';

import 'forecast.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  ForecastModel({required this.forecasts});

  final List<Forecast> forecasts;

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
