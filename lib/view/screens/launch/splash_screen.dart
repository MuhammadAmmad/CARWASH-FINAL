// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';
import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/view/screens/launch/authentication_wrapper.dart';
import 'package:car_wash_light/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  void splashScreenHandler() {
    Timer(
      Duration(seconds: 3),
      () => Get.offAll(() => AuthenticationWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesLogo,
              height: h(context, 139),
            ),
            CustomText(
              text: "CAR WASH",
              size: 24,
              color: Color(0xff115E35),
            ),
            CustomText(
              text: "LIGHTS",
              size: 24,
              color: Color(0xff115E35),
            ),
            CustomText(
              text: "FORMERLY “MILE HIGH LED SYSTEMS”",
              size: 12,
              weight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }
}
