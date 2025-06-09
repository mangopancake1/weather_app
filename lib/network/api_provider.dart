// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:weather_app/network/models/weather_model.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// class ApiProvider {
//
//   Future<WeatherModel?> getCurrentLocationWeather(
//       {required String latitude, required String longitude}) async {
//     final response = await dio.get(
//         "https://api.openweathermap.org/data/2.5/weathesposde&appid=$apiKey");
//
//     if (response.statusCode == 200) {
//       final rawData = jsonDecode(jsonEncode(response.data));
//       WeatherModel weatherData = WeatherModel.fromJson(rawData);
//
//       return weatherData;
//     } else {
//       return null;
//     }
//   }
// }
