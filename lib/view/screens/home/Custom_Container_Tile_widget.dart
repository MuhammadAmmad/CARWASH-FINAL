// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class CustomContainearTile extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  CustomContainearTile({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomContainearTileState createState() => _CustomContainearTileState();
}

class _CustomContainearTileState extends State<CustomContainearTile> {
  bool isToggleOn = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: w(context, 157),
        height: h(context, 146),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(h(context, 20))),
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ),
        child: Padding(
          padding: all(context, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonImageView(
                    imagePath: widget.imagePath,
                    height: 41,
                    width: 61,
                    fit: BoxFit.contain,
                  ),
                  FlutterSwitch(
                    width: 41,
                    height: 25,
                    toggleSize: w(context, 15),
                    value: isToggleOn,
                    toggleColor: kSecondaryColor,
                    padding: w(context, 4),
                    activeColor: kTertiaryColor,
                    inactiveColor: klightGreyColor,
                    onToggle: (bool value) {
                      setState(() {
                        isToggleOn = value;
                      });
                    },
                  ),
                ],
              ),
              CustomText(
                text: widget.text,
                size: 16.5,
                weight: FontWeight.w700,
                color: const Color(0xff8C8C8C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
