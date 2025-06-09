// part of 'mylocations_bloc.dart';
//
// class MyLocationState extends Equatable {
//   const MyLocationState(
//       {this.weatherModel,
//       this.latitude = 0.0,
//       this.longitude = 0.0,
//       this.appStatus = const InitialStatus()});
//
//   final WeatherModel? weatherModel;
//   final double latitude;
//   final double longitude;
//   final AppStatus appStatus;
//
//   MyLocationState copyWith(
//       {WeatherModel? weatherModel,
//       double? latitude,
//       double? longitude,
//       AppStatus? appStatus}) {
//     return MyLocationState(
//         weatherModel: weatherModel ?? this.weatherModel,
//         latitude: latitude ?? this.latitude,
//         longitude: longitude ?? this.longitude,
//         appStatus: appStatus ?? this.appStatus);
//   }
//
//   @override
//   List<Object?> get props => [weatherModel, latitude, longitude, appStatus];
// }
