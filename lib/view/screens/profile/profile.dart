// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/controllers/location_controller.dart';
import 'package:car_wash_light/view/screens/launch/forget_password.dart';
import 'package:car_wash_light/view/screens/launch/splash_screen.dart';
import 'package:car_wash_light/view/widget/Custom_divider_widget.dart';
import 'package:car_wash_light/view/widget/common_image_view_widget.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../widget/Custom_text_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final AuthController auth = Get.find<AuthController>();
    final LocationController location = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(
          text: "My Profile",
          size: 20.6,
          weight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 23, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            backgroundImage: auth.imageUrl.value.isNotEmpty
                                ? NetworkImage(auth.imageUrl.value)
                                : null,
                            backgroundColor: Colors.black,
                            radius: h(context, 44.5),
                            child: auth.imageLoading.value
                                ? CircularProgressIndicator(
                                    strokeWidth: screenHeight,
                                    color: Colors.black,
                                  )
                                : null,
                          );
                        }),

                        Positioned(
                          top: screenHeight * 0.07,
                          left: screenHeight * 0.03,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              onPressed: () {
                                auth.changeImageLoading(true);
                                print(
                                    "SHAHYK AUTH IMAGE LOADING VARIABLE ${auth.imageLoading.value}");
                                auth.pickFileAndUpload();
                                auth.changeImageLoading(false);
                              },
                              icon: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                        // ICON BUTTON ENDS HERE)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: w(context, 10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: auth.userName.value,
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      CustomText(
                        text: auth.emailText.value,
                        size: 14,
                        paddingBottom: 5,
                      ),
                      // Padding(
                      //   padding: only(
                      //     context,
                      //     right: 95,
                      //   ),
                      //   child: CustomButton3(
                      //     height: 35,
                      //     text: 'Get Started',
                      //     onTap: () {},
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: h(context, 32),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 0.30),
                borderRadius: BorderRadius.circular(h(context, 17)),
              ),
              child: Padding(
                padding: symmetric(
                  context,
                  horizontal: 22,
                  vertical: 25,
                ),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CustomText(
                    //       text: 'Language',
                    //       size: 14,
                    //     ),
                    //     CommonImageView(
                    //       imagePath: Assets.imagesLanguage,
                    //       height: 24,
                    //       width: 24,
                    //       fit: BoxFit.contain,
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: h(context, 10),
                    // ),
                    // CustomDivider(),
                    // SizedBox(
                    //   height: h(context, 10),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        //LOCATION LOGIC
                        // await location.requestLocationPermission(context);
                        await location.requestLocationAndLaunchMap();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Location',
                            size: 14,
                          ),
                          CommonImageView(
                            imagePath: Assets.imagesLocation,
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: h(context, 10),
                    ),
                    CustomDivider(),
                    SizedBox(
                      height: h(context, 10),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CustomText(
                    //       text: 'User Management',
                    //       size: 14,
                    //     ),
                    //     CommonImageView(
                    //       imagePath: Assets.imagesUser,
                    //       height: 24,
                    //       width: 24,
                    //       fit: BoxFit.contain,
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: h(context, 10),
                    // ),
                    // CustomDivider(),
                    // SizedBox(
                    //   height: h(context, 10),
                    // ),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Change password',
                            size: 14,
                          ),
                          CommonImageView(
                            imagePath: Assets.imagesPassword,
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                      onTap: () {
                        Get.to(ForgetPassword(
                          appBarText: 'Change password',
                          bodyText: 'Change your password',
                        ));
                      },
                    ),

                    SizedBox(
                      height: h(context, 10),
                    ),
                    CustomDivider(),
                    SizedBox(
                      height: h(context, 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'About',
                          size: 14,
                        ),
                        CommonImageView(
                          imagePath: Assets.imagesAbout,
                          height: 24,
                          width: 24,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                    SizedBox(
                      height: h(context, 10),
                    ),
                    CustomDivider(),
                    SizedBox(
                      height: h(context, 10),
                    ),

                    GestureDetector(
                      onTap: () async {
                        String? result = await auth.signOut();
                        if (result != null) {
                          showToast(result, Colors.green);
                          Get.off(SplashScreen());
                        } else {
                          showToast("Signout failed!", Colors.red);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Signout',
                            color: Colors.red,
                            size: 16,
                          ),
                          CommonImageView(
                            imagePath: Assets.imagesSignout,
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
