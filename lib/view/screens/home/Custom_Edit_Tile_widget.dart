// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:car_wash_light/constants/app_images.dart';
import 'package:car_wash_light/constants/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../constants/app_colors.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class CustomEditTile extends StatefulWidget {
  final String text;
  final String? valueText;
  final VoidCallback onTap;
  final bool initialValue;

  CustomEditTile({
    Key? key,
    required this.text,
    this.valueText,
    required this.onTap,
    this.initialValue = false,
  }) : super(key: key);

  @override
  _CustomEditTileState createState() => _CustomEditTileState();
}

class _CustomEditTileState extends State<CustomEditTile> {
  late bool isToggleOn;

  @override
  void initState() {
    super.initState();
    isToggleOn = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Container(
        width: w(context, 170),
        height: h(context, 160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, 20)),
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
                  CustomText(
                    text: isToggleOn ? "On" : "Off",
                    size: 16.5,
                    weight: FontWeight.w700,
                    color: const Color(0xff8C8C8C),
                  ),
                  FlutterSwitch(
                    width: w(context, 47),
                    height: h(context, 29),
                    toggleSize: w(context, 22),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.text,
                          size: 13,
                          weight: FontWeight.w600,
                          paddingBottom: 10,
                        ),
                        if (widget.valueText != null)
                          CustomText(
                            text: widget.valueText!,
                            size: 12.4,
                            weight: FontWeight.w400,
                            color: kGreyColor,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w(context, 2),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: CommonImageView(
                      imagePath: Assets.imagesEdit,
                      height: 22,
                      width: 22,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
