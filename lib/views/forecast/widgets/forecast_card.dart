import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../appdata/app_assets.dart';
import '../../../appdata/global_functions.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard(
      {super.key,
      required this.dateText,
      required this.temp,
      required this.weatherCondition,
      this.weatherIcon = ""});

  final String dateText;
  final String temp;
  final String weatherCondition;
  final String weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateText),
              Text(temp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(weatherCondition),
                  weatherIcon != ""
                      ? Image(
                          image: CachedNetworkImageProvider(
                              getImgUrl(weatherIcon, "")),
                          height: 24,
                          width: 24,
                        )
                      : Image.asset(
                          AppAssets.brokenImageIco,
                          height: 24,
                          width: 24,
                        ),
                ],
              )
            ],
          )),
    );
  }
}
