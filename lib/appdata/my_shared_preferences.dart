import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/models/forecasts/forecast_model.dart';
import '../network/models/saved_state_data.dart';
import '../network/models/weather/weather_model.dart';

class MySharedPreferences {
  Future<void> saveCurrentData({required SavedStateData stateData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert User object to JSON string
    bool stateDataResult =
        await prefs.setString('stateData', jsonEncode(stateData.toJson()));
    print("stateData saving status: $stateDataResult");
  }

  Future<void> saveChangedDayTime({required bool isDayTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert User object to JSON string
    bool isDayTimeResult = await prefs.setBool('isDayTime', isDayTime);
    print("isDayTime saving status: $isDayTimeResult");
  }

  Future<void> saveCurrentForecasts({required ForecastModel forecastData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert User object to JSON string
    bool forecastDataResult =
        await prefs.setString('forecastData', jsonEncode(forecastData.toJson()));
    print("forecastData saving status: $forecastDataResult");
  }

  Future<SavedStateData?> getSavedStateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the JSON string from SharedPreferences
    String? dataPref = prefs.getString('stateData');

    if (dataPref != null) {
      // Convert JSON string back to User object
      Map<String, dynamic> stateDataMap = jsonDecode(dataPref);
      return SavedStateData.fromJson(stateDataMap);
    }

    return null;
  }

  Future<bool?> getChangedDayTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the JSON string from SharedPreferences
    bool? dataPref = prefs.getBool('isDayTime');

    if (dataPref != null) {
      return dataPref;
    }

    return null;
  }
}
