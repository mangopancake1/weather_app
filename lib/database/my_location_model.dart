import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:hive/hive.dart';

part 'my_location_model.g.dart';

@HiveType(typeId: 0)
class MyLocationModel {
  const MyLocationModel(
      {required this.latitude,
      required this.longitude,
      required this.weatherModel,
      required this.title});

  @HiveField(0)
  final String latitude;
  @HiveField(1)
  final String longitude;
  @HiveField(2)
  final WeatherModel weatherModel;
  @HiveField(3)
  final String title;
}
