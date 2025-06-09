import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../appdata/app_assets.dart';
import '../../../appdata/app_colors.dart';
import '../../../appdata/global_functions.dart';

class HomeForecastCard extends StatelessWidget {
  const HomeForecastCard(
      {super.key,
      required this.temp,
      required this.weatherIcon,
      required this.date});

  final String temp;
  final String weatherIcon;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        padding: const EdgeInsets.only(bottom: 28),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                  color: AppColors.secondaryColor, width: 2.5)),
          color: AppColors.primaryColor,
          child: Center(
            widthFactor: 2,
            heightFactor: 2.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  temp,
                  style: const TextStyle(fontSize: 20),
                ),
                weatherIcon != ""
                    ? Image(
                  image: CachedNetworkImageProvider(
                      getImgUrl(weatherIcon, "")),
                  height: 52,
                  width: 52,
                )
                    : Image.asset(
                        AppAssets.brokenImageIco,
                        width: 52,
                        height: 52,
                      ),
                Text(
                  date,
                  style: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 18),
                )
              ],
            ),
          ),
        ));
  }
}
