import 'package:equatable/equatable.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class ForecastInitialEvent extends ForecastEvent {

  @override
  List<Object> get props => [];
}

class ForecastRefreshedEvent extends ForecastEvent {
  @override
  List<Object?> get props => [];
}

class ForecastTypeChangedEvent extends ForecastEvent {
  const ForecastTypeChangedEvent({this.isDaytime});

  final bool? isDaytime;

  @override
  List<Object?> get props => [isDaytime];
}
