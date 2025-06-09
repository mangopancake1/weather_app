import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_app/appdata/app_assets.dart';
import 'package:weather_app/appdata/app_colors.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/global_variables.dart';
import 'package:weather_app/appdata/global_widget.dart';

class LocationCard extends StatelessWidget {
  const LocationCard(
      {super.key,
      required this.locationName,
      required this.temp,
      required this.weatherCondition,
      required this.isCurrentLocation,
      required this.weatherIcon, required this.title, required this.onTapped});

  final String title;
  final String locationName;
  final double temp;
  final String weatherCondition;
  final bool isCurrentLocation;
  final String weatherIcon;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapped(),
      child: Card(
        color: AppColors.secondaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YellowOnBlackText(text: title, fontWeight: FontWeight.bold, fontSize: 22),
                  const SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      YellowOnBlackText(text: locationName),
                      Image.asset(isCurrentLocation ? AppAssets.pinpointYellow : AppAssets.pinpointBlack, height: 20, width: 20)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      YellowOnBlackText(text: weatherCondition),
                      Image(
                          image: CachedNetworkImageProvider(
                              getImgUrl(weatherIcon, "")))
                    ],
                  ),
                ],
              ),
              YellowOnBlackText(text: "${temp.toStringAsFixed(0)}°", fontSize: 26, fontWeight: FontWeight.bold,)
            ],
          ),
        ),
      ),
    );
  }
}