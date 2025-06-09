import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/appdata/global_widget.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/views/forecast/blocs/forecast_bloc.dart';
import 'package:weather_app/views/forecast/blocs/forecast_event.dart';
import 'package:weather_app/views/home/blocs/home_bloc.dart';
import 'package:weather_app/views/forecast/widgets/forecast_card_list.dart';

import '../../appdata/app_assets.dart';
import '../../appdata/app_colors.dart';
import '../home/blocs/home_event.dart';
import 'blocs/forecast_state.dart';

class ForecastsScreen extends StatelessWidget {
  const ForecastsScreen(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body:
            BlocBuilder<ForecastBloc, ForecastState>(builder: (context, state) {
          if (state.appStatus == const InitialStatus()) {
            context.read<ForecastBloc>().add(
                ForecastInitialEvent());
          }

          return RefreshIndicator(
            backgroundColor: AppColors.secondaryColor,
            color: AppColors.primaryColor,
            onRefresh: () async {
              context.read<ForecastBloc>().add(ForecastRefreshedEvent());
            },
            child: SafeArea(
                minimum:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: state.appStatus is IsLoading
                    ? const CustomLoading()
                    : state.appStatus is IsSuccess
                        ? Column(children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 18),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Prediction",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            context.read<ForecastBloc>().add(
                                                ForecastTypeChangedEvent(
                                                    isDaytime:
                                                        !state.isDayTime));
                                            context.read<HomeBloc>().add(
                                                HomeIsDayTimeChangedEvent(
                                                    isDaytime:
                                                        !state.isDayTime));
                                          },
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.isDayTime
                                                      ? "Day Time"
                                                      : "Night Time",
                                                  style: const TextStyle(
                                                      color: AppColors
                                                          .complementaryColor),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Image.asset(
                                                  state.isDayTime
                                                      ? AppAssets.dayTimeIco
                                                      : AppAssets.nightTimeIco,
                                                  height: 26,
                                                  width: 26,
                                                )
                                              ])),
                                    ])),
                            ForecastCardList(
                                forecastList: state.forecastsModel!.forecasts,
                                isDayTime: state.isDayTime)
                          ])
                        : const OnErrorWidget()),
          );
        }));
  }
}
