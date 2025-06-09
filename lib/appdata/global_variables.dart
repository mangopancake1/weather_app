import 'package:flutter_map/flutter_map.dart';


class GlobalVariableClass {
  late MapController mapController;
  double myLocationLat = 0;
  double myLocationLong = 0;
  double latitude = 0;
  double longitude = 0;
  String imgBaseUrl = "https://openweathermap.org/img/wn/";
  bool isDayTime = true;
  String myCurrentLocation = '';
  double mapZoom = 12.5;
}

final globalVariable = GlobalVariableClass();