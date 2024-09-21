// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

// ignore: must_be_immutable

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.height,
    this.textSize,
    this.weight,
    this.width,
    this.radius,
    this.backgroundColor,
    this.textColor,
    this.circularProgressIndicator,
  });
  // final Widget? circleProgress;
  final CircularProgressIndicator? circularProgressIndicator;
  final String buttonText;
  final VoidCallback onTap;
  final double? height, textSize, radius, width;
  final FontWeight? weight;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h(context, height ?? 48),
        width: w(context, width ?? double.maxFinite),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, radius ?? 28)),
          color: backgroundColor ?? kQuaternaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: kSecondaryColor.withOpacity(0.1),
            highlightColor: kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(radius ?? 28),
            child: Center(
              child: auth.isLoading.value
                  ? circularProgressIndicator
                  : Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: f(context, textSize ?? 14),
                        fontWeight: weight ?? FontWeight.w400,
                        color: textColor ?? kPrimaryColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const CustomButton2({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          // border: Border.all(
          //   color: klightGreyColor,
          //   width: 1,
          // ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [kQuaternaryColor, kTertiaryColor],
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              size: 14,
              color: kPrimaryColor,
              weight: FontWeight.w600,
              paddingRight: 16,
            ),
            CommonImageView(
              imagePath: imagePath,
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final String? imagePath;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double? height;

  const CustomButton3({
    Key? key,
    this.imagePath,
    required this.text,
    required this.onTap,
    this.height,
    this.backgroundColor = kTertiaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h(context, height ?? 45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, 12)),
          border: Border.all(
            color: kQuaternaryColor,
            width: 1,
          ),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              CommonImageView(
                imagePath: imagePath!,
                height: 14,
              ),
            CustomText(
              text: text,
              size: 15,
              weight: FontWeight.w700,
              color: kSecondaryColor,
              paddingLeft: imagePath != null ? 16 : 0,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.height = 48,
    this.textSize,
    this.weight,
    this.radius,
    this.width = 178,
    required this.imagePath,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height, textSize, radius, width;
  final FontWeight? weight;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: kTertiaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Image.asset(
                  imagePath!,
                  height: 15,
                ),
              Center(
                child: CustomText(
                  text: buttonText,
                  size: textSize ?? 16,
                  weight: weight ?? FontWeight.w500,
                  color: kSecondaryColor,
                  paddingLeft: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
