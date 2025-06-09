import 'package:equatable/equatable.dart';

import '../../../network/models/forecasts/forecast_model.dart';
import '../../../network/models/weather/weather_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeGetWeatherEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeRefreshedEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeIsDayTimeChangedEvent extends HomeEvent {
  const HomeIsDayTimeChangedEvent({this.isDaytime});

  final bool? isDaytime;

  @override
  List<Object?> get props => [isDaytime];
}

