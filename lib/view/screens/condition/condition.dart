// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import 'Custom_Condition_Widget.dart';
import 'light_Scene_Selection.dart';

class Condition extends StatelessWidget {
  const Condition({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Map<String, String>> conditions = [
      {"condition": "Device 1", "description": "Motion Sensor"},
      {"condition": "Device 2", "description": "24V Trigger"},
      {"condition": "Device 3", "description": "24V Trigger"},
      {"condition": "Device 4", "description": "24V Trigger"},
      {"condition": "Device 5", "description": "24V Trigger"},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(
          text: "Condition",
          size: 20.6,
          weight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: symmetric(
          context,
          horizontal: 20,
          vertical: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "These are available triggers that can be used to\nhave your lights change scenes. Once a trigger is\nactivated, then next light show will play.",
              size: 13.5,
              color: kDarkGreyColor,
            ),
            CustomText(
              text: "Existing Trigger Devices",
              size: 13.6,
              paddingTop: 15,
              paddingBottom: 17,
              color: kTertiaryColor,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Condition",
                        size: 14.5,
                        color: kDarkGreyColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: w(context, 12),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Description",
                        size: 14.5,
                        color: kDarkGreyColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: w(context, 12),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CustomText(
                        text: "Name",
                        size: 14.5,
                        color: kDarkGreyColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: w(context, 12),
                ),
                Column(
                  children: [
                    CustomText(
                      text: "Edit",
                      size: 14.5,
                      color: kDarkGreyColor,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: conditions.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomCondition(
                          condition: conditions[index]["condition"]!,
                          description: conditions[index]["description"]!,
                          onEditTap: () {
                            Get.to(() => LightSceneSelection());
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
