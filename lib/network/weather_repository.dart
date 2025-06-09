import 'dart:convert';

import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';


class WeatherRepository {
  final ApiService _service = ApiService();

  Future<WeatherModel?> getCurrentWeather(
      {required String latitude, required String longitude}) async {
    final response = await _service.dio.get(
        "/weather?lat=$latitude&lon=$longitude&units=metric&appid=${_service
            .apiKey}");

    if (response.statusCode == 200) {
      WeatherModel weatherData = WeatherModel.fromJson(response.data);
      return weatherData;
    } else {
      return null;
    }
  }

  Future<ForecastModel?> getFiveDaysForecasts({
    required String latitude,
    required String longitude,
  }) async {
    try {
      // Fetch the data from the first API
      final rawData = await _service.dio.get(
        "/forecast?lat=$latitude&lon=$longitude&units=metric&appid=${_service.apiKey}",
      );

      // Ensure rawData.data is a Map or JSON object
      final dataToSend = rawData.data;

      // Send the data to the second API
      final response = await _service.dio.post(
        "https://customized-weatherapi-response-xxrn.vercel.app/weather/averages",
        data: dataToSend,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      // Handle the response as a List
      if (response.statusCode == 200) {
        ForecastModel forecastsModel = ForecastModel.fromJson(response.data);
        return forecastsModel;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied. You may change location settings in app info.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions. You may change location settings in app info.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}