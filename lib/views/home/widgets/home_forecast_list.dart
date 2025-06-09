import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/views/home/widgets/home_forecast_card.dart';

import '../../../network/models/forecasts/forecast.dart';

class HomeForecastList extends StatelessWidget {
  const HomeForecastList(
      {super.key, required this.forecastsData, required this.isDayTime});

  final List<Forecast> forecastsData;
  final bool isDayTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: forecastsData.length,
        itemBuilder: (context, index) {
          if (isDayTime) {
            return HomeForecastCard(
              temp: "${forecastsData[index].day_averages.temp.toStringAsFixed(2)}°",
              weatherIcon: forecastsData[index].day_averages.weather_icon,
              date: forecastsData[index].date,
            );
          } else {
            return HomeForecastCard(
              temp: "${forecastsData[index].night_averages.temp.toStringAsFixed(2)}°",
              weatherIcon: forecastsData[index].night_averages.weather_icon,
              date: forecastsData[index].date,
            );
          }
        },
      ),
    );
  }
}
