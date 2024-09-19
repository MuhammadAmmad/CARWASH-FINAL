import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomCircularIndicator extends StatelessWidget {
  CustomCircularIndicator(
      {this.width = 100,
        this.height = 55,
        this.containerColor = kPrimaryColor,
        this.indicatorColor = Colors.white,
        this.radius = 10,
        this.paddingTop = 0,
        this.paddingBottom = 0,
        this.paddingLeft = 0,
        this.paddingRight = 0});

  double width, height, radius;
  double paddingLeft, paddingRight, paddingTop, paddingBottom;

  Color containerColor, indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        ),
      ),
    );
  }
}
