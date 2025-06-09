import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/appdata/app_assets.dart';
import 'package:weather_app/appdata/app_colors.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/global_widget.dart';
import 'package:weather_app/appdata/my_shared_preferences.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:weather_app/views/home/blocs/home_bloc.dart';
import 'package:weather_app/views/home/blocs/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/views/forecast/forecasts_screen.dart';
import 'package:weather_app/views/home/widgets/home_forecast_list.dart';
import 'package:weather_app/views/home/widgets/home_main_status_card.dart';
import 'package:weather_app/views/mylocations/my_locations_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'blocs/home_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print("isDayTime state HomeScreen: ${state.isDayTime}");
          print("latlong in HomeScreen: ${state.latitude}, ${state.longitude}");
          if (state.appStatus == const InitialStatus()) {
            context.read<HomeBloc>().add(HomeGetWeatherEvent());
          }

          return RefreshIndicator(
              backgroundColor: AppColors.secondaryColor,
              color: AppColors.primaryColor,
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeRefreshedEvent());
              },
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        // padding: const EdgeInsets.only(top: 50),
                        child: state.appStatus is IsLoading
                            ? const CustomLoading()
                            : state.appStatus is IsSuccess
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () =>
                                                      pushToNextScreen(
                                                          context,
                                                          MyLocationsScreen(
                                                              weatherData: state
                                                                  .weatherModel!)),
                                                  icon: Image.asset(
                                                    AppAssets.plusRoundedIco,
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                ),
                                                // Spacer untuk memastikan Row tetap memiliki lebar penuh
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                            // Teks yang diposisikan tepat di tengah
                                            Text(
                                              "${state.weatherModel!.name} , ${state.weatherModel!.sys.country}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              color: AppColors.secondaryColor,
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(
                                                    state.currentDate,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .primaryColor),
                                                  )),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              state.weatherModel!.weather[0]
                                                  .main,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20),
                                            ),
                                            state.weatherModel!.weather[0]
                                                        .icon !=
                                                    ""
                                                ? Image(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            getImgUrl(
                                                                state
                                                                    .weatherModel!
                                                                    .weather[0]
                                                                    .icon,
                                                                "@4x")),
                                                    height: 48,
                                                    width: 48,
                                                  )
                                                : Image.asset(
                                                    AppAssets.brokenImageIco,
                                                    width: 52,
                                                    height: 52,
                                                  ),
                                          ],
                                        ),
                                        Text(
                                          "${state.weatherModel!.main.temp}°",
                                          style: const TextStyle(
                                              fontSize: 98,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        HomeCard(
                                            speed:
                                                state.weatherModel!.wind.speed,
                                            humidity: state
                                                .weatherModel!.main.humidity,
                                            visibility:
                                                state.weatherModel!.visibility),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Weekly forecast",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: AppColors
                                                              .secondaryColor),
                                                    ),
                                                    Text(state.isDayTime
                                                        ? "Day Time"
                                                        : "Night Time"),
                                                  ]),
                                              IconButton(
                                                  onPressed: () =>
                                                      pushToNextScreen(context,
                                                          const ForecastsScreen()),
                                                  icon: Image.asset(
                                                    AppAssets.longArrowIco,
                                                    width: 68,
                                                    height: 68,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        HomeForecastList(
                                          forecastsData:
                                              state.forecastsModel!.forecasts,
                                          isDayTime: state.isDayTime,
                                        )
                                      ])
                                : OnErrorWidget(
                                    message:
                                        '${state.errorMsg}\n(Pull to Refresh)')),
                  )));
        },
      ),
    );
  }
}
