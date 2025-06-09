import 'package:equatable/equatable.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';

import '../../../blocs/bloc_status.dart';

class ForecastState extends Equatable {
  const ForecastState(
      {this.forecastsModel,
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.isDayTime = true,
      this.appStatus = const InitialStatus()});

  final ForecastModel? forecastsModel;
  final double latitude;
  final double longitude;
  final AppStatus appStatus;
  final bool isDayTime;

  ForecastState copyWith(
      {
      ForecastModel? forecastsModel,
      double? latitude,
      double? longitude,
      bool? isDayTime,
      AppStatus? appStatus}) {
    return ForecastState(
        forecastsModel: forecastsModel ?? this.forecastsModel,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        appStatus: appStatus ?? this.appStatus,
        isDayTime: isDayTime ?? this.isDayTime);
  }

  @override
  List<Object?> get props =>
      [forecastsModel, latitude, longitude, appStatus, isDayTime];
}
