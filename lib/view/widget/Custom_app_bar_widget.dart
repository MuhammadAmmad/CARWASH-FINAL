// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_light/view/widget/Custom_text_widget.dart';
import 'package:car_wash_light/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? iconColor;
  final Color? textColor;
  final String? title;
  final FontWeight fontWeight;
  final double? fontSize;

  CustomAppBar({
    Key? key,
    this.iconColor,
    this.textColor,
    this.title,
    this.fontWeight = FontWeight.w700,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: title != null
          ? CustomText(
              text: title!,
              size: f(context, fontSize ?? 24),
              color: textColor ?? kPrimaryColor,
              weight: fontWeight,
            )
          : null,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColor ?? kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
