import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/my_shared_preferences.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/views/forecast/blocs/forecast_event.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

import '../../../network/models/saved_state_data.dart';
import 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository? weatherRepository;

  ForecastBloc({this.weatherRepository}) : super(const ForecastState()) {
    on<ForecastEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(
      ForecastEvent event, Emitter<ForecastState> emit) async {
    if (event is ForecastInitialEvent || event is ForecastRefreshedEvent) {

      if (event is ForecastInitialEvent &&
          await MySharedPreferences().getSavedStateData() != null) {

        bool? changesOnDayTime =
            await MySharedPreferences().getChangedDayTime();

        SavedStateData? savedData =
            await MySharedPreferences().getSavedStateData();

        emit(state.copyWith(
            forecastsModel: savedData!.forecastData,
            isDayTime: changesOnDayTime ?? savedData.isDayTime,
            appStatus: const IsSuccess()));

      } else if (await checkInternetConnection() == false) {

        emit(state.copyWith(appStatus: IsFailed()));

      } else {
        emit(state.copyWith(appStatus: IsLoading()));
        try {
          Position? pos = await weatherRepository?.getCurrentPosition();

          ForecastModel? forecastModel =
              await weatherRepository?.getFiveDaysForecasts(
                  latitude: pos!.latitude.toString(),
                  longitude: pos.longitude.toString());

          emit(state.copyWith(
              forecastsModel: forecastModel, appStatus: const IsSuccess()));

          MySharedPreferences()
              .saveCurrentForecasts(forecastData: forecastModel!);
        } catch (e) {
          emit(state.copyWith(appStatus: IsFailed(exception: e)));
          print(e);
        }
      }
    }

    if (event is ForecastTypeChangedEvent) {

      emit(state.copyWith(appStatus: IsLoading()));

      emit(state.copyWith(
          isDayTime: event.isDaytime, appStatus: const IsSuccess()));
    }
  }
}
