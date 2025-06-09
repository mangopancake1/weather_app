import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.color = AppColors.secondaryColor});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: color,
    ));
  }
}

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            message ??
                "Unexpected Error.\nCheck your internet connection and try again.\n(Pull to Refresh)",
            textAlign: TextAlign.center,
          )),
    );
  }
}

class SingleScrollViewCustomized extends StatelessWidget {
  const SingleScrollViewCustomized({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          // height: MediaQuery.of(context).size.height,
          child: child,
        ),
      ),
    );
  }
}

class YellowOnBlackText extends StatelessWidget {
  const YellowOnBlackText(
      {super.key, required this.text, this.fontSize, this.fontWeight});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.normal));
  }
}
