import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../network/models/forecasts/forecast.dart';
import 'forecast_card.dart';

class ForecastCardList extends StatelessWidget {
  const ForecastCardList(
      {super.key, required this.forecastList, required this.isDayTime});

  final List<Forecast> forecastList;
  final bool isDayTime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: forecastList.length,
            itemBuilder: (context, index) {
              final forecastData = forecastList[index];

              if (isDayTime) {
                return ForecastCard(
                    dateText: forecastData.date,
                    temp:
                        "${forecastData.day_averages.temp.toStringAsFixed(2)}°",
                    weatherCondition: forecastData.day_averages.weather_main,
                    weatherIcon: forecastData.day_averages.weather_icon);
              } else {
                return ForecastCard(
                    dateText: forecastData.date,
                    temp:
                        "${forecastData.night_averages.temp.toStringAsFixed(2)}°",
                    weatherCondition: forecastData.night_averages.weather_main,
                    weatherIcon: forecastData.night_averages.weather_icon);
              }
            }));
  }
}
