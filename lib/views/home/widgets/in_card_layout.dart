import 'package:flutter/cupertino.dart';
import 'package:weather_app/appdata/app_colors.dart';

import '../../../appdata/app_assets.dart';

class InCardLayout extends StatelessWidget {
  const InCardLayout({super.key, required this.value, required this.type});

  final String value;
  final String type;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          switch (type.toLowerCase()) {
            "wind" => AppAssets.windIco,
            "humidity" => AppAssets.humidityIco,
            "visibility" => AppAssets.visibilityIco,
            String() => "",
          },
          width: 48,
          height: 48,
        ),
        const SizedBox(height: 12),
        Text(value, style: const TextStyle(color: AppColors.primaryColor)),
        Text(type, style: const TextStyle(color: AppColors.primaryColor)),
      ],
    );
  }
}
