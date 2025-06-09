import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/views/home/widgets/in_card_layout.dart';
import '../../../appdata/app_colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.speed,
      required this.humidity,
      required this.visibility});

  final double speed;
  final int humidity;
  final int visibility;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InCardLayout(
                value: "${(speed * 3.6).toStringAsFixed(2)} km/h",
                type: "Wind",
              ),
              InCardLayout(value: "$humidity%", type: "Humidity"),
              InCardLayout(value: "${visibility / 1000} km", type: "Visibility")
            ],
          ),
        ));
  }
}
