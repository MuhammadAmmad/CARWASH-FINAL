// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../bottombar/bottombar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColor,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage(Assets.imagesWelcomebg),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            text: "The Car Wash\nLighting Experts",
            size: 34,
            lineHeight: 1.1,
            weight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          CustomText(
            text:
                "All products are designed in the USA by car\nwash operators for car washes. If you need\nlights for your wash, trust the company serving\nthe car wash industry for decades.",
            size: 13,
            color: kDarkGreyColor,
            paddingTop: 10,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: h(context, 15),
          ),
          Padding(
            padding: symmetric(
              context,
              horizontal: 45,
            ),
            child: CustomButton3(
              text: 'Get Started',
              onTap: () {
                Get.offAll(() => Bottombar());
              },
            ),
          ),
          SizedBox(
            height: h(context, 20),
          ),
        ],
      ),
    );
  }
}
