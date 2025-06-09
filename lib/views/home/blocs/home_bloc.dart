import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/appdata/global_variables.dart';
import 'package:weather_app/appdata/my_shared_preferences.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/saved_state_data.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../../network/weather_repository.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:weather_app/appdata/global_functions.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository? weatherRepository;

  HomeBloc({this.weatherRepository}) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeGetWeatherEvent || event is HomeRefreshedEvent) {
      bool? changesOnDayTime = await MySharedPreferences().getChangedDayTime();
      if (event is HomeGetWeatherEvent &&
          await MySharedPreferences().getSavedStateData() != null) {
        SavedStateData? savedData =
            await MySharedPreferences().getSavedStateData();
        emit(state.copyWith(
            weatherModel: savedData!.weatherData,
            forecastsModel: savedData.forecastData,
            isDayTime: changesOnDayTime ?? savedData.isDayTime,
            currentDate: savedData.currentDate,
            appStatus: const IsSuccess()));
      } else if (await checkInternetConnection() == false) {
        emit(state.copyWith(appStatus: IsFailed()));
      } else {
        emit(state.copyWith(appStatus: IsLoading()));
        try {
          Position? pos = await weatherRepository?.getCurrentPosition();
          globalVariable.latitude = pos!.latitude;
          globalVariable.longitude = pos.longitude;
          globalVariable.myLocationLat = pos.latitude;
          globalVariable.myLocationLong = pos.longitude;

          emit(state.copyWith(
              latitude: pos.latitude,
              longitude: pos.longitude,
              appStatus: IsLoading()));

          WeatherModel? weatherData =
              await weatherRepository?.getCurrentWeather(
                  latitude: state.latitude.toString(),
                  longitude: state.longitude.toString());
          ForecastModel? forecastsModel =
              await weatherRepository?.getFiveDaysForecasts(
                  latitude: state.latitude.toString(),
                  longitude: state.longitude.toString());
          emit(state.copyWith(
              weatherModel: weatherData,
              forecastsModel: forecastsModel,
              currentDate: dtToReadable(weatherData!.dt),
              appStatus: const IsSuccess()));
          MySharedPreferences().saveCurrentData(
              stateData: SavedStateData(
                  weatherData: weatherData,
                  forecastData: forecastsModel!,
                  isDayTime: state.isDayTime,
                  currentDate: state.currentDate));
        } catch (e) {
          emit(state.copyWith(appStatus: IsFailed(exception: e), errorMsg: e.toString()));
          print('exception in home bloc: $e');
        }
      }
    }

    if (event is HomeIsDayTimeChangedEvent) {
      emit(state.copyWith(
          isDayTime: event.isDaytime, appStatus: const IsSuccess()));
      MySharedPreferences().saveChangedDayTime(isDayTime: event.isDaytime!);
    }
  }
}
