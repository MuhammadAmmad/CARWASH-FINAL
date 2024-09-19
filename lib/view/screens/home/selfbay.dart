// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:car_wash_light/core/utils/firebase/firebase_references.dart';
import 'package:car_wash_light/view/screens/condition/testing_edit.dart';
import 'package:car_wash_light/view/screens/home/edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'Custom_Edit_Tile_widget.dart';

class Selfbay extends StatelessWidget {
  Selfbay({Key? key}) : super(key: key);

  final List<Map<String, String>> customTileData = [
    {
      "text": "Area Lights",
      "valueText": "28,800 Lumens",
      'value': 'driverlessBrightBay'
    },
    {
      "text": "Color Lights",
      "valueText": "52,800 Lumens",
      'value': 'superBrightBay'
    },
    // {"text": "Color Changing Entrance/Exit Addition", 'value': 'colorChanging'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double expandedHeight = h(context, 346);
    final LightController light = Get.find<LightController>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: expandedHeight,
              pinned: true,
              leading: Row(
                children: [
                  Padding(
                    padding: only(
                      context,
                      left: 20,
                      top: 18,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CommonImageView(
                        imagePath: Assets.imagesBack,
                        height: 20,
                        width: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: kTertiaryColor,
              title: CustomText(text: ""),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Padding(
                      padding: only(context, bottom: 112),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: OverflowBox(
                              alignment: Alignment.center,
                              minWidth: constraints.maxWidth * 1.17,
                              minHeight: constraints.maxHeight * 1.17,
                              maxWidth: constraints.maxWidth * 1.17,
                              maxHeight: constraints.maxHeight * 1.17,
                              child: CommonImageView(
                                imagePath: Assets.imagesServebaybg,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // CommonImageView(
                    //   imagePath: Assets.imagesServebaybg,
                    //   fit: BoxFit.contain,
                    //   height: MediaQuery.of(context).size.width * 0.84,
                    // ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff033333),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(h(context, 20)),
                            topRight: Radius.circular(h(context, 20)),
                          ),
                        ),
                        child: Padding(
                          padding: symmetric(
                            context,
                            vertical: 24,
                            horizontal: 21,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: "Self Serve Bays",
                                    size: 20,
                                    weight: FontWeight.w700,
                                    color: kSecondaryColor,
                                    paddingRight: 10,
                                  ),
                                  CommonImageView(
                                    imagePath: Assets.imagesServebaywhite,
                                    height: 22,
                                    width: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h(context, 32),
                              ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: CustomButton(
                              //         buttonText: "Create New Group",
                              //         onTap: () {},
                              //         radius: 5,
                              //         height: 33,
                              //         backgroundColor: kTertiaryColor,
                              //         textColor: kSecondaryColor,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: w(context, 15),
                              //     ),
                              //     Expanded(
                              //       child: CustomButton(
                              //         buttonText: "Remove New Group",
                              //         onTap: () {},
                              //         radius: 5,
                              //         height: 33,
                              //         backgroundColor: kSecondaryColor,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: w(context, 14),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Obx(() {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: w(context, 14),
              mainAxisSpacing: h(context, 13),
            ),
            padding: symmetric(
              context,
              horizontal: 20,
              vertical: 18,
            ),
            itemCount: light.bayNames.length,
            itemBuilder: (context, index) {
              // return Obx(() {
              return CustomEditTile(
                text: light.bayNames[index],
                onTap: () async {
                  light.updateSection(light.bayNames[index].toString());
                  await light.fetchLEDData();

                  Get.to(() => TestingEdit());
                },
                // valueText: customTileData[index]["valueText"],
              );
              // });
            },
          );
        }),
      ),
    );
  }
}
