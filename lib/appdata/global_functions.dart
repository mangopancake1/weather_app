import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/appdata/global_variables.dart';

String getImgUrl(String imgId, String? size) {
  return ("${globalVariable.imgBaseUrl}$imgId$size.png");
}


double getScreenHeight() {
  return PlatformDispatcher.instance.views.first.physicalSize.height /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

double getScreenWidth() {
  return PlatformDispatcher.instance.views.first.physicalSize.width /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

void showSnackBar(BuildContext context, String text) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

String dtToReadable(int dt) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
  String formattedDate = DateFormat('EEEE, dd MMMM').format(date.toLocal());
  return formattedDate;
}

void pushToNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}

void pushAndRemoveToNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
    (route) => false,
  );
}

Future<bool?> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return null;
}

bool isDaytime() {
  // Get the current time in the user's local timezone
  DateTime now = DateTime.now();

  // Define the start and end times for daytime
  DateTime startDayTime = DateTime(now.year, now.month, now.day, 6, 0); // 6:00 AM
  DateTime endDayTime = DateTime(now.year, now.month, now.day, 18, 0);  // 6:00 PM

  // Check if the current time is between the start and end times
  return now.isAfter(startDayTime) && now.isBefore(endDayTime);
}
