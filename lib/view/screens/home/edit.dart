// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:car_wash_light/core/utils/custom_snackbars.dart';
import 'package:car_wash_light/model/led_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../../core/utils/firebase/firebase_references.dart';
import '../../widget/Custom_text_widget.dart';
import '../condition/light_Scene_Selection.dart';

class Edit extends StatefulWidget {
  Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  LightController lightController = Get.find();
  List<bool> isSelected = [false, false, false, false, false];
  LightController light = Get.find<LightController>();

  //commenting this as I am using a reference globally
  // final DatabaseReference _databaseRef =
  //     FirebaseDatabase.instance.ref().child('wled');

  // Fetch data for LEDs
  Future<List<LedModel>> fetchLEDData() async {
    DataSnapshot snapshot = await tunnel49DatabaseReference.get();
    DataSnapshot tunnelSnapshot = await tunnelBay.get();
    List<LedModel> tunnelLeds = [];
    List<LedModel> leds = [];
    //BELOW I HAVE UPDATED THE CODE FROM SNAPSHOT TO TUNNELSNAPSHOT AND ALSO FROM LEDS INTO TUNNELLEDS INCASE OF LISTS
    if (tunnelSnapshot.exists) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(snapshot.value as Map);
      data.forEach((key, value) {
        tunnelLeds.add(LedModel.fromJson(Map<String, dynamic>.from(value)));
      });
    }
    //ALSO I HAVE CHANGED THE RETURN VALUE
    return tunnelLeds;
  }

  // Update the state of an LED in the database
  Future<void> updateLEDState(String ledId, String newState) async {
    await tunnelBay.child(ledId).update({
      'brightness': '255',
      'state': newState,
    });
  }

  // Toggle selection and update LED state
  void toggleSelection(int index) async {
    List<LedModel> leds = await fetchLEDData();
    List<LedModel> tunnelLeds = await fetchLEDData();
    String currentState = tunnelLeds[index].state;
    String newState = currentState == 'off' ? 'on' : 'off';

    print(newState);
    await updateLEDState("led${index + 1}", newState);

    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kTertiaryColor,
        titleSpacing: 0,
        title: CustomText(
          text: "Edit",
          color: Colors.white,
          size: 20,
          weight: FontWeight.w700,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kSecondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("SHAHYK JAHAN TUNNEL BAY PATH ${tunnelBay.path}");

          print("SHAHYK JAHAN TUNNEL NAME PATH ${lightController.tunnelName}");

          print(
              "SHAHYK JAHAN TUNNEL BAY PATH ${lightController.tunnelBayTest.path}");

          showPleaseWaitDialog(context);
          //In between perform any asynchronous operation

          await lightController.fetchLEDData();

          Get.close(1);

          Get.to(() => LightSceneSelection());
        },
        backgroundColor: kTertiaryColor,
        child: Icon(
          Icons.color_lens,
        ),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Available Lights",
                        size: 14,
                        weight: FontWeight.w400,
                        color: Color(0xff8E8E8E),
                      ),
                      SizedBox(height: h(context, 15)),
                      //HAVE REMOVED THE ADD TO GROUP AND REMOVE TO GROUP

                      // CustomText(
                      //   text: "Add to\nGroup",
                      //   size: 14,
                      //   weight: FontWeight.w400,
                      //   color: Color(0xff8E8E8E),
                      // ),
                      // SizedBox(height: h(context, 15)),
                      // CustomText(
                      //   text: "Remove\nfrom Group",
                      //   size: 14,
                      //   weight: FontWeight.w400,
                      //   color: Color(0xff8E8E8E),
                      // ),
                      SizedBox(height: h(context, 25)),
                      //ADDING HERE AN OBX
                      // Obx(() {
                      //   return
                      GestureDetector(
                        onTap: () async {
                          print(
                              "SHAHYK JAHAN TUNNEL BAY PATH ${tunnelBay.path}");

                          print(
                              "SHAHYK JAHAN TUNNEL NAME PATH ${lightController.tunnelName}");

                          print(
                              "SHAHYK JAHAN TUNNEL BAY PATH ${lightController.tunnelBayTest.path}");

                          showPleaseWaitDialog(context);
                          //In between perform any asynchronous operation

                          await lightController.fetchLEDData();

                          Get.close(1);

                          Get.to(() => LightSceneSelection());
                        },
                        child: CustomText(
                          text: "Condition",
                          size: 14,
                          weight: FontWeight.w400,
                          color: Color(0xff8E8E8E),
                        ),
                      ),
                      // }),

                      SizedBox(height: h(context, 24)),
                      CustomText(
                        text: "Active",
                        size: 14,
                        weight: FontWeight.w400,
                        color: Color(0xff8E8E8E),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: only(context, left: 8),
                    child: LightItem(
                      lightText: "Light ${i + 1}",
                      isSelected: isSelected[i],
                      onAddTap: () => toggleSelection(i),
                      onRemoveTap: () => toggleSelection(i),
                      screenWidth: screenWidth,
                      ledId: "led${i + 1}", // Pass LED ID
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LightItem extends StatefulWidget {
  final String lightText;
  final bool isSelected;
  final VoidCallback onAddTap;
  final VoidCallback onRemoveTap;
  final double screenWidth;
  final String ledId; // Add LED ID or identifier

  const LightItem({
    Key? key,
    required this.lightText,
    required this.isSelected,
    required this.onAddTap,
    required this.onRemoveTap,
    required this.screenWidth,
    required this.ledId, // Initialize LED ID
  }) : super(key: key);

  @override
  State<LightItem> createState() => _LightItemState();
}

class _LightItemState extends State<LightItem> {
  bool isConToggleOn = false;
  bool islightToggleOn = false;

  // final DatabaseReference _databaseRef =
  //     FirebaseDatabase.instance.ref().child('wled');

  @override
  Widget build(BuildContext context) {
    final LightController light = Get.find<LightController>();
    final DatabaseReference tunnelBay = FirebaseDatabase.instance
        .ref()
        .child('tunnelBay')
        .child(light.tunnelName.value);

    Future<void> updateLEDState(String newState) async {
      String newBrightness = '';
      if (newState == 'off') {
        newBrightness = '00';
      } else {
        newBrightness = '255';
      }
      print(widget.ledId);
      print(newState);
      await tunnelBay.child(widget.ledId).update({
        'brightness': newBrightness,
        'state': newState,
      });
    }

    return Column(
      children: [
        CustomText(
          text: widget.lightText,
          size: 13.1,
          weight: FontWeight.w400,
        ),
        SizedBox(height: h(context, 10)),
        // GestureDetector(
        //   onTap: widget.onAddTap,
        //   child: Container(
        //     width: w(context, 16),
        //     height: h(context, 15),
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Color(0xff878787)),
        //     ),
        //     child: widget.isSelected
        //         ? Center(
        //             child: Icon(
        //               Icons.check,
        //               size: h(context, 12),
        //               color: kTertiaryColor,
        //             ),
        //           )
        //         : null,
        //   ),
        // ),
        // SizedBox(height: widget.screenWidth * 0.09),
        // GestureDetector(
        //   onTap: widget.onRemoveTap,
        //   child: Container(
        //     width: w(context, 16),
        //     height: h(context, 15),
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Color(0xff878787)),
        //     ),
        //     child: widget.isSelected
        //         ? Center(
        //             child: Icon(
        //               Icons.check,
        //               size: h(context, 12),
        //               color: kTertiaryColor,
        //             ),
        //           )
        //         : null,
        //   ),
        // ),
        SizedBox(height: h(context, 24)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: isConToggleOn ? "Active" : "InAct",
              size: 12.5,
              weight: FontWeight.w400,
              color: const Color(0xff8C8C8C),
              paddingBottom: 5,
            ),
            FlutterSwitch(
              width: w(context, 38),
              height: h(context, 18),
              toggleSize: w(context, 14),
              value: isConToggleOn,
              toggleColor: kSecondaryColor,
              padding: w(context, 4),
              activeColor: kTertiaryColor,
              inactiveColor: klightGreyColor,
              onToggle: (bool value) async {
                setState(() {
                  isConToggleOn = value;
                });
                // Update the LED state in Firebase
                await updateLEDState(isConToggleOn ? 'on' : 'off');
              },
            ),
          ],
        ),
        SizedBox(height: h(context, 15)),
        Column(
          children: [
            CustomText(
              text: islightToggleOn ? "Active" : "InAct",
              size: 12.5,
              weight: FontWeight.w400,
              color: const Color(0xff8C8C8C),
              paddingBottom: 5,
            ),
            FlutterSwitch(
              width: w(context, 38),
              height: h(context, 18),
              toggleSize: w(context, 14),
              value: islightToggleOn,
              toggleColor: kSecondaryColor,
              padding: w(context, 4),
              activeColor: kTertiaryColor,
              inactiveColor: klightGreyColor,
              onToggle: (bool value) async {
                setState(() {
                  islightToggleOn = value;
                });
                await updateLEDState(islightToggleOn ? 'on' : 'off');
              },
            ),
          ],
        ),
      ],
    );
  }
}
