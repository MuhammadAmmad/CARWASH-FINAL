// ignore_for_file: use_key_in_widget_constructors

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widget/Custom_text_widget.dart';
import 'Custom_Color_Selection_Widget.dart';

class LightSceneSelection extends StatelessWidget {
  LightSceneSelection({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    LightController lightController = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: CustomText(
          text: "Light Scene Selection",
          size: 20.6,
          weight: FontWeight.w700,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTertiaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text:
                "Here is a list of lights. Select a light to change its color.",
            size: 13,
            paddingLeft: 20,
            paddingRight: 20,
            paddingTop: screenHeight * 0.02,
            color: kDarkGreyColor,
          ),
          SizedBox(
            height: h(context, 20),
          ),
          Padding(
            padding: symmetric(
              context,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Light ID",
                  size: 14.5,
                  color: kDarkGreyColor,
                ),
                CustomText(
                  text: "Toggle",
                  size: 14.5,
                  color: kDarkGreyColor,
                ),
                CustomText(
                  text: "Color",
                  size: 14.5,
                  color: kDarkGreyColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: lightController.lightForATunnel.length,
                  itemBuilder: (context, index) {
                    final currentLight = lightController.lightForATunnel[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentLight.id,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() {
                            bool isToggled =
                                lightController.toggleStates[currentLight.id] ??
                                    false;
                            return GestureDetector(
                              onTap: () =>
                                  lightController.toggleLight(currentLight.id),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 30,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isToggled
                                      ? Colors.green
                                      : Colors.grey[300],
                                ),
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      top: 3,
                                      left: isToggled ? 30 : 0,
                                      right: isToggled ? 0 : 30,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            icon: Icon(Icons.palette),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: CustomColorSelection(
                                      ledId: currentLight.id,
                                      onClose: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
