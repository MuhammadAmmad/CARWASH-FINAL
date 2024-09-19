// ignore_for_file: prefer_const_constructors

import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'Custom_Container_Tile_widget.dart';
import 'inbay.dart';
import 'selfbay.dart';
import 'tunnel.dart';
import 'vaccum.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    final LightController light = Get.find<LightController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(context, 97),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff033333),
        title: Row(
          children: [
            Obx(() {
              return CircleAvatar(
                backgroundImage: auth.imageUrl.value.isNotEmpty
                    ? NetworkImage(auth.imageUrl.value)
                    : null,
                backgroundColor: kSecondaryColor,
                radius: h(context, 30.5),
                child: auth.imageUrl.value.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 50,
                      )
                    : null,
              );
            }),
            SizedBox(width: w(context, 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() {
                      return CustomText(
                        text: "Hello ${auth.userName}",
                        size: 25,
                        weight: FontWeight.w700,
                        color: kSecondaryColor,
                        paddingRight: w(context, 4),
                      );
                    }),
                    CommonImageView(
                      imagePath: Assets.imagesHand,
                      height: 20,
                      width: 30,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                CustomText(
                  text: "Welcome to Car Wash Lights",
                  size: 12.5,
                  weight: FontWeight.w400,
                  color: kGreyColor,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                Assets.imagesAdd,
                height: h(context, 35),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xff033333),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(h(context, 20)),
            topRight: Radius.circular(h(context, 20)),
          ),
        ),
        width: w(context, double.maxFinite),
        height: h(context, 630),
        child: Padding(
          padding: only(
            context,
            left: 25,
            right: 25,
            top: 37,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomContainearTile(
                    imagePath: Assets.imagesGard,
                    text: "Tunnels /Bay Lighting",
                    onTap: () {
                      // light.updateControllerSection('tunnelBay');
                      light.updateControllerSection('tb');

                      Get.to(() => Tunnel());
                    },
                  ),
                  SizedBox(
                    width: w(context, 15),
                  ),
                  CustomContainearTile(
                    imagePath: Assets.imagesVaccum,
                    text: "Vacuum and Pay Canopy Areas",
                    onTap: () {
                      // light.updateControllerSection('vaccumArches');
                      light.updateControllerSection('va');

                      Get.to(() => Vaccum());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 16.5),
              ),
              Row(
                children: [
                  CustomContainearTile(
                    imagePath: Assets.imagesBay,
                    text: "In-Bay Automatic",
                    onTap: () {
                      // light.updateControllerSection('inBayAutomatic');
                      light.updateControllerSection('iba');

                      Get.to(() => Inbay());
                    },
                  ),
                  SizedBox(
                    width: w(context, 15),
                  ),
                  CustomContainearTile(
                    imagePath: Assets.imagesServebay,
                    text: "Self Serve Bays",
                    onTap: () async {
                      // light.updateControllerSection('selfServeBays');
                      light.updateControllerSection('ssb');

                      print(
                          "HERE ARE THE VALUE SHAHYK: ${light.controllerName.value}");

                      Get.to(() => Selfbay());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 29),
              ),
              CommonImageView(
                imagePath: Assets.imagesImage,
                height: 154,
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
